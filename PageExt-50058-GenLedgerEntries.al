pageextension 50058 genledgerentries extends "General Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addfirst(navigation)
        {
            action("Print Voucher")
            {
                Caption = 'Print Voucher';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    glentry.SetRange("Document No.", "Document No.");
                    Report.RunModal(50003, true, false, glentry);
                end;
            }
        }
    }

    var
        glentry: Record "G/L Entry";
}