pageextension 50055 PaymentJournal extends "Payment Journal"
{
    layout
    {

    }


    actions
    {
        // Add changes to page actions here
        addafter("P&osting")
        {

            action("Payment Voucher")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;


                trigger OnAction()
                var
                    genjnlline: Record "Gen. Journal Line";
                begin
                    genjnlline.Reset();
                    genjnlline.SetRange("Document No.", "Document No.");
                    if genjnlline.FindFirst() then
                        Report.RunModal(50004, true, false, genjnlline);
                end;
            }

        }
    }

    var
        myInt: Integer;
        GLBudgetEntry: Record "G/L Budget Entry";
}