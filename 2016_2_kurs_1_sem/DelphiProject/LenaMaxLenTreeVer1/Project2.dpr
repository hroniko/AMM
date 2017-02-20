program Project2;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas',
  MySimpleTree in 'MySimpleTree.pas';

// Модуль реализации простейшего дерева и функций работы с ним

var myFile: Text; // Переменная типа Text для асоцииации с текстовым файлом
    tmp: Integer;

    uk, tmpNode: tree_ptr;
    sum, count, srednee: Integer;

begin

  // 1) --------------- Чтение из файла и формироание дерева ------------------
  assign(myFile, 'in2.txt'); // Связываем файл с переменной myFile
  reset(myFile); // Открываем файл на чтение
  // Читаем каждый элемент файла сразу в дерево:
  tmp:= 0;
  while not Eof(myFile) do // Запускаем цикл чтения чисел из файла
    begin
      readln(myFile, tmp); // Считываем число во временную перемнную
      uk:= InsertKey(uk, tmp);  // и добавляем ее в дерево
    end;
  close(myFile); // Закрываем файл, освобождаем ресурсы
  // 1) -----------------------------------------------------------------------

  // 2) --------------- Вывод исходного дерева в консоль ----------------------
  Write('Исходное дерево (прямой левый обход): ');
  FrontOrderLeft(uk); // Выводим на консоль прямым левым обходом наше дерево
  Writeln;

////  WriteLn('   Исходная структура: ');
////  Writeln;
////  PrintLeftTree(uk); // Печать пространственного дерева


  // --------------- Вывод перестроенного дерева в консоль ----------------------
  tmpNode:= Find_AllNode_Between_MaxLenWay(uk);
  Write('Искомые вершины (прямой левый обход): ');
  FrontOrderLeft(tmpNode); // Выводим на консоль прямым левым обходом наше новое дерево
  Writeln;

  tmp:= Find_AllNode_Between_MaxLenWay2(uk);
  if tmp < 0 then  Write('Удаляемая вершина : нет ')
  else
  begin

    Write('Удаляем правым удалением вершину :    ', tmp);
    uk:= RightRemoveKey(uk, tmp); // Удаляем ПРАВЫМ удалением эту вершину по ее ключу
    Writeln;

////    WriteLn('   Структура дерева после удаления: ');
////    Writeln;
////    PrintLeftTree(uk); // Печать пространственного дерева
////    Writeln;

    Write('Новое дерево (прямой левый обход):    ');
    FrontOrderLeft(uk); // Выводим на консоль прямым левым обходом наше дерево
  end;
  Writeln;
  Readln;  // Ожидание нажатия клавиши и выход из программы
end.
