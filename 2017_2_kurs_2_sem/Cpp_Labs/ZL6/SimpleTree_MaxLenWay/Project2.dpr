program Project2;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas',
  MySimpleTree in 'MySimpleTree.pas',
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

procedure clrscr;
var
  cursor: COORD;
  r: cardinal;
begin
  r := 300;
  cursor.X := 0;
  cursor.Y := 0;
  FillConsoleOutputCharacter(GetStdHandle(STD_OUTPUT_HANDLE), ' ', 80 * r, cursor, r);
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), cursor);
end;

// ������ ���������� ����������� ������ � ������� ������ � ���

var myFile: Text; // ���������� ���� Text ��� ���������� � ��������� ������
    tmp: Integer;

    uk, tmpNode: tree_ptr;
    sum, count, srednee: Integer;
    stroka, substroka : string;
    i:integer;

begin
  // ������� ���������� �� ������:
  Writeln('������� �.�., ���, 2 ����, 2 �������');
  clrscr;
  Writeln('������� �.�., ���, 2 ����, 2 �������');
  Writeln('����� ���� ����� ������, ����������� ������� �� ������');
  Writeln('������, ������� ���� ������������ �����, ��� ��������');
  Writeln('����� ������ �������� ������ ����������.              ');
  Writeln('������� ������� ����� ���� ������� �������� ��������.');
  Writeln;  Writeln;

  // 1) --------------- ������ �� ����� � ����������� ������ ------------------
//  assign(myFile, 'in3.txt'); // ��������� ���� � ���������� myFile
//  reset(myFile); // ��������� ���� �� ������
  Writeln('������� ������������������ ������������� ����� ����� ����� ������ ��� �������: ');
  Readln(stroka);

  substroka:= '';
  for i:=0 to Length(stroka) do
  begin
    if (stroka[i] = '0') or (stroka[i] = '1') or (stroka[i] = '2') or (stroka[i] = '3') or (stroka[i] = '4') or (stroka[i] = '5') or (stroka[i] = '6') or (stroka[i] = '7') or (stroka[i] = '8') or (stroka[i] = '9') then
    begin
      substroka:= substroka + stroka[i];
    end
    else
    begin
      if (Length(substroka) > 0) then
      begin
         uk:= InsertKey(uk, StrToInt(substroka));  // � ��������� �� � ������
         substroka:= '';
      end;
    end;    

  end;

  if Length(substroka) > 0 then uk:= InsertKey(uk, StrToInt(substroka));  // � ��������� �� � ������




  // ������ ������ ������� ����� ����� � ������:

  // 1) -----------------------------------------------------------------------

  // 2) --------------- ����� ��������� ������ � ������� ----------------------
  Write('�������� ������ (������ ����� �����): ');
  FrontOrderLeft(uk); // ������� �� ������� ������ ����� ������� ���� ������
  Writeln;

//   WriteLn('   ���������: ');
//   Writeln;
//   PrintLeftTree(uk); // ������ ����������������� ������
  // 2) -----------------------------------------------------------------------

  // 3) ------------------ ���������� ���������� ������� ----------------------
  //WriteLn('   ����� �������� ��� ���������: ', SumKey_MaxLenWay(uk));
  tmpNode:= FindNodeBetween_MaxLenWay(uk);
  //WriteLn('����, ����� ������� �������� ������� ����: ', tmpNode^.key);
  WriteLn('����� �������� ��������� ��� ������� ����: ', SumKey_MaxLenWay(tmpNode) );
  //write('���� ������������ �����: '); PrintMaxLenWay(tmpNode);
  Writeln('����� ����: ', MaxLenWay(tmpNode), ' ����(�)' );
  Writeln;

  // 4) ������������� ������:
  RebuildTree(uk, tmpNode);

  // 5) --------------- ����� �������������� ������ � ������� ----------------------
//  Write('����� ������ (������ ����� �����): ');
//  FrontOrderLeft(tmpNode); // ������� �� ������� ������ ����� ������� ���� ����� ������
//  Writeln;

//  WriteLn('   ���������: ');
//  Writeln;
//  PrintLeftTree(tmpNode); // ������ ����������������� ������


  // ���� � ������� ������ ��������� ������� �� ��������
  uk:= FindMiddleAndRightRemove(uk);
  Writeln;
  // 3) -----------------------------------------------------------------------

  // 4) ------------- ����� ������������� ������ � ������� --------------------
  Write('����� ������ (������ ����� �����): ');
  FrontOrderLeft(uk); // ������� �� ������� ������ ����� ������� ���� ������
  Writeln;

//  WriteLn('   ���������: ');
//  Writeln;
//  PrintLeftTree(uk); // ������ ����������������� ������
  // 4) -----------------------------------------------------------------------
  
  Readln;  // �������� ������� ������� � ����� �� ���������
end.
