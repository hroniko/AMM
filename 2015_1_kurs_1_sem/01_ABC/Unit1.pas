///////////////////////////////////////////////
// ���������  ������� �������  ������������� //
// ��������������� ������������ ��  ���� ��� //
// ������ (����������� �����). ������� ����� //
// ������  ������������ �  ������� � ������� //
// ����������� (������  ���  ��������������� //
// ������������� ������������)               //
// �����: Anatoly                            //
// ���, 1 ����, �/�, ��. 12, 16 �������      //
// 2015-09-10                                //
///////////////////////////////////////////////

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm1 = class(TForm)
    mmo_Output: TMemo;
    btn_OK: TButton;
    grp_A: TGroupBox;
    edt_A_x: TEdit;
    lbl_A_x: TLabel;
    lbl_A_y: TLabel;
    edt_A_y: TEdit;
    grp_B: TGroupBox;
    lbl_B_x: TLabel;
    lbl_B_y: TLabel;
    edt_B_x: TEdit;
    edt_B_y: TEdit;
    grp_C: TGroupBox;
    lbl_C_x: TLabel;
    lbl_C_y: TLabel;
    edt_C_x: TEdit;
    edt_C_y: TEdit;
    grp_Zadanie: TGroupBox;
    lbl_Zadanie: TLabel;
    procedure btn_OKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn_OKClick(Sender: TObject);  // ��������� ��������� ������� ������ � ���������� ������� ������������ ��� ���������� ���� �������
var x1, y1, x2, y2, x3, y3: Extended;    // ���������� �����
    AB, BC, AC: Extended;  // ����� ������ ������������
    LMax, LMin: Extended;  // ������������ � ����������� ����� ������ ������������
    H, S: Extended; // ������ � ������� ������������
    H1: Extended; // ������ � ������ ������ ������������
