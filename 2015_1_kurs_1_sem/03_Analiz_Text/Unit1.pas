///////////////////////////////////////////////
// ���������  ������� ������ �� �����������  //
// ��������                                  //
// �����: Anatoly                            //
// ���, 1 ����, �/�, ��. 12, 3 �������       //
// (�16, ���. 103)                           //
// 2015-10-02                                //
///////////////////////////////////////////////

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls;

type
  TForm1 = class(TForm)
    grp1: TGroupBox;
    grp2: TGroupBox;
    btn_OK: TButton;
    mmo1: TMemo;
    mmo_Input: TMemo;
    grp3: TGroupBox;
    mmo_Output: TMemo;
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

procedure TForm1.btn_OKClick(Sender: TObject);   // ��������� ��������� ������� ������
var slovo: string; // ���������� ��� �������� ���������� ������
    i: Integer; // �������� ��� ��������� �����
    bed_sim: string; // ���������� ��� �������� ����������� �������� �� ��������� ������
    flag_a, flag_b, flag_c: Boolean; // ����� ����������� ���������� ������ �������� �, � � �
    summa_digit: Integer; // ���������� ��� ���������� �������� �������� � �����
    zakluchenie: string; // ��������� ���������� ��� �������� �������������� �����
begin
//
    mmo_Output.Clear; // ������� ������������� ��������� ������
    // 1. �������� ��������� �� ���������� ����
    try
      slovo:=mmo_Input.Lines.Strings[0];
      if mmo_Input.Lines.Count > 1 then
      begin
        for i:=1 to mmo_Input.Lines.Count-1 do
          begin
            slovo:= slovo + mmo_Input.Lines.Strings[i];
          end;
        mmo_Input.Clear; // ������� ������������� ��������� ������
        mmo_Input.Lines.Add(slovo);
        mmo_Output.Lines.Add('��������� ����� ������� �� ���������� �����!');
        mmo_Output.Lines.Add('��� ������� ������ �������� ���� ����� ���� ���������� � ���� ������.');
      end;
    except
      mmo_Output.Lines.Add('�� ������� ��������� ������� ��������!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('��������� ������������ ��������� ������!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('���������� �����������!');
      Exit // ������� �� ������������
    end;

    // 2. ��������� ��������� ������:
    if (Length(slovo) = 0) then  // ���� ����� "������" (����� ������� ������), ��
      begin
        mmo_Output.Lines.Add('��������� ����� ������� �� ������ ������!');
        mmo_Output.Lines.Add('');
        mmo_Output.Lines.Add('���������� �����������!');
        Exit // � ��������� ������������
      end;

    i:=1; bed_sim:='';
    while (i <= Length(slovo)) do // ����������� ������ �� ������ �� �����
      begin
        if not (slovo[i] in ['0'..'9']) and not (slovo[i] in ['0'..'9', 'A'..'Z','a'..'z', '�'..'�', '�'..'�']) then // ���� �� ��� ����� ������� �� ����������� ��������, ��
          begin
            bed_sim:= bed_sim + slovo[i];
          end;
        i:=i+1; // ������ ��� � ��������� ����� ������
      end;
    if Length(bed_sim)>0 then  // � ���� ���������� "������" �������� ������ 0, �� ������� ���������:
    begin
      mmo_Output.Lines.Add('��������� ����� �������� ����������� �������: ' + bed_sim);
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('��������� ������ ����� � ����� �������� � ���������� ���������.');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('���������� �����������!');
      Exit {� ��������� ���������}
    end;

    // 3. ����������� ����� (��������� �� ����������� �������� ��������)

    // �) ���� ����� ���������� � ��������� ��������� �����,
    // �� ������� ������� ������ �����, � �� ���-�� ����� ��������� �������� ���� �����
    flag_a:= True; // ���������� ���� (������������)
    if (slovo[1] in ['1'..'9']) and (  (Length(slovo)-1) = StrToInt(slovo[1])  ) then // ���� ����� ���������� � ��������� ��������� ����� � ���������� ����������� �������� ��������� �� ��������� �����, ��
    begin
      i:= 2;
      while (i <= Length(slovo)) and (flag_a = True) do // ����������� ������ �� ������� ������� �� ����� � ���� �� �������� ���� ���� �����
      begin
        if not (slovo[i] in ['A'..'Z','a'..'z', '�'..'�', '�'..'�']) then // ���� �� ��� ����� ������� �� ����������� ��������, ��
          begin
            flag_a:= False;
          end;
        i:=i+1; // ������ ��� � ��������� ����� ������
      end;
    end
    else
      flag_a:= False; // ����� �� �������������!

    // b) ���� ����� ���������� � k ���� (1<=k<=9),
    // �� �������� ������� ������ 1 ������ - ����� � �������� ��������� k
    flag_b:= True; // ���������� ���� (������������)
    if (slovo[Length(slovo)] in ['1'..'9']) and (  StrToInt(slovo[Length(slovo)]) = (Length(slovo)-1)  ) then // ���� ����� ������������� �� ����� � �� �������� ��������� � ����������� ���������� ��������, ��
    begin
      i:= 1;
      while (i <= ( Length(slovo)-1 ) ) and (flag_b = True) do // ����������� ������ � ������ �� �������������� ������� � ���� �� �������� ���� ���� �����
        begin
          if not (slovo[i] in ['A'..'Z','a'..'z', '�'..'�', '�'..'�']) then // ���� �� ��� ����� ������� �� ����������� ��������, ��
            begin
              flag_b:= False;
            end;
          i:=i+1; // ������ ��� � ��������� ����� ������
        end;
    end
    else
      flag_b:= False; // ����� �� �������������!

    // c) ����� �������� �������� ����, �������� � �����, ����� ����� ������
    flag_c:= True; // ���������� ���� (������������)
    i:= 1;
    summa_digit:= 0; // �������� ���������� ����� � �����
    while ( i <= Length(slovo) ) do // ����������� ������ � ������ �� �������������� ������� � ���� �� �������� ���� ���� �����
      begin
        if (slovo[i] in ['1'..'9']) then // ���� �������� ����� (� �� �����), ��
          begin
            summa_digit:= summa_digit + StrToInt(slovo[i]); // ����������� �����
          end;
        i:=i+1; // ������ ��� � ���������� ������� ������
      end;
   if ( summa_digit <> Length(slovo) ) then flag_c:= False; // � ���� �� ���������, �� �� ������������!


    // 4. ������� � ������������� ��������� ���� ���������� �������:
    mmo_Output.Lines.Add('���������� ���������!');
    mmo_Output.Lines.Add('');
    if (flag_a = True)then zakluchenie:= '��������� ����� ������������� ������� (a), '
    else zakluchenie:= '��������� ����� �� ������������� ������� (a), ';

    if (flag_b = True)then zakluchenie:= zakluchenie + '������������� ������� (b) � '
    else zakluchenie:= zakluchenie +'�� ������������� ������� (b) � ';

    if (flag_c = True)then zakluchenie:= zakluchenie + '������������� ������� (c).'
    else zakluchenie:= zakluchenie + '�� ������������� ������� (c).';

    mmo_Output.Lines.Add(zakluchenie);
end;

end.
