program HorseMove;

{$APPTYPE CONSOLE}

uses
   // SysUtils;
   //crt32 in 'crt32.pas',
  Windows,
  EsConsole in 'EsConsole.pas';

type
  Array2 = array of array of Integer; // = array[1..8, 1..8] of Integer;


var i: Integer; // Счетчик возможных ходов из текущего положения, не больше 8
    j: Integer; // Счетчик всех ходов за время обхода, не более 64
    number: Integer; // Номер хода
    // Массив, определяющий направления возможных ходов по горизонтали
    horizontal: array[0..7] of integer = (2, 1, -1, -2, -2, -1, 1, 2);  // одномерный статический массив
    // Массив, определяющий направления возможных ходов по вертикали
    vertical:   array[0..7] of integer = (-1, -2, -2, -1, 1, 2, 2, 1);  // одномерный статический массив

    board, board1: Array2; // Двумерный динамический массив

    accessibility, accessibility1: Array2;
    x0, y0: Integer; // Координаты текущего положения коня
    x0R, y0R: Integer; // Координаты для рекурсивной функции
    x1, y1: Integer; // Координаты следующего положения коня
    xMin, yMin: Integer;
    M, N: Integer; // Размеры поля по горизонтали и вертикали
    numR: Integer;
    flagR: Integer;
    flag: Integer; // Флаг для сброса минимума
    accessCount: Integer; // Счетяик доступности клетки (количества возможных ходов в клетку в начале игры)
    defectCount: Integer; // Число запрещенных (дефектных) клеток

// Процедура очистки экрана
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

// Процедура печати в консоль схемы поля
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

// Процедура рекурсивного поиска оптимальной последовательности ходов
procedure FindRecursive(num: Integer; M: Integer; N: Integer; brd: Array2; acc: Array2; x0: Integer; y0: Integer);
// number - номер текущего хода, M, N - размеры доски, brd - текущий "снимок" доски с предыдущего ветвления,
// acc - текущий "снимок" матрицы доступности с предыдущего ветвления, x0 и y0 - текущая позиция коня с предыдущего ветвления
var flag: Integer;
    i: Integer;
    x1, x2: Integer;
    brd1: Array2; // Двумерный динамический массив
    acc1: Array2;
begin
  // Проверяем, не пора ли выйти:
  // Глобальное условие, для всех веток рекурсии:
  //if flagR <> 0 then Exit; // Если одна из веток уже выставила флаг, что решение достигнуто, то просто выходим
  if flagR = 0 then  // Если ни одна из веток еще не выставила флаг, что решение не достигнуто, продолжаем
  begin
    // Теперь локальное условие окончания (для текущей ветки):
    if num >= M*N then // Если сделали столько шагов, сколько нам надо, то сохраняем доску и выходим
    begin
      flagR:=1; // Выставляем флаг достижения условия, чтобы другие ветки не мучились
      // print(brd, M, N); // Печатаем результат
      board1:= brd;  // сохраняем
      accessibility1:= acc;  // сохраняем
    end

    else // иначе еще есть куда работать всем веткам, решаем теперь, что делать с текущей:

      if (0<=x0) and (x0<M) and (0<=y0) and (y0<N) and (brd[x0,y0] = 0) then // Если фигура вписывается в границы поля И если она еще не былы в этой позиции, то
      begin
        // Копируем массивы:
        SetLength(brd1, M, N); // Выделяем память
        SetLength(acc1, M, N); // Выделяем память
        for x1:=0 to M-1 do
          for y1:=0 to N-1 do
          begin
            brd1[x1, y1]:= brd[x1, y1];
            acc1[x1, y1]:= acc[x1, y1];
          end;
        Dec(acc1[x0,y0]); // В подходящей клетке уменьшаем количество путей к ней на 1
        num:= num + 1;
        brd1[x0,y0]:= num; // Ставим коня в текущее положение, записываем номер хода
        // Пробуем сделать восемь потенциально возможных ходов, проверяя, не выходим ли мы за границы поля
        for i:= 0 to 7 do
        begin
            FindRecursive(num, M, N, brd1, acc1, x0 + horizontal[i], y0 + vertical[i]);
          end;
        end

    else  // Иначе с этой веткой покончено, надо аккуратно ее прикрыть
    begin
      // Смотрим, лучше ли она других завершенных (а она лучше, если смогла сделать больше ходов):
      if num > numR then    // если лучше, то
      begin
        numR:= num; // Запоминаем, какое максимальное число ходов было вообще на текущий момент сделано
        // print(brd, M, N); // Печатаем результат
        board1:= brd;  // сохраняем
        accessibility1:= acc;  // сохраняем
      end;
    end;
  end;
