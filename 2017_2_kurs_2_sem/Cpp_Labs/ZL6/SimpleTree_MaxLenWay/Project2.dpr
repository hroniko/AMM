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

// Модуль реализации простейшего дерева и функций работы с ним

var myFile: Text; // Переменная типа Text для асоцииации с текстовым файлом
    tmp: Integer;

    uk, tmpNode: tree_ptr;
    sum, count, srednee: Integer;
    stroka, substroka : string;
    i:integer;

begin
  // Выводим информацию по задаче:
  Writeln('Бедарев А.А., ПММ, 2 курс, 2 семестр');
  clrscr;
  Writeln('Бедарев А.А., ПММ, 2 курс, 2 семестр');
  Writeln('Среди всех путей дерева, соединяющих вершины на разном');
  Writeln('уровне, выбрать путь максимальной длины, для которого');
  Writeln('сумма ключей конечных вершин минимальна.              ');
  Writeln('Среднюю вершину этого пути сделать корневой вершиной.');
  Writeln;  Writeln;

  // 1) --------------- Чтение из файла и формироание дерева ------------------
//  assign(myFile, 'in3.txt'); // Связываем файл с переменной myFile
//  reset(myFile); // Открываем файл на чтение
  Writeln('Введите последовательность положительных целых чисел через пробел или запятую: ');
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
         uk:= InsertKey(uk, StrToInt(substroka));  // и добавляем ее в дерево
         substroka:= '';
      end;
    end;    

  end;

  if Length(substroka) > 0 then uk:= InsertKey(uk, StrToInt(substroka));  // и добавляем ее в дерево




  // Читаем каждый элемент файла сразу в дерево:

  // 1) -----------------------------------------------------------------------

  // 2) --------------- Вывод исходного дерева в консоль ----------------------
  Write('Исходное дерево (прямой левый обход): ');
  FrontOrderLeft(uk); // Выводим на консоль прямым левым обходом наше дерево
  Writeln;

//   WriteLn('   Структура: ');
//   Writeln;
//   PrintLeftTree(uk); // Печать пространственного дерева
  // 2) -----------------------------------------------------------------------

  // 3) ------------------ Выполнение требований задания ----------------------
  //WriteLn('   Сумма конечных для корневого: ', SumKey_MaxLenWay(uk));
  tmpNode:= FindNodeBetween_MaxLenWay(uk);
  //WriteLn('Узел, через который проходит искомый путь: ', tmpNode^.key);
  WriteLn('Сумма конечных элементов для данного узла: ', SumKey_MaxLenWay(tmpNode) );
  //write('Путь максимальной длины: '); PrintMaxLenWay(tmpNode);
  Writeln('Длина пути: ', MaxLenWay(tmpNode), ' дуга(и)' );
  Writeln;

  // 4) Перестраиваем дерево:
  RebuildTree(uk, tmpNode);

  // 5) --------------- Вывод перестроенного дерева в консоль ----------------------
//  Write('Новое дерево (прямой левый обход): ');
//  FrontOrderLeft(tmpNode); // Выводим на консоль прямым левым обходом наше новое дерево
//  Writeln;

//  WriteLn('   Структура: ');
//  Writeln;
//  PrintLeftTree(tmpNode); // Печать пространственного дерева


  // Ищем и удаляем ПРАВЫМ удалением среднюю по значению
  uk:= FindMiddleAndRightRemove(uk);
  Writeln;
  // 3) -----------------------------------------------------------------------

  // 4) ------------- Вывод исправленного дерева в консоль --------------------
  Write('Новое дерево (прямой левый обход): ');
  FrontOrderLeft(uk); // Выводим на консоль прямым левым обходом наше дерево
  Writeln;

//  WriteLn('   Структура: ');
//  Writeln;
//  PrintLeftTree(uk); // Печать пространственного дерева
  // 4) -----------------------------------------------------------------------
  
  Readln;  // Ожидание нажатия клавиши и выход из программы
end.
