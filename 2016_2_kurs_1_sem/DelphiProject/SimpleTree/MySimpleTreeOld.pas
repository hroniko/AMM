unit MySimpleTreeOld; // Модуль реализации простых деревьев

interface // ---- Раздел описаний ---

uses SysUtils, Math,
    MySimpleSort;  // Подключаем модуль с реализацией сортировок
    
// Описание типа - структура бинарного дерева на указателях:
// Представление в виде списковой структуры:
type
  tree_ptr = ^ tree_node;
  tree_node = record
     key: Integer;    // Ключ узла
     height: Integer; // Высота узла (расстояние в дугах от узла до наиболее удаленного потомка)
     depth: Integer; // Глубина узла (расстояние в дугах от корня до узла)
     weight: Integer; // Смещение влево-вправо относительно корневого элемента (по горизонтали)
     info: string;  // Информационное поле, пока не используется
     //element: Real; // Вещественное значение, пока не используется
     left: tree_ptr; // Левый потомок (указатель)
     right: tree_ptr; // Правый потомок (указатель)
  end;

type
  Mass = array of Integer;

procedure FrontOrderLeft(v: tree_ptr);  // 1) Процедура прямого левого обхода с выводом ключа на консоль
procedure FrontOrderLeftPosition(v: tree_ptr);  // 1-1) Процедура прямого левого обхода с выводом ключа и положения на консоль
procedure FrontOrderRight(v: tree_ptr); // 2) Процедура прямого правого обхода с выводом на консоль
procedure BackOrderLeft(v: tree_ptr);   // 3) Процедура обратного левого обхода с выводом на консоль
procedure BackOrderRight(v: tree_ptr);  // 4) Процедура обратного правого обхода с выводом на консоль
procedure InnerOrderLeft(v: tree_ptr);  // 5) Процедура левого внутреннего обхода с выводом на консоль
procedure InnerOrderRight(v: tree_ptr); // 6) Процедура правого внутреннего обхода с выводом на консоль

//
procedure PrintTree(t: tree_ptr; h: Integer); // 9) Процедура печати дерева с h отступами


procedure CreateFullTree(p: tree_ptr; h: Integer);
procedure CopyFullTree(sourse: tree_ptr; receiver: tree_ptr);

procedure PrintLeftTree(v: tree_ptr);

procedure PrintLevel(v: tree_ptr; level: Integer; h: Integer);
procedure PrintLine(v: tree_ptr; level: Integer; h: Integer);


function HeightNode(t: tree_ptr): Integer;    // 10) Функция возврата высоты узла
function FixHeight(v: tree_ptr): Integer; // 11) Функция определения высоты вершины


// 16) Функция вставки ключа k в дерево с корнем p:
function InsertKey(p: tree_ptr; k: Integer): tree_ptr;
procedure BalancedDepthWeightHeight(v: tree_ptr; d: Integer; w: Integer);
//
// 17) Вспомогательная функция поиска узла с минимальным ключем в дереве p
function FindMinNode(p: tree_ptr): tree_ptr;
// 17) Вспомогательная функция поиска узла с максимаьным ключем в дереве p
function FindMaxNode(p: tree_ptr): tree_ptr;
//
function RemoveMinNode(p: tree_ptr): tree_ptr; // 18) Cлужебная функция для удаления минимального элемента из заданного дерева:
function RemoveMaxNode(p: tree_ptr): tree_ptr; // 18) Cлужебная функция для удаления максимального элемента из заданного дерева:
//
function RightRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // Функция ПРАВОГО удаления элемента по его ключу
function LeftRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // Функция ЛЕВОГО удаления элемента по его ключу

//

function ParentCount(v: tree_ptr): Integer;
procedure CopyLR(v: tree_ptr; var arr : Mass);
function CopyLRtoMassiv(v: tree_ptr): Mass;
function CountLR(v: tree_ptr): Integer;

//

