pageextension 50059 MyExtension1 extends "Cash Receipt Journal"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        addafter(Post)
        {
            action("Cash Receipt Voucher")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    GenJnl.SetRange("Journal Template Name", "Journal Template Name");
                    GenJnl.SetRange("Document No.", "Document No.");
                    Report.RunModal(50004, true, FALSE, GenJnl);
                end;

            }
        }
    }

    var
        GenJnl: Record "Gen. Journal Line";
}