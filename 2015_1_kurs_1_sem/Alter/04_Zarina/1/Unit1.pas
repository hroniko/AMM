///////////////////////////////////////////////
// ���������  ������� ������ �� �����������  //
// ��������                                  //
// �����: Anatoly                            //
// 5 ������                                  //
// ���, 1 ����, �/�, ��. 12, 3 �������       //
// (�35)                                     //
// 2015-10-20                                //
///////////////////////////////////////////////

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls;

type masInt2D = array of array of Integer; // ��������� ��� - ��������� ������ ����� �����
type TPMAS = ^masInt2D;  // ��� - ��������� �� ��������� ������ ����� �����
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

// ������� �������� ������ �� ��� ��������� ������ (�� ��� �������������) � ���� �������� �� i � j (�� ������ � �������),
// ������� ����� ���� ����� � ������� ��������, ��� ����� ���� ����� ��
function findNumber(pMassiv: TPMAS; i: integer; j: integer; n: integer; m: integer): string;
var k, l: Integer; // ����������� ����� � ��������
    s: Integer;
    summ: Integer;
    MassivSumm: masInt2D; // ��������� ��������� ���� ���������� ������� ����� ����� ��� �������� ������� ����
    slovo: string;
    slovo2: string;
begin
SetLength(MassivSumm,n,m); // �������� ������ ��� ��� ������ ������������ ������ (������ ��� ������������� �����������)
// ��������� ������ ����:
for k:=0 to n-1 do
  begin
    for l:=0 to m-1 do
      begin
        slovo:= IntToStr(pMassiv^[k,l]);
        summ:=0;
        for s:=1 to Length(slovo) do summ:= summ + StrToInt(slovo[s]);
        MassivSumm[k,l]:=summ;
      end;
  end;

// ���� � ������� ��� ��������, ��� ����� ��������� � ������ ��������� ��������

slovo2:='';
for k:=0 to n-1 do
  begin
    for l:=0 to m-1 do
      begin
        if (MassivSumm[i,j] = MassivSumm[k,l]) and ((i<>k) or (j<>l)) then slovo2:= slovo2 + '[' + IntToStr(k+1) + ';' + IntToStr(l+1) + ']; ' ;
      end;
  end;
if slovo2 = '' then
slovo:= '������� [' + IntToStr(i+1) + ';' + IntToStr(j+1) + '] ����� ����� ���� (' + IntToStr(MassivSumm[i,j]) + '), ��������� � ����� �� ������ ���� ���;'
else slovo:= '������� [' + IntToStr(i+1) + ';' + IntToStr(j+1) + '] ����� ����� �� ����� ���� (' + IntToStr(MassivSumm[i,j]) + '), ��� ��������: ' + slovo2;

findNumber:=slovo;
end;


procedure TForm1.btn_OKClick(Sender: TObject);   // ��������� ��������� ������� ������
var slovo: string; // ���������� ��� �������� ���������� ������
    i, j, countD, countN, countM, n, m: Integer; // ��������
    bed_sim: string; // ���������� ��� �������� ����������� �������� �� ��������� ������
    zakluchenie: string; // ��������� ���������� ��� �������� �������������� �����
    max, min: Integer; // ���������� ��� �������� ������������ � ������������� ���� ��������
    Massiv: masInt2D; // ��������� ��������� ���� ���������� ������� ����� �����
    chisloString: string; // ��������� ������������� ������ �� �����
    var PMassiv: TPMAS;//��������� �� ���������� ���� ���������� ������� ����� �����
