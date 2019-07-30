codeunit 50401 "VAG My Ext Management Lib"
{
    trigger OnRun()
    begin

    end;

    procedure OpenItemGroupList(Notif: Notification)
    begin
        Page.Run(Page::"VAG Item Group List");
    end;

    procedure DisableItemGroupNotification(Notif: Notification)
    var
        MyNotifications: Record "My Notifications";

    begin
        MyNotifications.Disable(Notif.Id());
    end;

    procedure ApplyDefaultItemGroup()
    var
        Item: Record Item;
        ItemSetup: Record "VAG Item Setup";
        EndOfProcessMsg: Label 'End Of Process';
        NothingToDoMsg: Label 'Nothing To Do';
    begin
        // récupère les données du record
        ItemSetup.Get();
        // teste si le champ est renseigné
        ItemSetup.TestField("Default Item Code");
        with Item do begin
            // si on ne met rien après la virgule, le filtre est annulé
            Item.SetRange("VAG Item Group Code", '');
            // ou > Item.SetFilter("VAG Item Group Code", '%1','');
            if Item.FindSet(true, false) then begin
                repeat
                    Item."VAG Item Group Code" := ItemSetup."Default Item Code";
                    Item.Modify();
                until Item.Next() = 0;
                Message(EndOfProcessMsg);
            end
            else begin
                Message(NothingToDoMsg);
                exit;
            end;
        end;
    end;

    procedure ApplyDefaultItemGroup2()
    var
        Item: Record Item;
        ItemSetup: Record "VAG Item Setup";
        EndOfProcessMsg: Label 'End Of Process';
        NothingToDoMsg: Label 'Nothing To Do';
    begin
        // récupère les données du record
        ItemSetup.Get();
        // teste si le champ est renseigné
        ItemSetup.TestField("Default Item Code");
        with Item do begin
            // si on ne met rien après la virgule, le filtre est annulé
            Item.SetRange("VAG Item Group Code", '');
            // ou > Item.SetFilter("VAG Item Group Code", '%1','');
            if not IsEmpty() then begin
                ModifyAll(Item."VAG Item Group Code", ItemSetup."Default Item Code");
                Message(EndOfProcessMsg);
            end
            else begin
                Message(NothingToDoMsg);
                exit;
            end;
        end;
    end;
}