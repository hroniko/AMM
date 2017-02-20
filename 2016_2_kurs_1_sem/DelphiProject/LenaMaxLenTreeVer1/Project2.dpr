program Project2;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas',
  MySimpleTree in 'MySimpleTree.pas';

// ������ ���������� ����������� ������ � ������� ������ � ���

var myFile: Text; // ���������� ���� Text ��� ���������� � ��������� ������
    tmp: Integer;

    uk, tmpNode: tree_ptr;
    sum, count, srednee: Integer;

begin

  // 1) --------------- ������ �� ����� � ����������� ������ ------------------
  assign(myFile, 'in2.txt'); // ��������� ���� � ���������� myFile
  reset(myFile); // ��������� ���� �� ������
  // ������ ������ ������� ����� ����� � ������:
  tmp:= 0;
  while not Eof(myFile) do // ��������� ���� ������ ����� �� �����
    begin
      readln(myFile, tmp); // ��������� ����� �� ��������� ���������
      uk:= InsertKey(uk, tmp);  // � ��������� �� � ������
    end;
  close(myFile); // ��������� ����, ����������� �������
  // 1) -----------------------------------------------------------------------

  // 2) --------------- ����� ��������� ������ � ������� ----------------------
  Write('�������� ������ (������ ����� �����): ');
  FrontOrderLeft(uk); // ������� �� ������� ������ ����� ������� ���� ������
  Writeln;

////  WriteLn('   �������� ���������: ');
////  Writeln;
////  PrintLeftTree(uk); // ������ ����������������� ������


  // --------------- ����� �������������� ������ � ������� ----------------------
  tmpNode:= Find_AllNode_Between_MaxLenWay(uk);
  Write('������� ������� (������ ����� �����): ');
  FrontOrderLeft(tmpNode); // ������� �� ������� ������ ����� ������� ���� ����� ������
  Writeln;

  tmp:= Find_AllNode_Between_MaxLenWay2(uk);
  if tmp < 0 then  Write('��������� ������� : ��� ')
  else
  begin

    Write('������� ������ ��������� ������� :    ', tmp);
    uk:= RightRemoveKey(uk, tmp); // ������� ������ ��������� ��� ������� �� �� �����
    Writeln;

////    WriteLn('   ��������� ������ ����� ��������: ');
////    Writeln;
////    PrintLeftTree(uk); // ������ ����������������� ������
////    Writeln;

    Write('����� ������ (������ ����� �����):    ');
    FrontOrderLeft(uk); // ������� �� ������� ������ ����� ������� ���� ������
  end;
  Writeln;
  Readln;  // �������� ������� ������� � ����� �� ���������
end.