const Digit: Set of Char = ['0' .. '9'];  // ���������� ����������� ������� - ������ ����� �� 0 �� 9
begin
//
    mmo_Output.Clear; // ������� ������ ������������� ��������� ������
    // 1. ������� ���������� ��������� � �������� �� ������������ ��������� ����������
    // �������� ��������� �� �������������� ���������� ����
    try
      countN:=0; // �������� ������� ����� �������� �����
      countM:=0; // �������� ������� ����� ����� (�������) ��� ������ ������ (��� ����� ���������� � ���-��� ����� � ��. �������)
      for i:=0 to mmo_Input.Lines.Count-1 do   // ��� ������ �� ��������� �����
      begin
        countD:=0; // �������� ������� ����� ����� (�������) ��� ������ ������ (��� ����� ���������� � ���-��� ����� � ��. �������)
        slovo:= mmo_Input.Lines.Strings[i]; // ��������� ������� ������ � ���������� ���������� ����
        if ( Length(slovo) > 0 ) then// ���� ������ �� �������, �������� � ���
          begin
            countD:=0; // �������� ������� ����� �����
            for j:= 1 to Length(slovo) do // ��� ������ ����� � ������ �� ���������
            begin
              if (slovo[j] in Digit) then   // ���� ������� ������ - ��� �����, ��
                begin
                  if (j = 0) then countD:= countD + 1  // ���� �� � ������ ������, �� ����������� ������� ����� ����� ������
                  else if not(slovo[j-1] in Digit) then countD:= countD + 1; // � ���� �� � ������, �� ���� ���������� ������ ��� ��  �����, �� ����������� ������� ����� ����� ������
                end
              else   // ����� (�. �. ���� �� �����) , ��
                if (slovo [j] <> ' ') then // ���� ������ �� ������, �� ��� ���� �� ����������� ��������!
                begin
                  mmo_Output.Lines.Add('������� ����������� �������!');
                  mmo_Output.Lines.Add('');
                  mmo_Output.Lines.Add('��������� ������������ ��������� ������!');
                  mmo_Output.Lines.Add('');
                  mmo_Output.Lines.Add('���������� �����������!');
                  Exit // � ������� �� ������������
                end;
            end;
              if (countD > 0) then countN:= countN + 1; // ���� ���������� ��������� ��������� � ������� ������ ������ ����, ����������� ������� ��������� �����
              if (countM = 0) then countM:= countD; // ���� ������� ������ - ����� ������ �� ������, �� ������������ ����� ��������� ��������� � ������� ��������

              if (countM <> countD) then // ���� ����� ����� ������ ������ �� ����� ����� ����� �������, �� �������:
              begin
                mmo_Output.Lines.Add('������� �� �������� �������������!');
                mmo_Output.Lines.Add('');
                mmo_Output.Lines.Add('����� ����� ��������� ����� �� ���������!');
                mmo_Output.Lines.Add('');
                mmo_Output.Lines.Add('���������� �����������!');
                Exit // � ������� �� ������������
              end
          end
        end;
      if (countN <> 0) then
      begin
        mmo_Output.Lines.Add('������� ������� ����������� ' + IntToStr(countN) + '�' + IntToStr(countM));
        mmo_Output.Lines.Add('');
        n:= countN;
        m:= countM;
      end
      else
        begin
          mmo_Output.Lines.Add('�� �� ����� �������� �������!');
          mmo_Output.Lines.Add('');
          mmo_Output.Lines.Add('������� �� ����� ���� ������!');
          mmo_Output.Lines.Add('');
          mmo_Output.Lines.Add('���������� �����������!');
          Exit // � ������� �� ������������
        end;
    except
      mmo_Output.Lines.Add('�� ������� ��������� ������� ��������!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('��������� ������������ ��������� ������!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('���������� �����������!');
      Exit // ������� �� ������������
    end;

    // 2. �������� ������� ������������� ����������� � ���������� ��� ����������
    SetLength(Massiv,countN,countM); // �������� ������ ��� ��� ������������ ������ (������ ��� ������������� �����������)
    chisloString:=''; // �������� ��������� ���������� �������� �����
    // � �������� ���������:
    countN:=0; // �������� ������� ����� �������� �����
    countM:=0; // �������� ������� ����� ����� (�������) ��� ������ ������ (��� ����� ���������� � ���-��� ����� � ��. �������)
    for i:=0 to mmo_Input.Lines.Count-1 do   // ��� ������ �� ��������� �����
      begin
        countD:=-1; // �������� ������� ����� ����� (�������) ��� ������ ������ (��� ����� ���������� � ���-��� ����� � ��. �������)
        slovo:= mmo_Input.Lines.Strings[i]; // ��������� ������� ������ � ���������� ���������� ����
        if ( Length(slovo) > 0 ) then// ���� ������ �� �������, �������� � ���
          begin
            countD:=-1; // �������� ������� ����� �����
            chisloString:=''; // �������� ��������� ���������� �������� �����
            for j:= 1 to Length(slovo) do // ��� ������ ����� � ������ �� ���������
            begin
              if (slovo[j] in Digit) then   // ���� ������� ������ - ��� �����, ��
                begin
                  if (j = 0) then
                    begin
                      countD:= countD + 1;  // ���� �� � ������ ������, �� ����������� ������� ����� ����� ������
                      chisloString:= slovo[j];
                    end
                  else
                       if not(slovo[j-1] in Digit) then
                         begin
                           countD:= countD + 1; // � ���� �� � ������, �� ���� ���������� ������ ��� ��  �����, �� ����������� ������� ����� ����� ������
                           chisloString:=slovo[j];
                         end
                       else
                         begin
                           chisloString:=chisloString + slovo[j];
                         end;

                end;
              if (chisloString <> '') then Massiv[countN, countD]:= StrToInt(chisloString);
            end;
            if (countD > -1) then countN:= countN + 1; // ���� ���������� ��������� ��������� � ������� ������ ������ ����, ����������� ������� ��������� �����


          end
        end;

    // 3. ����� ��� ������� �������� ���������, ����� ���� ������� ��������� � ������ ���� �������� �����
    PMassiv:= @Massiv; // �������� � ��������� ����� �������
    for i:=0 to (n - 1) do      // ��� ��� ����� � �������
    begin
      for j:=0 to (m - 1) do // ��� ��� ��������
      begin
        mmo_Output.Lines.Add(findNumber(PMassiv, i, j, n, m));
      end;
    end;

    // � ������������ ������ ������ �������������� ������ � ������:
    mmo_Output.SelStart:=0;
    mmo_Output.SelLength := 0;




    
end;

end.