begin
    mmo_Output.Clear;
    // 1. �������� ��������� ���������� ����� � �����:
    try
      x1:= StrToFloat(edt_A_x.Text);
      y1:= StrToFloat(edt_A_y.Text);
      x2:= StrToFloat(edt_B_x.Text);
      y2:= StrToFloat(edt_B_y.Text);
      x3:= StrToFloat(edt_C_x.Text);
      y3:= StrToFloat(edt_C_y.Text);
    except
      mmo_Output.Lines.Add('�� ������� ��������� ��� ���������� �����!');
      mmo_Output.Lines.Add('��������� ������������ ��������� ������!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('���������� �����������!');
      Exit // � ��������� ������������
    end;

    // 2. ���� ��������� ���������� � �� �������� ���������� ��� ��������������, ��
    // ���������, �� ��������� �� �����:
    if ((x1 = x2) and (y1 = y2)) or ((x1 = x3) and (y1 = y3)) or ((x3 = x2) and (y3 = y2)) then   // ���� ����� ��� ����� �������, ��
      begin
        mmo_Output.Lines.Add('������� ���������� ����������� �����!');
        mmo_Output.Lines.Add('������ ������ �� �������� �������������!');
        mmo_Output.Lines.Add('');
        mmo_Output.Lines.Add('���������� �����������!');
        Exit // � ��������� ������������
      end;

    // 3. ���� ����� �� �������, ��������� ����� ������ ������������:
    AB:= Sqrt(Power((x1 - x2), 2) + Power((y1 - y2), 2));
    BC:= Sqrt(Power((x2 - x3), 2) + Power((y2 - y3), 2));
    AC:= Sqrt(Power((x1 - x3), 2) + Power((y1 - y3), 2));


    // 4. ���������, ������������� �� ������� �������� ������������ ������
    // (���� ����� ���� ������ ������ ��� ����� �������, �� ��� �� ����������)
    if ( ((AB+BC) <= AC) or ((AB+AC) <= BC) or ((BC+AC) <= AB) ) then
    begin
      mmo_Output.Lines.Add('������ ������ �� �������� �������������!');
      mmo_Output.Lines.Add('����� ���� ���� ������ �� ��������� ����� �������!');
      mmo_Output.Lines.Add('AB= ' + FloatToStrF(AB,fffixed,8,3)
      + '; BC= ' + FloatToStrF(BC,fffixed,8,3)
      + '; AC= ' + FloatToStrF(AC,fffixed,8,3));
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('���������� �����������!');
      Exit // � ��������� ������������
    end;

    // 5. ���������, �������� �� ����������� ��������������, � ���� ��, �� ������� ��� ��������� (������� �������) � ������� ������� (�������):
    if (AB = BC) then
      begin
        LMin:= AB;
        LMax:= AC;
      end
    else
      if (AB = AC) then
        begin
          LMin:= AB;
          LMax:= BC;
        end
      else
        if (BC = AC) then
          begin
            LMin:= BC;
            LMax:= AB;
          end
        else   // ���� ��� ������ ������, ���������� �� ��������������
          begin
            mmo_Output.Lines.Add('������ ����������� �� �������� ��������������!');
            mmo_Output.Lines.Add('');
            mmo_Output.Lines.Add('���������� �����������!');
            Exit // � ��������� ������������
          end;

     // 6. ���� �� ���������� ���� �� ����� �� ������������, �� ����������� ��������������,
     // ���������, �������� �� �� ������������:
     if ( (Power(LMax, 2)) > (Power(LMin, 2) * 2.0)  )  then     // ���� ������� ������� ������� ������ ���������� �������� �������, �� ����������� ������������
       begin
         mmo_Output.Lines.Add('����������� �������� �������������� � ������������!');
       end
     else
       begin
         mmo_Output.Lines.Add('������ ����������� �������� ��������������, ��');
         mmo_Output.Lines.Add('�� �������� ������������!');
         mmo_Output.Lines.Add('');
         mmo_Output.Lines.Add('���������� �����������!');
         Exit // � ��������� ������������
       end;

     // 7. ���� �� ���������� ���� �� ����� �� ������������, �� ��������� ������ � �������:
     H:= Sqrt( Power(LMin, 2) - Power( (LMax/2), 2) ); // ������������ ������� ��������


     S:= 0.5 * LMax * H;  // ������������ ������� ������� ������������

     if (AB > AC) or (BC > AC) then  // ���� �� - ������� �������, ��

         H1:= 2.0 * S / AC

     else
         H1:=  2.0 * S / AB;


     mmo_Output.Lines.Add('����� �������  (�������)  �������: ' + FloatToStrF(LMin,fffixed,8,3));
     mmo_Output.Lines.Add('����� ��������� (������� �������): ' + FloatToStrF(LMax,fffixed,8,3));
     mmo_Output.Lines.Add('������ ������������ H = ' + FloatToStrF(H,fffixed,8,3)+ '; ' + FloatToStrF(H1,fffixed,8,3)+ '; ' + FloatToStrF(H1,fffixed,8,3));
     mmo_Output.Lines.Add('������� ������������ S = ' + FloatToStrF(S,fffixed,8,3));

     // 8. �� ������� ������� ����� ������ � ������� � ������� �����������:
     mmo_Output.Lines.Add('');
     mmo_Output.Lines.Add('����� ������ � ������� � ������� �����������: ');
     if (S > LMax) then  mmo_Output.Lines.Add( FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(LMax,fffixed,8,3) + '; '  + FloatToStrF(S,fffixed,8,3) )
     else
       if (S < LMin) then  mmo_Output.Lines.Add( FloatToStrF(S,fffixed,8,3) + '; ' + FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(LMin,fffixed,8,3) + '; '  + FloatToStrF(LMax,fffixed,8,3) )
       else mmo_Output.Lines.Add( FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(S,fffixed,8,3) + '; '  + FloatToStrF(LMax,fffixed,8,3) )
end;

end.
