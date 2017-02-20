program HorseMove;

{$APPTYPE CONSOLE}

uses
   // SysUtils;
   //crt32 in 'crt32.pas',
  Windows,
  EsConsole in 'EsConsole.pas';

type
  Array2 = array of array of Integer; // = array[1..8, 1..8] of Integer;


var i: Integer; // ������� ��������� ����� �� �������� ���������, �� ������ 8
    j: Integer; // ������� ���� ����� �� ����� ������, �� ����� 64
    number: Integer; // ����� ����
    // ������, ������������ ����������� ��������� ����� �� �����������
    horizontal: array[0..7] of integer = (2, 1, -1, -2, -2, -1, 1, 2);  // ���������� ����������� ������
    // ������, ������������ ����������� ��������� ����� �� ���������
    vertical:   array[0..7] of integer = (-1, -2, -2, -1, 1, 2, 2, 1);  // ���������� ����������� ������

    board, board1: Array2; // ��������� ������������ ������

    accessibility, accessibility1: Array2;
    x0, y0: Integer; // ���������� �������� ��������� ����
    x0R, y0R: Integer; // ���������� ��� ����������� �������
    x1, y1: Integer; // ���������� ���������� ��������� ����
    xMin, yMin: Integer;
    M, N: Integer; // ������� ���� �� ����������� � ���������
    numR: Integer;
    flagR: Integer;
    flag: Integer; // ���� ��� ������ ��������
    accessCount: Integer; // ������� ����������� ������ (���������� ��������� ����� � ������ � ������ ����)
    defectCount: Integer; // ����� ����������� (���������) ������

// ��������� ������� ������
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

// ��������� ������ � ������� ����� ����
procedure print(arr: Array2; m: Integer; n: Integer);
var k, s: Integer;
begin
  for k:=0 to m-1 do
  begin
    for s:=0 to n-1 do
    begin
      if arr[k,s] = -1 then Write('  * ');
      if arr[k,s] = 0 then Write('  . ');
      if (0 < arr[k,s]) and (arr[k,s] < 10) then Write('  ', arr[k,s], ' ');
      if (9 < arr[k,s]) and (arr[k,s] < 100) then Write(' ', arr[k,s], ' ');
      if arr[k,s] > 99 then Write(arr[k,s], ' ');
    end;
    Writeln;
    Writeln;
  end;
end;

// ��������� ������������ ������ ����������� ������������������ �����
procedure FindRecursive(num: Integer; M: Integer; N: Integer; brd: Array2; acc: Array2; x0: Integer; y0: Integer);
// number - ����� �������� ����, M, N - ������� �����, brd - ������� "������" ����� � ����������� ���������,
// acc - ������� "������" ������� ����������� � ����������� ���������, x0 � y0 - ������� ������� ���� � ����������� ���������
var flag: Integer;
    i: Integer;
    x1, x2: Integer;
    brd1: Array2; // ��������� ������������ ������
    acc1: Array2;
begin
  // ���������, �� ���� �� �����:
  // ���������� �������, ��� ���� ����� ��������:
  //if flagR <> 0 then Exit; // ���� ���� �� ����� ��� ��������� ����, ��� ������� ����������, �� ������ �������
  if flagR = 0 then  // ���� �� ���� �� ����� ��� �� ��������� ����, ��� ������� �� ����������, ����������
  begin
    // ������ ��������� ������� ��������� (��� ������� �����):
    if num >= M*N then // ���� ������� ������� �����, ������� ��� ����, �� ��������� ����� � �������
    begin
      flagR:=1; // ���������� ���� ���������� �������, ����� ������ ����� �� ��������
      // print(brd, M, N); // �������� ���������
      board1:= brd;  // ���������
      accessibility1:= acc;  // ���������
    end

    else // ����� ��� ���� ���� �������� ���� ������, ������ ������, ��� ������ � �������:

      if (0<=x0) and (x0<M) and (0<=y0) and (y0<N) and (brd[x0,y0] = 0) then // ���� ������ ����������� � ������� ���� � ���� ��� ��� �� ���� � ���� �������, ��
      begin
        // �������� �������:
        SetLength(brd1, M, N); // �������� ������
        SetLength(acc1, M, N); // �������� ������
        for x1:=0 to M-1 do
          for y1:=0 to N-1 do
          begin
            brd1[x1, y1]:= brd[x1, y1];
            acc1[x1, y1]:= acc[x1, y1];
          end;
        Dec(acc1[x0,y0]); // � ���������� ������ ��������� ���������� ����� � ��� �� 1
        num:= num + 1;
        brd1[x0,y0]:= num; // ������ ���� � ������� ���������, ���������� ����� ����
        // ������� ������� ������ ������������ ��������� �����, ��������, �� ������� �� �� �� ������� ����
        for i:= 0 to 7 do
        begin
            FindRecursive(num, M, N, brd1, acc1, x0 + horizontal[i], y0 + vertical[i]);
          end;
        end

    else  // ����� � ���� ������ ���������, ���� ��������� �� ��������
    begin
      // �������, ����� �� ��� ������ ����������� (� ��� �����, ���� ������ ������� ������ �����):
      if num > numR then    // ���� �����, ��
      begin
        numR:= num; // ����������, ����� ������������ ����� ����� ���� ������ �� ������� ������ �������
        // print(brd, M, N); // �������� ���������
        board1:= brd;  // ���������
        accessibility1:= acc;  // ���������
      end;
    end;
  end;
