report 50003 "JV After Post"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'JV After Post';
    DefaultLayout = RDLC;
    RDLCLayout = './JV After Post.rdl';


    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Document No.");
            RequestFilterFields = "Document No.";
            column(Document_No_; "Document No.")
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(G_L_Account_No_; "G/L Account No.")
            {

            }
            column(Description; Description)
            {


            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(Credit_Amount; "Credit Amount")
            {

            }
            column(Amountinwords; AmountInWords)
            {

            }
            column(txt; txt) { }
            column(dim1; dim1)
            {

            }
            column(dim2; dim2)
            {

            }
            column(CompInfoPicture; CompInfo.Picture) { }
            trigger OnAfterGetRecord()
            begin
                GLSetup.Get();
                dim1 := GLSetup."Global Dimension 1 Code";
                dim2 := GLSetup."Global Dimension 2 Code";

                GLEntry.SETRANGE("Document No.", "Document No.");
                IF GLEntry.FINDSET THEN
                    REPEAT
                        AmtGl := ABS(GLEntry.Amount);
                    UNTIL GLEntry.NEXT = 0;

                Amount := ROUND(AmtGl, 0.01);
                Repcheck.InitTextVariable;

                GenJournalLine.SETRANGE("Document No.", "Document No.");
                Repcheck.FormatNoText(NoText, AmtGl, 'AED');

                AmountInWords := NoText[1];


                IF "G/L Entry"."Source Code" = 'GENJNL' THEN
                    txt := 'Journal'
                ELSE
                    IF "G/L Entry"."Source Code" = 'CASHRECJNL' THEN
                        txt := 'Cash Receipt'

                    ELSE
                        IF "G/L Entry"."Source Code" = 'PAYMENTJNL' THEN
                            txt := 'Payment'
                        else
                            txt := 'Journal';

                CompInfo.get;
                CompInfo.CalcFields(Picture);




            end;

        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        AmountInWords: Text;
        CompInfo: Record "Company Information";
        Repcheck: Report Check;
        NoText: array[2] of text;
        AmtGl: Decimal;
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
        txt: Text[50];
        GenJournalLine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        dim1: text[50];
        dim2: text[50];
        DimensionSetEntry: Record "Dimension Set Entry";
        Dimension2: Text[50];
}