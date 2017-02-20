program ProjectZarina;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas', // Подключаем модуль русификации консоли
  Math, Windows; // Подключаем другие модули


// Быстрая сортировка с рекурсией:
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
procedure QuickSort(var arr: array of Integer);     // Начальная процедура для быстрой сортировки без рекурсии
var size: Integer;
begin
  size:= Length(arr);
  Sort(arr, 1, size-1); // Начинаем с первого элемента, так как нулевой под заглушку в других сортировках, а так надо бы Sort(arr, 0, size-1);
end;  

// Сортировка прямого обмена (Пузырьковая сортировка):
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



var a1, a2 : array of Integer; // Одномерный динамический массив для хранения промежуточного сортированного массива
    i : Integer;
    t1, t2 : LongInt;
    ssize, start, finish: Integer;
	
// ------------------------------------- ТЕЛО ОСНОВНОЙ ПРОГРАММЫ ---------------------------------------

begin
  { TODO -oUser -cConsole Main : Insert code here }

  // Выводим сообщение на экран об условиях задачи:
  Writeln('Задайте число элементов и диапазон:');

  read(ssize);
  read(start);
  read(finish);

  SetLength(a1, ssize + 1);  SetLength(a2, ssize + 1); // Установка длины одномерного массива

  a1[0]:= 0; // Заглушка
  a2[0]:= 0; // Заглушка
  Randomize;  for i:=1 to Length(a1)-1 do
  begin
  a1[i]:= RandomRange(start, finish);
  a2[i]:= a1[i];
  end;



  // for i := 1 to Length(a1)-1 do Write(a1[i], '; ');   // Выводим исходный массив

  // Засекаем начальное время:
  t1:= GetTickCount;
  // Выполняем сортировку массива:
 BubbleSort(a1);
  // Засекаем конечное время:
  t2:= GetTickCount;
  // Writeln; for i:= 1 to Length(a1)-1 do Write(a1[i], '; '); Writeln;  // Выводим отсортированный массив
  Writeln('Время сортировки пузырьком: ', t2-t1, ' мс');

    // Засекаем начальное время:
  t1:= GetTickCount;
  // Выполняем сортировку массива:
  QuickSort(a2);
  // Засекаем конечное время:
  t2:= GetTickCount;
  // Writeln; for i:= 1 to Length(a2)-1 do Write(a2[i], '; '); Writeln;  // Выводим отсортированный массив
  Writeln('Время быстрой сортировки с рекурсией: ', t2-t1, ' мс');

  Readln;    Readln;

end.