end;






// НАЧАЛО ОСНОВНОЙ ПРОГРАММЫ:
begin
  // 0) Выводим условия задачи:
  // Выводим информацию по задаче:
  Writeln('| ------------------------------------------------------------- |');
  Writeln('| Бедарев А.А., ПММ, 2 курс, 1 семестр. Задание №4.             |');
  Writeln('| Определить, может ли шахматная фигура конь обойти все клетки  |');
  Writeln('| шахматной доски (кроме запрещенных), побывав на каждой из них |');
  Writeln('| только один раз? Размеры доски, начальная позиция фигуры и    |');
  Writeln('| расположение запрещенных клеток задаются пользователем.       |');
  Writeln('| ------------------------------------------------------------- |');
  Writeln;
  Writeln('Для продолжения нажмите Enter');
  Readln;

  // 1) Формируем доску: ------
  ClrScr; // Очищаем экран
  Writeln('Задайте размеры поля (количество клеток по горизонтали и по вертикали через пробел):');
  while True do
  begin
    read(M);
    read(N);
    if (M>4) or (N>4) then Break
    else Writeln('Поле слишком маленькое для перемещения фигуры, задайте корректный размер:');
  end;
  SetLength(board, M, N); // Выделяем память и
  for i:=0 to M-1 do  // заполняем нулями
    for j:=0 to N-1 do
      board[i,j]:=0;
  Writeln('Поле размером ', M, 'x', N,  ' клеток сформировано. Продолжим?');
  Readln;
  // --------------------------

  // 2) Выставляем на доске дефекты:
  ClrScr; // Очищаем экран
  Writeln('Задайте число запрещенных клеток (0, если дефектов нет):');
  while True do
  begin
    read(defectCount);
    if defectCount < M*N then Break
    else Writeln('Число запрещенных клеток слишком велико для текущих размеров доски! Задайте число меньше, чем ', M*N, ':');
  end;

  if defectCount > 0 then
  begin
    ClrScr;
    Writeln('Задайте координаты Х и У для ', defectCount , ' запрещенных клеток через пробел, например 1 1 и т.д:');
    for i:= 1 to defectCount do
    begin
      while True do
      begin
        read(x0);
        x0:= x0 - 1;
        read(y0);
        y0:= y0 - 1;
        if (0<=x0) and (x0<M) and (0<=y0) and (y0<N) then Break
        else Writeln('Координаты положения за пределами доски, задайте корректное положение:');
      end;
      board[x0, y0]:= -1; // Записываем -1 , что соответствует запрещенной клетке
      if defectCount-i > 0 then Writeln('Запрет добавлен. Осталось ', defectCount-i , ' запрещенных клеток. Продолжайте ввод:') else
      Writeln('Все запреты (', defectCount, ' шт) добавлены. Продолжим?');
    end; 
  end
  else  Writeln('Запрещенные клетки не заданы. Будет сформировано обычное поле. Продолжим?');
  Readln;    Readln;
  // --------------------------

  // 3) Формируем матрицу доступности (ходов для каждой ячейки):
  SetLength(accessibility, M, N); // Выделяем память и
  for x0:=0 to M-1 do
    for y0:=0 to N-1 do
	  begin
		  accessCount:=0;
		  for i:= 0 to 7 do
		  begin
			  x1:= x0 + horizontal[i]; // делаем смещение по х
			  y1:= y0 + vertical[i];   // делаем смещение по у
			  if (0<=x1) and (x1<M) and (0<=y1) and (y1<N) then // Если конь не вышел за границы поля, то
			  begin
			    Inc(accessCount); // Увеличиваем счетчик доступности
		    end;
		    accessibility[x0,y0]:= accessCount; // Записываем вычисленное значение числа доступных ходов
	    end;
    end;
  // print(accessibility, M, N);
  // Readln;

  // 4) Выбираем начало пути:
  ClrScr;
  Writeln('Задайте начальное положение фигуры (задайте координаты Х и У через пробел):');
  while True do
  begin
    read(x0);
    x0:= x0 - 1;
    read(y0);
    y0:= y0 - 1;
    ClrScr;
    if (0<=x0) and (x0<M) and (0<=y0) and (y0<N) and (board[x0,y0] > -1) then Break;
    if not ((0<=x0) and (x0<M) and (0<=y0) and (y0<N)) then Writeln('Координаты положения за пределами доски, задайте корректное положение:')
    else Writeln('Попытка установить фигуру в запрещенную клетку, задайте корректное положение:')
  end;
  Writeln('Фигура установлена в положение (', x0+1, ',', y0+1, '). Продолжим?');
  Readln;

  // 5) Делаем себе копию поля и массива доступности на случай, если придется задействовать рекурсивный поиск:
  // Копируем массивы:
  SetLength(board1, M, N); // Выделяем память
  SetLength(accessibility1, M, N); // Выделяем память
  for x1:=0 to M-1 do
    for y1:=0 to N-1 do
    begin
      board1[x1, y1]:= board[x1, y1];
      accessibility1[x1, y1]:= accessibility[x1, y1];
    end;
  x0R:= x0;
  y0R:= y0;

  // 6) Начинаем эвристический прямой обход
  number:=1;
  board[x0,y0]:= number;
  for number:=2 to M*N+1 do  // -1 от дефектной
  begin
    ClrScr;
    Writeln('Пошаговая отрисовка ходов фигуры на схеме доски: [.] разр, [*] запр');
    Writeln;
    print(board, M, N);
    Writeln;
    Writeln('Ход № ', number-1, ' из ', M*N-defectCount, ' необходимых. Для следующего хода нажмите Enter');

    readln;
    flag:=1; // Выставляем флаг того, что еще не выбрали клетки с минимальным значением доступности среди ходов из текущей клетки
    // 2) Пробуем сделать восемь потенциально возможных ходов, проверяя, не выходим ли мы за границы поля
    for i:= 0 to 7 do
    begin
      x1:= x0 + horizontal[i]; // делаем смещение по х
      y1:= y0 + vertical[i];   // делаем смещение по у
      if (0<=x1) and (x1<M) and (0<=y1) and (y1<N) and (board[x1,y1] = 0) then // Если конь не вышел за границы поля И если он еще не был в этой позиции, то
      begin
        // Writeln('(', x1, ',', y1, ')'); // Печать подходящей координаты
        Dec(accessibility[x1,y1]); // В подходящей клетке уменьшаем количество путей к ней на 1
        // и тут же проверяем, не является ли количество путей в эту клетку минимальным из известных подходящих:

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
      // А если флаг не поменлся, значит, нам больше некуда идти! Нет больще доступных ходов
      if number < M*N-defectCount then Writeln('Нет больше ходов! (доступно ', number-1, ' ходов из ', M*N-defectCount, '). Полный обход невозможен.');
      break;
    end;
    // Теперь, когда у нас есть подходящее место для перехода, делаем ход конем в него,
    x0:= xMin;  // переходим по х в новое положение
    y0:= yMin;  // переходим по у в новое положение
    board[x0,y0]:= number; // и вписываем в ячейку нового положеня на доске номер хода
  end;
  ClrScr;
  Writeln('Пошаговая отрисовка ходов фигуры на схеме доски (завершено):');
  Writeln;
  print(board, M, N);
  Writeln;
  Writeln('Обход завершен!');
  if number <= M*N-defectCount then Writeln('Нет больше ходов! (доступно ', number-1, ' ходов из ', M*N-defectCount, '). Полный обход невозможен.');
  //Освобождаем память
  board:= nil;
  accessibility:= nil;

  // 7) Если не вышло эвристикой, попробуем рекурсивный обход:
  if (number < M*N) then  //   (M*N-defectCount > 30) условие для того, что если больше 36, то рекурсия считает оооочень долго
  begin
    Write('Попробуем рекурсивный поиск?');
    if (M*N-defectCount > 30) then
    begin
      Writeln(' (да 1, нет 0)');
      Writeln('ВНИМАНИЕ! На большм количестве клеток (более 30) может выполняться очень долго!');
      read(x1);
    end
    else
    begin
      x1:= 1;
      readln;
    end;



    if x1 = 1 then
    begin
      Writeln('Ждите, запущен рекурсивный поиск...');
      //Начинаем рекурсивный поиск оптимальной последовательности ходов:
      number:= 0; numR:= 0; flagR:=0;
      FindRecursive(number, M, N, board1, accessibility1, x0R, y0R);
      //
      Writeln('Рекурсивный поиск оптимальных ходов фигуры на схеме доски (завершено):');
      Writeln;
      print(board1, M, N);
      Writeln;
      Writeln('Обход завершен!');
      if number < M*N then Writeln('Нет больше ходов! (доступно ', numR, ' ходов из ', M*N-defectCount, '). Полный обход невозможен.');
      //Освобождаем память
      board1:= nil;
      accessibility1:= nil;

    end;



  end;

 // ----------------------------

  Writeln('Для Выхода нажмите Enter');
  readln;  readln;

end.
