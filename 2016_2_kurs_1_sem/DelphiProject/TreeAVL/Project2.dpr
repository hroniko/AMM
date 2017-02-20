program Project2;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas', // Подключаем модуль русификации консоли
  // SysUtils, // уже не нужен, есть EsConsole для этих целей
  MyTree in 'MyTree.pas'; // Модуль реализации АВР-дерева и функций работы с ним

var arr: array of Integer;
    var myFile: Text; // Объявляем переменную типа Text для асоцииации с  текстовым файлом
    i: Integer;

    uk: tree_ptr;

    sum, count, srednee: Integer;

begin
  { TODO -oUser -cConsole Main : Insert code here }

  // Выводим информацию по задаче:
  Writeln('| ------------------------------------------------------- |');
  Writeln('| Бедарев А.А., ПММ, 2 курс, 1 семестр. Задание 2, Вар. 3 |');
  Writeln('| Найти и удалить (правым удалением) среднюю по значению  |');
  Writeln('| вершину из вершин дерева, у которых количество потомков |');
  Writeln('| в левом поддереве отличается от количества потомков в   |');
  Writeln('| правом поддереве на 1. Выполнить прямой (левый) обход   |');
  Writeln('| полученного дерева.                                     |');
  Writeln('| ------------------------------------------------------- |');
  Writeln;

  SetLength(arr, 21);  // Установка длины одномерного массива
  assign(myFile, 'in.txt'); // Связываем файл с переменной myFile
  reset(myFile); // Открываем файл на чтение

  // Читаем файл в массив:
  i:= 0;
  while not Eof(myFile) do // Запускаем цикл чтения чисел из файла
    begin
      readln(myFile, arr[i]); // Считываем число в массив
      Inc(i);
    end;
  close(myFile); // Закрываем файл, освобождаем ресурсы

  // И переносим массив в сбалансированное дерево (по Вирту)
  // uk:= MassiveToBalancedTree(arr);

  //for i:=0 to 20 do write(arr[i], ' ');
  //FrontOrderLeft(uk);  Writeln;
  //FrontOrderRight(uk); Writeln;

  // Пробегаем по массиву и вставлем каждый элемент массива как ключ АВР-дерева:
  for i:=0 to 20 do uk:= InsertKey(uk, arr[i]);
  Write('-> '); Writeln('Исходное дерево (прямой левый обход):');
  Write('   '); FrontOrderLeftPosition(uk);  Writeln; // Выводим на консоль прямым левым обходом то, что получилось, наше дерево

  //
  Writeln;
  Write('-> '); Write('Подходящие вершины: '); sum:= SumLR(uk);
  Writeln;
  Write('-> '); Writeln('Сумма подходящих ключей = ', sum);
  Write('-> '); Write('Количество ключей = '); count:= CountLR(uk); Writeln(count);
  Write('-> '); Write('Удаляемая вершина (среднее значение) = '); srednee:= sum div count; Writeln(srednee);
  Writeln;
  NormPrintTree(uk);

  // FrontOrderLeft(uk);  Writeln;

  ////uk:= RemoveKey(uk, srednee); // Удаляем ненужный элемент
  ////Write('-> '); Writeln('Дерево после удаления элемента (прямой левый обход):');
  ////Write('   '); FrontOrderLeftPosition(uk);  Writeln;


  // uk:= RemoveKey(uk, 1);
  // FrontOrderLeft(uk);  Writeln;


  // PrintTree(uk, 0); // Печать пространственного дерева

  Readln;
end.
