program Queen8;

{$APPTYPE CONSOLE}

uses
  //SysUtils;
    EsConsole in 'EsConsole.pas';
var i: Integer;
    a: array [1 .. 8] of Boolean;
    b: array [2 .. 16] of Boolean;
    c: array [-7 .. 7] of Boolean;
    x, ii, jj: array [1 .. 8] of Integer;
    all: array [1 .. 46] of array [1 .. 8] of Integer;
    count: Integer;

    board, boardReverse:  array [1 .. 8] of array [1 .. 8] of string;

procedure Print;
var k: Integer;
begin
  for k:= 1 to 8 do write(x[k], ' ');
  Writeln;
end;

// ������ ������ � �������� � ��� �����������
procedure PrintAll;
var c, k, tmp: Integer;
begin
  for c:= 1 to 46 do
  begin
    if c < 10 then write('var.', c, '   [') else write('var.', c, '  [');
    for k:= 1 to 8 do
    begin
      //write(all[c, k], ' ');
      // ��������� �������:
      ii[k]:= k;
      jj[k]:= all[c, k];
      write('(', ii[k], ',', jj[k], ') ');
    end;
    write(']');
    write(' � ');
    // ������ ����������� ������ ������������ �������� ���������:
    for k:= 1 to 8 do
    begin
       tmp:= ii[k];
       ii[k]:= 9 - jj[k];
       jj[k]:= 9 - tmp;
    end;
    // � �������� ������������ ������
    write('[');
    for k:= 1 to 8 do
    begin
      write('(', ii[k], ',', jj[k], ') ');
    end;
    write(']');

    Writeln;
  end;
end;

// ��������� ������ ����� ������ �����
procedure printOneBoard(num: Integer);
var w, z: Integer;
begin
  // �������������� �����:
  for w:= 1 to 8 do
    for z:=1 to 8 do
    begin
      board[w, z]:= '  . ';
      if w = 9-z then  board[w, z]:= '  + ';
    end;

  // � ����������� ������:
  for w:= 1 to 8 do board[w, all[num, w]]:= '  O ';

  // �, �������, ������� �� �����:
  for w:= 1 to 8 do
  begin
    for z:= 1 to 8 do write(board[w, z]);
    Writeln;
    Writeln;
  end;
end;

// ��������� ������ ����� �������� �����
procedure printOneReverseBoard(num: Integer);
var w, z: Integer;
begin
  // �������������� �����:
  for w:= 1 to 8 do
    for z:=1 to 8 do
    begin
      board[w, z]:= '  . ';
      if w = 9-z then  board[w, z]:= '  + ';
    end;

  // � ����������� ������:
  for w:= 8 downto 1 do board[9-all[num, w], 9-w]:= '  O ';

  // �, �������, ������� �� �����:
  for w:= 1 to 8 do
  begin
    for z:= 1 to 8 do write(board[w, z]);
    Writeln;
    Writeln;
  end;
end;

// ��������� ������ ������ � �������� �����
procedure printTwoBoard(num: Integer);
var w, z: Integer;
begin
  // �������������� �����:
  for w:= 1 to 8 do
    for z:=1 to 8 do
    begin
      board[w, z]:= '  . ';  boardReverse[w, z]:= '  . ';
      if w = 9-z then
      begin
        board[w, z]:= '  + ';
        boardReverse[w, z]:= '  + ';
      end;
    end;

  // � ����������� ������:
  for w:= 1 to 8 do board[w, all[num, w]]:= '  O ';
  for w:= 8 downto 1 do boardReverse[9-all[num, w], 9-w]:= '  O ';

  // �, �������, ������� �� �����:
  Writeln('         Forward Board #', num, '                      Reverse Board #', num, '');
  Writeln;
  for w:= 1 to 8 do
  begin
    for z:= 1 to 8 do write(board[w, z]); write('      '); for z:= 1 to 8 do write(boardReverse[w, z]);
    Writeln;
    Writeln;
  end;
end;


procedure Add;
var k: Integer;
begin
  Inc(count);
  for k:= 1 to 8 do all[count, k]:= x[k];
end;

procedure TryIt (i: Integer);
var j: Integer;
begin
  if count <46 then
  begin
    for j:= 1 to 8 do
    begin
      if a[j] and b[i+j] and c[i-j] then
      begin
        x[i]:= j;
        a[j]:= False;
        b[i+j]:= False;
        c[i-j]:= False;
        if i<8 then  TryIt(i+1) else Add; //Print;
        a[j]:= True;
        b[i+j]:= True;
        c[i-j]:= True;
      end;
    end;
  end;
end;

// ���� �������� ���������
begin
  Writeln('�������� ����������� ����������� ������ ������ � ����������� ������ ������������ �������� ���������:');
  Writeln;
  // ��������� �������������:
  for i:= 1 to 8 do a[i]:= True;
  for i:= 2 to 16 do b[i]:= True;
  for i:= -7 to 7 do c[i]:= True;

  count:= 0;

  // � �������� ��������� �����������:
  TryIt(1);

  PrintAll; // ������� ��������� �� �����

  while True do
  begin
    Writeln;
    Writeln('������� ����� ��������, ������� ������ �����������, ��� 0 ��� ������:');
    Readln(i);
    if (i > 0) and (i < 47) then
    begin
       // Writeln('������� ����������� ����� ', i, ':');
       Writeln;
       printTwoBoard(i);
       // Readln;
    end
    else Break;
  end;



end.