end;






// ������ �������� ���������:
begin
  // 0) ������� ������� ������:
  // ������� ���������� �� ������:
  Writeln('| ------------------------------------------------------------- |');
  Writeln('| ������� �.�., ���, 2 ����, 1 �������. ������� �4.             |');
  Writeln('| ����������, ����� �� ��������� ������ ���� ������ ��� ������  |');
  Writeln('| ��������� ����� (����� �����������), ������� �� ������ �� ��� |');
  Writeln('| ������ ���� ���? ������� �����, ��������� ������� ������ �    |');
  Writeln('| ������������ ����������� ������ �������� �������������.       |');
  Writeln('| ------------------------------------------------------------- |');
  Writeln;
  Writeln('��� ����������� ������� Enter');
  Readln;

  // 1) ��������� �����: ------
  ClrScr; // ������� �����
  Writeln('������� ������� ���� (���������� ������ �� ����������� � �� ��������� ����� ������):');
  while True do
  begin
    read(M);
    read(N);
    if (M>4) or (N>4) then Break
    else Writeln('���� ������� ��������� ��� ����������� ������, ������� ���������� ������:');
  end;
  SetLength(board, M, N); // �������� ������ �
  for i:=0 to M-1 do  // ��������� ������
    for j:=0 to N-1 do
      board[i,j]:=0;
  Writeln('���� �������� ', M, 'x', N,  ' ������ ������������. ���������?');
  Readln;
  // --------------------------

  // 2) ���������� �� ����� �������:
  ClrScr; // ������� �����
  Writeln('������� ����� ����������� ������ (0, ���� �������� ���):');
  while True do
  begin
    read(defectCount);
    if defectCount < M*N then Break
    else Writeln('����� ����������� ������ ������� ������ ��� ������� �������� �����! ������� ����� ������, ��� ', M*N, ':');
  end;

  if defectCount > 0 then
  begin
    ClrScr;
    Writeln('������� ���������� � � � ��� ', defectCount , ' ����������� ������ ����� ������, �������� 1 1 � �.�:');
    for i:= 1 to defectCount do
    begin
      while True do
      begin
        read(x0);
        x0:= x0 - 1;
        read(y0);
        y0:= y0 - 1;
        if (0<=x0) and (x0<M) and (0<=y0) and (y0<N) then Break
        else Writeln('���������� ��������� �� ��������� �����, ������� ���������� ���������:');
      end;
      board[x0, y0]:= -1; // ���������� -1 , ��� ������������� ����������� ������
      if defectCount-i > 0 then Writeln('������ ��������. �������� ', defectCount-i , ' ����������� ������. ����������� ����:') else
      Writeln('��� ������� (', defectCount, ' ��) ���������. ���������?');
    end; 
  end
  else  Writeln('����������� ������ �� ������. ����� ������������ ������� ����. ���������?');
  Readln;    Readln;
  // --------------------------

  // 3) ��������� ������� ����������� (����� ��� ������ ������):
  SetLength(accessibility, M, N); // �������� ������ �
  for x0:=0 to M-1 do
    for y0:=0 to N-1 do
	  begin
		  accessCount:=0;
		  for i:= 0 to 7 do
		  begin
			  x1:= x0 + horizontal[i]; // ������ �������� �� �
			  y1:= y0 + vertical[i];   // ������ �������� �� �
			  if (0<=x1) and (x1<M) and (0<=y1) and (y1<N) then // ���� ���� �� ����� �� ������� ����, ��
			  begin
			    Inc(accessCount); // ����������� ������� �����������
		    end;
		    accessibility[x0,y0]:= accessCount; // ���������� ����������� �������� ����� ��������� �����
	    end;
    end;
  // print(accessibility, M, N);
  // Readln;

  // 4) �������� ������ ����:
  ClrScr;
  Writeln('������� ��������� ��������� ������ (������� ���������� � � � ����� ������):');
  while True do
  begin
    read(x0);
    x0:= x0 - 1;
    read(y0);
    y0:= y0 - 1;
    ClrScr;
    if (0<=x0) and (x0<M) and (0<=y0) and (y0<N) and (board[x0,y0] > -1) then Break;
    if not ((0<=x0) and (x0<M) and (0<=y0) and (y0<N)) then Writeln('���������� ��������� �� ��������� �����, ������� ���������� ���������:')
    else Writeln('������� ���������� ������ � ����������� ������, ������� ���������� ���������:')
  end;
  Writeln('������ ����������� � ��������� (', x0+1, ',', y0+1, '). ���������?');
  Readln;

  // 5) ������ ���� ����� ���� � ������� ����������� �� ������, ���� �������� ������������� ����������� �����:
  // �������� �������:
  SetLength(board1, M, N); // �������� ������
  SetLength(accessibility1, M, N); // �������� ������
  for x1:=0 to M-1 do
    for y1:=0 to N-1 do
    begin
      board1[x1, y1]:= board[x1, y1];
      accessibility1[x1, y1]:= accessibility[x1, y1];
    end;
  x0R:= x0;
  y0R:= y0;

  // 6) �������� ������������� ������ �����
  number:=1;
  board[x0,y0]:= number;
  for number:=2 to M*N+1 do  // -1 �� ���������
  begin
    ClrScr;
    Writeln('��������� ��������� ����� ������ �� ����� �����: [.] ����, [*] ����');
    Writeln;
    print(board, M, N);
    Writeln;
    Writeln('��� � ', number-1, ' �� ', M*N-defectCount, ' �����������. ��� ���������� ���� ������� Enter');

    readln;
    flag:=1; // ���������� ���� ����, ��� ��� �� ������� ������ � ����������� ��������� ����������� ����� ����� �� ������� ������
    // 2) ������� ������� ������ ������������ ��������� �����, ��������, �� ������� �� �� �� ������� ����
    for i:= 0 to 7 do
    begin
      x1:= x0 + horizontal[i]; // ������ �������� �� �
      y1:= y0 + vertical[i];   // ������ �������� �� �
      if (0<=x1) and (x1<M) and (0<=y1) and (y1<N) and (board[x1,y1] = 0) then // ���� ���� �� ����� �� ������� ���� � ���� �� ��� �� ��� � ���� �������, ��
      begin
        // Writeln('(', x1, ',', y1, ')'); // ������ ���������� ����������
        Dec(accessibility[x1,y1]); // � ���������� ������ ��������� ���������� ����� � ��� �� 1
        // � ��� �� ���������, �� �������� �� ���������� ����� � ��� ������ ����������� �� ��������� ����������:

        //Readln;
        if flag = 1 then
        begin
          xMin:= x1;
          yMin:= y1;
          flag:= 0;
        end;

        if accessibility[x1,y1] < accessibility[xMin,yMin] then
        begin
          xMin:= x1;
          yMin:= y1;
        end;
      end;
    end;

    if flag = 1 then //begin Writeln; print(board, N); Writeln; end; //Writeln('Error');
    begin
      // � ���� ���� �� ��������, ������, ��� ������ ������ ����! ��� ������ ��������� �����
      if number < M*N-defectCount then Writeln('��� ������ �����! (�������� ', number-1, ' ����� �� ', M*N-defectCount, '). ������ ����� ����������.');
      break;
    end;
    // ������, ����� � ��� ���� ���������� ����� ��� ��������, ������ ��� ����� � ����,
    x0:= xMin;  // ��������� �� � � ����� ���������
    y0:= yMin;  // ��������� �� � � ����� ���������
    board[x0,y0]:= number; // � ��������� � ������ ������ �������� �� ����� ����� ����
  end;
  ClrScr;
  Writeln('��������� ��������� ����� ������ �� ����� ����� (���������):');
  Writeln;
  print(board, M, N);
  Writeln;
  Writeln('����� ��������!');
  if number <= M*N-defectCount then Writeln('��� ������ �����! (�������� ', number-1, ' ����� �� ', M*N-defectCount, '). ������ ����� ����������.');
  //����������� ������
  board:= nil;
  accessibility:= nil;

  // 7) ���� �� ����� ����������, ��������� ����������� �����:
  if (number < M*N) then  //   (M*N-defectCount > 30) ������� ��� ����, ��� ���� ������ 36, �� �������� ������� �������� �����
  begin
    Write('��������� ����������� �����?');
    if (M*N-defectCount > 30) then
    begin
      Writeln(' (�� 1, ��� 0)');
      Writeln('��������! �� ������ ���������� ������ (����� 30) ����� ����������� ����� �����!');
      read(x1);
    end
    else
    begin
      x1:= 1;
      readln;
    end;



    if x1 = 1 then
    begin
      Writeln('�����, ������� ����������� �����...');
      //�������� ����������� ����� ����������� ������������������ �����:
      number:= 0; numR:= 0; flagR:=0;
      FindRecursive(number, M, N, board1, accessibility1, x0R, y0R);
      //
      Writeln('����������� ����� ����������� ����� ������ �� ����� ����� (���������):');
      Writeln;
      print(board1, M, N);
      Writeln;
      Writeln('����� ��������!');
      if number < M*N then Writeln('��� ������ �����! (�������� ', numR, ' ����� �� ', M*N-defectCount, '). ������ ����� ����������.');
      //����������� ������
      board1:= nil;
      accessibility1:= nil;

    end;



  end;

 // ----------------------------

  Writeln('��� ������ ������� Enter');
  readln;  readln;

end.