function FindMiddleAndRightRemove(v: tree_ptr): tree_ptr; // Функция поиска и ПРАВОГО удаления средней по значению вершины среди тех, у который количество потомков справа и слева отличаются на 1
function FindMiddleAndLeftRemove(v: tree_ptr): tree_ptr; // Функция поиска и ЛЕВОГО удаления средней по значению вершины среди тех, у который количество потомков справа и слева отличаются на 1

//

procedure PrintArr(arr: Mass);

var i: Integer;
    massiv: array of Integer;
    masPlot: array of Char;
    msv: array of array of String;  // Динамический двумерный массив на делфи
    

implementation // ---- Раздел реализаций ---


// -----------------------------------------------------------------------------
// ПРЯМОЙ ОБХОД
// Прямой порядок обхода (FrontOrder, DirectOrder, TopDownOrder, сверху вниз)
// заключается в том, что корень некоторого дерева посещается раньше,
// чем его поддеревья. Если после корня посещается его левое (правое)
// поддерево, то обход называется прямым левым (правым) обходом.

// 1) Процедура прямого левого обхода с выводом ключа на консоль
procedure FrontOrderLeft(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, ' '); // Напечатать значение ключа
    FrontOrderLeft(v^.left);
    FrontOrderLeft(v^.right);
  end;
end;
// 1.1) Процедура прямого левого обхода с выводом ключа и позиции на консоль
procedure FrontOrderLeftPosition(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, '[', v^.depth, ',', v^.weight, ',', v^.height, '] '); // Напечатать значение ключа
    FrontOrderLeftPosition(v^.left);
    FrontOrderLeftPosition(v^.right);
  end;
end;

// 2) Процедура прямого правого обхода с выводом на консоль
procedure FrontOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, ' '); // Напечатать значение ключа
    FrontOrderRight(v^.right);
    FrontOrderRight(v^.left);
  end;
end;

// -----------------------------------------------------------------------------
// ОБРАТНЫЙ ОБХОД
// Обратный порядок обхода (BackOrder, DownTopOrder, снизу вверх)
// заключается в том, что корень дерева посещается после его поддеревьев.
// Если сначала посещается левое (правое) поддерево корня,
// то обход называется обратным левым (правым) обходом.

// 3) Процедура обратного левого обхода с выводом на консоль
procedure BackOrderLeft(v: tree_ptr);
begin
  if v <> nil then
  begin
    BackOrderLeft(v^.left);
    BackOrderLeft(v^.right);
    Write(v^.key, ' '); // Напечатать значение ключа
  end;
end;

// 4) Процедура обратного правого обхода с выводом на консоль
procedure BackOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    BackOrderRight(v^.right);
    BackOrderRight(v^.left);
    Write(v^.key, ' '); // Напечатать значение ключа
  end;
end;

// -----------------------------------------------------------------------------
// ВНУТРЕННИЙ ОБХОД
// Внутренний порядок обхода (InnnerOrder, слева направо или справа налево)
// заключается в том, что корень посещается после посещения одного из его
// поддеревьев. Если корень посещается после посещения его левого (правого)
// поддерева, то обход называется внутренним левым (правым) обходом. Заметим,
// что внутренний левый (правый) обход посещает вершины дерева в порядке
// возрастания (убывания) ключей вершин.

// 5) Процедура левого внутреннего обхода с выводом на консоль
procedure InnerOrderLeft(v: tree_ptr);
begin 
  if v <> nil then
  begin
    InnerOrderLeft(v^.left);
    Write(v^.key, ' '); // Напечатать значение ключа
    InnerOrderLeft(v^.right);
  end;
end;

// 6) Процедура правого внутреннего обхода с выводом на консоль
procedure InnerOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    InnerOrderRight(v^.right);
    Write(v^.key, ' ');
    InnerOrderRight(v^.left);
  end;
end;

// -----------------------------------------------------------------------------
// ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ

