///////////////////////////////////////////////
// ���������  ������� ������ �� �����������  //
// ��������                                  //
// �����: Anatoly                            //
// 4 ������                                  //
// ���, 1 ����, �/�, ��. 12, 3 �������       //
// (�52, ���. 145)                           //
// 2015-10-12                                //
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
    zakluchenie: string; // ��������� ���������� ��� �������� �������������� �����
    max, min: Integer; // ���������� ��� �������� ������������ � ������������� ���� ��������
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
        //mmo_Output.Lines.Add('��������� ����� ������� �� ���������� �����!');
        //mmo_Output.Lines.Add('��� ������� ������ �������� ���� ����� ���� ���������� � ���� ������.');
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

    // 3. �������� �� �������
    // ���� ������������ � ����������� ������� �� ��� ������ ���� � ������� ����� ��������
    max:= ord(slovo[1]);
    min:= max;

    for i:=2 to Length(slovo) do // ��� ��� ������� �� ������� �� ��������� ������� ������
    begin
      if ( ord(slovo[i]) > max ) then max:= ord(slovo[i]);
      if ( ord(slovo[i]) < min ) then min:= ord(slovo[i]);
    end;


    for i:=2 to Length(slovo) do // ��� ��� ������� �� ������� �� ��������� ������� ������
    begin
      if ( ord(slovo[i]) > max ) then max:= ord(slovo[i]);
      if ( ord(slovo[i]) < min ) then min:= ord(slovo[i]);
    end;


    zakluchenie:= '';
    for i:=1 to Length(slovo) do // ��� ��� ������� �� ������� �� ��������� ������� ������
    begin
      if ( ord(slovo[i]) <> max ) and ( ord(slovo[i]) <> min ) then zakluchenie:= zakluchenie + slovo[i];
    end;


    // 4. ������� � ������������� ��������� ���� ���������� �������:
    mmo_Output.Lines.Add('���������� ���������!');
    mmo_Output.Lines.Add('');
    mmo_Output.Lines.Add('����� ������������������:');
    mmo_Output.Lines.Add(zakluchenie);
    mmo_Output.Lines.Add('');
    mmo_Output.Lines.Add('�����������  �������: ' + chr(min) + ' (��� ' + IntToStr(min) + ')');
    mmo_Output.Lines.Add('������������ �������: ' + chr(max) + ' (��� ' + IntToStr(max) + ')');
end;

end.
