program Project2;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas', // ���������� ������ ����������� �������
  // SysUtils, // ��� �� �����, ���� EsConsole ��� ���� �����
  MyTree in 'MyTree.pas'; // ������ ���������� ���-������ � ������� ������ � ���

var arr: array of Integer;
    var myFile: Text; // ��������� ���������� ���� Text ��� ���������� �  ��������� ������
    i: Integer;

    uk: tree_ptr;

    sum, count, srednee: Integer;

begin
  { TODO -oUser -cConsole Main : Insert code here }

  // ������� ���������� �� ������:
  Writeln('| ------------------------------------------------------- |');
  Writeln('| ������� �.�., ���, 2 ����, 1 �������. ������� 2, ���. 3 |');
  Writeln('| ����� � ������� (������ ���������) ������� �� ��������  |');
  Writeln('| ������� �� ������ ������, � ������� ���������� �������� |');
  Writeln('| � ����� ��������� ���������� �� ���������� �������� �   |');
  Writeln('| ������ ��������� �� 1. ��������� ������ (�����) �����   |');
  Writeln('| ����������� ������.                                     |');
  Writeln('| ------------------------------------------------------- |');
  Writeln;

  SetLength(arr, 21);  // ��������� ����� ����������� �������
  assign(myFile, 'in.txt'); // ��������� ���� � ���������� myFile
  reset(myFile); // ��������� ���� �� ������

  // ������ ���� � ������:
  i:= 0;
  while not Eof(myFile) do // ��������� ���� ������ ����� �� �����
    begin
      readln(myFile, arr[i]); // ��������� ����� � ������
      Inc(i);
    end;
  close(myFile); // ��������� ����, ����������� �������

  // � ��������� ������ � ���������������� ������ (�� �����)
  // uk:= MassiveToBalancedTree(arr);

  //for i:=0 to 20 do write(arr[i], ' ');
  //FrontOrderLeft(uk);  Writeln;
  //FrontOrderRight(uk); Writeln;

  // ��������� �� ������� � �������� ������ ������� ������� ��� ���� ���-������:
  for i:=0 to 20 do uk:= InsertKey(uk, arr[i]);
  Write('-> '); Writeln('�������� ������ (������ ����� �����):');
  Write('   '); FrontOrderLeftPosition(uk);  Writeln; // ������� �� ������� ������ ����� ������� ��, ��� ����������, ���� ������

  //
  Writeln;
  Write('-> '); Write('���������� �������: '); sum:= SumLR(uk);
  Writeln;
  Write('-> '); Writeln('����� ���������� ������ = ', sum);
  Write('-> '); Write('���������� ������ = '); count:= CountLR(uk); Writeln(count);
  Write('-> '); Write('��������� ������� (������� ��������) = '); srednee:= sum div count; Writeln(srednee);
  Writeln;
  NormPrintTree(uk);

  // FrontOrderLeft(uk);  Writeln;

  ////uk:= RemoveKey(uk, srednee); // ������� �������� �������
  ////Write('-> '); Writeln('������ ����� �������� �������� (������ ����� �����):');
  ////Write('   '); FrontOrderLeftPosition(uk);  Writeln;


  // uk:= RemoveKey(uk, 1);
  // FrontOrderLeft(uk);  Writeln;


  // PrintTree(uk, 0); // ������ ����������������� ������

  Readln;
end.
