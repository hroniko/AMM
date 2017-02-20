program ProjectZarina;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas', // ���������� ������ ����������� �������
  Math, Windows; // ���������� ������ ������


// ������� ���������� � ���������:
procedure Sort(var arr: array of Integer; L, R: Integer);  
var i, j : Integer;
    x, w : Integer;
begin
  i:= L; j:= R;
  x:= arr[(L + R) div 2];
  repeat
    while arr[i] < x do i:= i + 1;
    while x < arr[j] do j := j - 1;
    if i <= j then
    begin
      w := arr[i]; arr[i]:= arr[j]; arr[j]:= w; i:= i + 1; j:= j - 1;
    end;
  until i > j;
  if L < j then Sort(arr, L, j);
  if i < R then Sort(arr, i, R);
end;
procedure QuickSort(var arr: array of Integer);     // ��������� ��������� ��� ������� ���������� ��� ��������
var size: Integer;
begin
  size:= Length(arr);
  Sort(arr, 1, size-1); // �������� � ������� ��������, ��� ��� ������� ��� �������� � ������ �����������, � ��� ���� �� Sort(arr, 0, size-1);
end;  

// ���������� ������� ������ (����������� ����������):
procedure BubbleSort(var arr: array of Integer);
var i, j : Integer;
    tmp : Integer;
    size : Integer;
begin
  size:= Length(arr);
  for i:= 2 to size - 1 do
  begin
    for j:= size - 1 downto i do
    begin
      if arr[j-1] > arr[j] then
      begin
        tmp:= arr[j-1];
        arr[j-1]:= arr[j];
        arr[j]:= tmp;
      end;
    end;
  end;
end;	



var a1, a2 : array of Integer; // ���������� ������������ ������ ��� �������� �������������� �������������� �������
    i : Integer;
    t1, t2 : LongInt;
    ssize, start, finish: Integer;
	
// ------------------------------------- ���� �������� ��������� ---------------------------------------

begin
  { TODO -oUser -cConsole Main : Insert code here }

  // ������� ��������� �� ����� �� �������� ������:
  Writeln('������� ����� ��������� � ��������:');

  read(ssize);
  read(start);
  read(finish);

  SetLength(a1, ssize + 1);  SetLength(a2, ssize + 1); // ��������� ����� ����������� �������

  a1[0]:= 0; // ��������
  a2[0]:= 0; // ��������
  Randomize;  for i:=1 to Length(a1)-1 do
  begin
  a1[i]:= RandomRange(start, finish);
  a2[i]:= a1[i];
  end;



  // for i := 1 to Length(a1)-1 do Write(a1[i], '; ');   // ������� �������� ������

  // �������� ��������� �����:
  t1:= GetTickCount;
  // ��������� ���������� �������:
 BubbleSort(a1);
  // �������� �������� �����:
  t2:= GetTickCount;
  // Writeln; for i:= 1 to Length(a1)-1 do Write(a1[i], '; '); Writeln;  // ������� ��������������� ������
  Writeln('����� ���������� ���������: ', t2-t1, ' ��');

    // �������� ��������� �����:
  t1:= GetTickCount;
  // ��������� ���������� �������:
  QuickSort(a2);
  // �������� �������� �����:
  t2:= GetTickCount;
  // Writeln; for i:= 1 to Length(a2)-1 do Write(a2[i], '; '); Writeln;  // ������� ��������������� ������
  Writeln('����� ������� ���������� � ���������: ', t2-t1, ' ��');

  Readln;    Readln;

end.
