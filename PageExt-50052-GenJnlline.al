pageextension 50052 GenJnlLine extends "General Journal"
{
    layout
    {

    }

    actions
    {
        addafter(Post)
        {
            action("JV Print")
            {
                Caption = 'Vocuher Print';
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
        myInt: Integer;
        GLBudgetEntry: Record "G/L Budget Entry";
        CurrentJnlBatchName: code[10];
        GenJnl: Record "Gen. Journal Line";
}