// 7) Процедура печати дерева с h отступами
procedure PrintTree(t: tree_ptr; h: Integer);
var j: Integer;
begin
  if t <> nil then
  begin
    PrintTree(t^.left, h+1);
    for j:= 0 to h do Write(#9); // Знак табуляции
    Writeln(t^.key);
    Writeln;
    PrintTree(t^.right, h+1);
  end;
end;

procedure CreateFullTree(p: tree_ptr; h: Integer);
var q, r: tree_ptr;
begin
  if h > 0 then
  begin
    New(q);
    q^.key:= 0;
    q^.height:=0;
    q^.depth:= 0;
    q^.weight:= 0;
    q^.left:= nil;
    q^.right:= nil;
    q^.info:= 'N';

    p^.left:= q;

    New(r);
    r^.key:= 0;
    r^.height:=0;
    r^.depth:= 0;
    r^.weight:= 0;
    r^.left:= nil;
    r^.right:= nil;
    r^.info:= 'N';

    p^.right:= r;

    CreateFullTree(p^.left, h-1);
    CreateFullTree(p^.right, h-1);
  end;
end;

procedure CopyFullTree(sourse: tree_ptr; receiver: tree_ptr);  // Обходим прямым левым обходом
begin
  if sourse <> nil then
  begin
    receiver^.key:= sourse^.key;
    receiver^.info:= sourse^.info;
    CopyFullTree(sourse^.left, receiver^.left);
    CopyFullTree(sourse^.right, receiver^.right);
  end;
end;


// 8) Процедура печати дерева
procedure PrintLeftTree(v: tree_ptr);
var lv, h, t: Integer;
    fullTree: tree_ptr;
begin
  h:= v^.height;
  // Создадим новое НАСЫЩЕННОЕ дерево:
  New(fullTree);
  CreateFullTree(fullTree, h);  //PrintTree(fullTree, h);
  BalancedDepthWeightHeight(fullTree, 0, 0);
  // И перенесем значения из нашего исходного дерева в это подставное дерево:
  CopyFullTree(v, fullTree);


  for lv:= 0 to h do
  begin
    // Делаем отступ слева:
    t:= 1;
    while t < ( Power( 2, (h - lv) ) ) do
    begin
      write(' ');
      t:= t + 1;
    end;
    PrintLevel(fullTree, lv, h);
    Writeln;
        t:= 1;
    while t < ( Power( 2, (h - lv) ) ) do
    begin
      write(' ');
      t:= t + 1;
    end;
     PrintLine(fullTree, lv, h);
     Writeln;
  end;
end;

// 9)
procedure PrintLevel(v: tree_ptr; level: Integer; h: Integer);
var t: Integer;
begin
  if  v <> nil  then
  begin
    if v^.depth = level then
    begin
      Write(v^.info); // Напечатать значение ключа

      // Делаем необходимый отступ после каждого элемента:
      t:= 1;
      while t < ( Power( 2, (h+1-level) ) ) do
      begin
        write(' ');
        t:= t + 1;
      end;
    end;
    PrintLevel(v^.left, level, h);
    PrintLevel(v^.right, level, h);
  end;

end;


procedure PrintLine(v: tree_ptr; level: Integer; h: Integer);
var t: Integer;
begin
  if  v <> nil  then
  begin
    if v^.depth = level then
    begin
      t:=1;
      while t < Length(v^.info) do
      begin
        write(' ');
        t:= t + 1;
      end;

      Write('|'); // Напечатать значение ключа

      // Делаем необходимый отступ после каждого элемента:
      t:= 1;
      while t < ( Power( 2, (h+1-level) ) ) do
      begin
        write(' ');
        t:= t + 1;
      end;
    end;
    PrintLine(v^.left, level, h);
    PrintLine(v^.right, level, h);
  end;

end;



// -----------------------------------------------------------------------------
// ФУНКЦИИ ДЛЯ РЕАЛИЗАЦИИ ДЕРЕВА, ВСТАВКА ЭЛЕМЕНТА

// 10) Функция возврата высоты узла:
function HeightNode(t: tree_ptr): Integer;
begin
  if t <> nil then
  HeightNode:= t^.height
  else HeightNode:= 0;
end;

function FixHeight(v: tree_ptr): Integer;
var left, right: Integer;
begin
  if v <> nil then
  begin
    left := FixHeight(v^.left);
    right := FixHeight(v^.right);
    if left > right then FixHeight := left+1
    else Result := right+1
  end
  else
  Result := -1;
end;

// 16) Функция вставки ключа k в дерево с корнем p:
function InsertKey(p: tree_ptr; k: Integer): tree_ptr;
begin
  if p = nil then
  begin
    New(p);
    p^.key:= k;
    p^.height:=0;
    p^.depth:= 0;
    p^.weight:= 0;
    p^.left:= nil;
    p^.right:= nil;
    p^.info:= IntToStr(k);
    BalancedDepthWeightHeight(p, 0, 0);
    Result:= p;
  end
  else
  begin
    if k < p^.key then p^.left:= InsertKey(p^.left, k)
    else p^.right:= InsertKey(p^.right, k);
    BalancedDepthWeightHeight(p, 0, 0);
    Result:= p;
  end;
end;

// 16) Функция пересчета глубины, смещения от корня влево-вправо и высотыузлов:
procedure BalancedDepthWeightHeight(v: tree_ptr; d: Integer; w: Integer); // Пересчитываем глубину, высоту и смещение узла
begin
  if v <> nil then
  begin
    v.depth:= d;
    v.weight:= w;
    v.height:= FixHeight(v);
  end;
  if v^.left <> nil then
  begin
    BalancedDepthWeightHeight(v^.left, d+1, w-1);
  end;
  if v^.right <> nil then
  begin
    BalancedDepthWeightHeight(v^.right, d+1, w+1);
  end;
end;

// 17) Вспомогательная функция поиска узла с минимальным ключем в дереве p
function FindMinNode(p: tree_ptr): tree_ptr;
begin
  if p^.left <> nil then Result:= FindMinNode(p^.left)
  else Result:= p;
end;

// 17) Вспомогательная функция поиска узла с минимальным ключем в дереве p
function FindMaxNode(p: tree_ptr): tree_ptr;
begin
  if p^.right <> nil then Result:= FindMaxNode(p^.right)
  else Result:= p;
end;


// -----------------------------------------------------------------------------
// ФУНКЦИИ ДЛЯ РЕАЛИЗАЦИИ ДЕРЕВЬЕВ, УДАЛЕНИЕ ЭЛЕМЕНТА  

// 18) Cлужебная функция для удаления минимального элемента из заданного дерева:
function RemoveMinNode(p: tree_ptr): tree_ptr;
begin
  if (p^.left = nil) then Result:= p^.right
  else
  begin
    p^.left:= RemoveMinNode(p^.left);
    // Result:= BalanceNode(p);
    Result:= p;
  end;
end;

// 18) Cлужебная функция для удаления максимального элемента из заданного дерева:
function RemoveMaxNode(p: tree_ptr): tree_ptr;
begin
  if (p^.right = nil) then Result:= p^.left
  else
  begin
    p^.right:= RemoveMaxNode(p^.right);
    // Result:= BalanceNode(p);
    Result:= p;
  end;
end;

// 19) Функция ПРАВОГО удаления элемента по его ключу:
function RightRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // удаление ключа k из дерева p
var q, r, min: tree_ptr;
begin
  if p = nil then Result:= nil
  else
  begin
    if k < p^.key then p^.left:= RightRemoveKey(p^.left, k)
    else
      if k > p^.key then p^.right:= RightRemoveKey(p^.right, k)
      else  // Нашли ключ, т.е. k = p^.key
        begin
          // Writeln(p^.key); // 11 Для отладки
          q:= p^.left; // Запомнили левое поддерево   // 10
          r:=p^.right; // Запомнили правое поддерево  // 13
          if r = nil then p:= q   // Если правого поддерева нет, просто переносим на место строго узла новый
          else
          begin
            min:= FindMinNode(r); // иначе ищем минимальный элемент в правом поддереве и запоминаем его
            // Writeln(min^.key); // 12 Для отладки
            min^.right:= RemoveMinNode(r); // Перенесли в правое поддерево 12 элемента элемент 13 и всю его цепочку
            // Writeln((min^.right)^.key);  // Для отладки
            min^.left:= q;
            p:= min; // Вот этого не было // p:= min; // Вот этого не было
            Result:= p; //BalanceNode(min);
          end;  
        end;  
  end;
  // И если не пустой указатель, то балансируем узел, или просто возвращаем nil
  if p <> nil then Result:= p //BalanceNode(p)
  else Result:= nil;
end;

// 19) Функция ЛЕВОГО удаления элемента по его ключу:
function LeftRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // удаление ключа k из дерева p
var q, r, max: tree_ptr;
begin
  if p = nil then Result:= nil
  else
  begin
    if k < p^.key then p^.left:= LeftRemoveKey(p^.left, k)
    else
      if k > p^.key then p^.right:= LeftRemoveKey(p^.right, k)
      else  // Нашли ключ, т.е. k = p^.key
        begin
          // Writeln(p^.key); // 11 Для отладки
          q:= p^.left; // Запомнили левое поддерево   // 10
          r:=p^.right; // Запомнили правое поддерево  // 13
          if r = nil then p:= q   // Если правого поддерева нет, просто переносим на место строго узла новый
          else
          begin
            max:= FindMaxNode(r); // иначе ищем минимальный элемент в правом поддереве и запоминаем его
            // Writeln(min^.key); // 12 Для отладки
            max^.right:= RemoveMaxNode(r); // Перенесли в правое поддерево 12 элемента элемент 13 и всю его цепочку
            // Writeln((min^.right)^.key);  // Для отладки
            max^.left:= q;
            p:= max; // Вот этого не было // p:= min; // Вот этого не было
            Result:= p; //BalanceNode(min);
          end;  
        end;  
  end;
  // И если не пустой указатель, то балансируем узел, или просто возвращаем nil
  if p <> nil then Result:= p //BalanceNode(p)
  else Result:= nil;
end;


// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ФУНКЦИИ ДЛЯ СОБСТВЕННО РЕШЕНИЯ ЗАДАЧИ

// 20) Рекурсивная функция подсчета количества наследников у узла
function ParentCount(v: tree_ptr): Integer;
begin
  if v <> nil then
  Result:= 1 + ParentCount(v^.left) + ParentCount(v^.right)
  else Result:= 0;
end;

// 21) Процедура поиска и копирования в массив ключей тех узлов, у которых количество
// потомков в левом поддереве отличается от количества потомков в правом
// поддереве на 1
// Передаем указатель на дерево, ссылку на массив и номер элемента
procedure CopyLR(v: tree_ptr; var arr : Mass);
begin
  if v <> nil then
  begin
    if Abs( ParentCount(v^.left) - ParentCount(v^.right) ) = 1 then
    begin
      i:= i + 1;
      arr[i]:= v^.key; // Скопировать значение ключа
      // Writeln(arr[i]);
    end;
    CopyLR(v^.left, arr);
    CopyLR(v^.right, arr);
  end;
end;

// Функция копирования в массив
function CopyLRtoMassiv(v: tree_ptr): Mass;
var size : Integer;
    arr : Mass;
begin
  if v <> nil then
  begin
    // Определяем количество элементов, чтобы знать, какого размера создать массив:
    size:= CountLR(v);
    SetLength(arr, size);  // Выставляем длину одномерного массива
    i:= -1;
    CopyLR(v, arr); // Выполняем копирование подходящих значений в массив
    Result:= arr;
  end
  else Result:= nil;
end;

// 22) Функция подсчета количества узлов, у которых количество
// потомков в левом поддереве отличается от количества потомков в правом
// поддереве на 1
function CountLR(v: tree_ptr): Integer;
begin
  if v <> nil then
  begin
    if Abs( ParentCount(v^.left) - ParentCount(v^.right) ) = 1 then
    begin
      Result:= 1 + CountLR(v^.left) + CountLR(v^.right);
    end
    else Result:= CountLR(v^.left) + CountLR(v^.right);
  end
  else Result:=0;
end;

// Процедура находжения и удаления (правым удалением) среднюю по значению
// вершину из вершин дерева, у которых количество потомков в левом поддереве
// отличается от количества потомков в правом поддереве на 1
function FindMiddleAndRightRemove(v: tree_ptr): tree_ptr;
var arr: Mass;
    n: Integer; // Количество элементов
    key: Integer; // Найденный ключ средней по значению вершины
begin
  // Определяем количество подходящих элементов:
  n:= CountLR(v);
  //Writeln(n);
  if n = 0 then
    Writeln('Подходящих узлов не найдено. Завершение программы')
  else
  begin
    arr:= CopyLRtoMassiv(v); // Иначе все хорошо, переносим все подходящие элементы в массив
    QuickSortNonRecursive(arr); // Сортируем массив
    PrintArr(arr); // Печатаем все элементы массива
    if (n mod 2) = 0 then
    begin
      Writeln('Подходящих элементов четное количество (', n, ')');
      Writeln('Нет медианы среди найденных узлов. Завершение программы');
    end
    else
    begin
      key:= arr[(n div 2)];
      Writeln('Подходящих элементов нечетное количество (', n, ')');
      Writeln('Средняя по значению вершина: ', key);
      // И удаляем правым удалением ненужную вершину:
      v:= RightRemoveKey(v, key); // удаление ключа k из дерева p
      BalancedDepthWeightHeight(v, 0, 0); // Пересчитываем все глубины и смещения
    end;
  end;
  Result:= v;
end;

// Функция находжения и удаления (левым удалением) средней по значению
// вершины из вершин дерева, у которых количество потомков в левом поддереве
// отличается от количества потомков в правом поддереве на 1
function FindMiddleAndLeftRemove(v: tree_ptr): tree_ptr;
var arr: Mass;
    n: Integer; // Количество элементов
    key: Integer; // Найденный ключ средней по значению вершины
begin
  // Определяем количество подходящих элементов:
  n:= CountLR(v);
  //Writeln(n);
  if n = 0 then
    Writeln('Подходящих узлов не найдено. Завершение программы')
  else
  begin
    arr:= CopyLRtoMassiv(v); // Иначе все хорошо, переносим все подходящие элементы в массив
    QuickSortNonRecursive(arr); // Сортируем массив
    PrintArr(arr); // Печатаем все элементы массива
    if (n mod 2) = 0 then
    begin
      Writeln('Подходящих элементов четное количество (', n, ')');
      Writeln('Нет медианы среди найденных узлов. Завершение программы');
    end
    else
    begin
      key:= arr[(n div 2)];
      Writeln('Подходящих элементов нечетное количество (', n, ')');
      Writeln('Средняя по значению вершина: ', key);
      // И удаляем правым удалением ненужную вершину:
      v:= LeftRemoveKey(v, key); // удаление ключа k из дерева p
      BalancedDepthWeightHeight(v, 0, 0); // Пересчитываем все глубины и смещения
    end;
  end;
  Result:= v;
end;

// Процедура вывода на консоль элементов массива интов
procedure PrintArr(arr: Mass);
var j: Integer;
begin
  write('Подходящие элементы: ');
  for j:= 0 to Length(arr)-1 do
  begin
    write(arr[j], ' ');
  end;
  Writeln;
end;



end.
