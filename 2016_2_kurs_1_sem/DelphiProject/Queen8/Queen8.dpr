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

// Печать прямых и обратных к ним расстановок
procedure PrintAll;
var c, k, tmp: Integer;
begin
  for c:= 1 to 46 do
  begin
    if c < 10 then write('var.', c, '   [') else write('var.', c, '  [');
    for k:= 1 to 8 do
    begin
      //write(all[c, k], ' ');
      // Формируем массивы:
      ii[k]:= k;
      jj[k]:= all[c, k];
      write('(', ii[k], ',', jj[k], ') ');
    end;
    write(']');
    write(' и ');
    // Делаем необходимый реверс относительно побочной диагонали:
    for k:= 1 to 8 do
    begin
       tmp:= ii[k];
       ii[k]:= 9 - jj[k];
       jj[k]:= 9 - tmp;
    end;
    // И печатаем перевернутый массив
    write('[');
    for k:= 1 to 8 do
    begin
      write('(', ii[k], ',', jj[k], ') ');
    end;
    write(']');

    Writeln;
  end;
end;

// Процедура печати одной ПРЯМОЙ доски
procedure printOneBoard(num: Integer);
var w, z: Integer;
begin
  // Инициализируем доску:
  for w:= 1 to 8 do
    for z:=1 to 8 do
    begin
      board[w, z]:= '  . ';
      if w = 9-z then  board[w, z]:= '  + ';
    end;

  // И расставляем ферзей:
  for w:= 1 to 8 do board[w, all[num, w]]:= '  O ';

  // И, наконец, выводим на экран:
  for w:= 1 to 8 do
  begin
    for z:= 1 to 8 do write(board[w, z]);
    Writeln;
    Writeln;
  end;
end;

// Процедура печати одной ОБРАТНОЙ доски
procedure printOneReverseBoard(num: Integer);
var w, z: Integer;
begin
  // Инициализируем доску:
  for w:= 1 to 8 do
    for z:=1 to 8 do
    begin
      board[w, z]:= '  . ';
      if w = 9-z then  board[w, z]:= '  + ';
    end;

  // И расставляем ферзей:
  for w:= 8 downto 1 do board[9-all[num, w], 9-w]:= '  O ';

  // И, наконец, выводим на экран:
  for w:= 1 to 8 do
  begin
    for z:= 1 to 8 do write(board[w, z]);
    Writeln;
    Writeln;
  end;
end;

// Процедура печати прямой и обратной доски
procedure printTwoBoard(num: Integer);
var w, z: Integer;
begin
  // Инициализируем доски:
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

  // И расставляем ферзей:
  for w:= 1 to 8 do board[w, all[num, w]]:= '  O ';
  for w:= 8 downto 1 do boardReverse[9-all[num, w], 9-w]:= '  O ';

  // И, наконец, выводим на экран:
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

// Тело основной программы
begin
  Writeln('Варианты оптимальных расстановок восьми ферзей с зеркальными парами относительно побочной диагонали:');
  Writeln;
  // Начальная инициализация:
  for i:= 1 to 8 do a[i]:= True;
  for i:= 2 to 16 do b[i]:= True;
  for i:= -7 to 7 do c[i]:= True;

  count:= 0;

  // И вызываем процедуру расстановки:
  TryIt(1);

  PrintAll; // Выводим результат на экран

  while True do
  begin
    Writeln;
    Writeln('Введите цифру варианта, который хотите распечатать, или 0 для выхода:');
    Readln(i);
    if (i > 0) and (i < 47) then
    begin
       // Writeln('Вариант расстановки номер ', i, ':');
       Writeln;
       printTwoBoard(i);
       // Readln;
    end
    else Break;
  end;



end.
