unit MySimpleTree; // Модуль реализации простых деревьев

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
     info: string;  // Информационное поле, используется в процедуре вывода на печать структуры дерева
     //element: Real; // Вещественное значение, пока не используется
     left: tree_ptr; // Левый потомок (указатель)
     right: tree_ptr; // Правый потомок (указатель)
  end;

type
  Mass = array of Integer;

// ФУНКЦИИ И ПРОЦЕДУРЫ

// Процедуры обхода дерева (с печатью в строчку):
procedure FrontOrderLeft(v: tree_ptr);  // Процедура прямого левого обхода с выводом ключа на консоль
procedure FrontOrderLeftPosition(v: tree_ptr);  // Процедура прямого левого обхода с выводом ключа и положения на консоль
procedure FrontOrderRight(v: tree_ptr); // Процедура прямого правого обхода с выводом на консоль
procedure BackOrderLeft(v: tree_ptr);   // Процедура обратного левого обхода с выводом на консоль
procedure BackOrderRight(v: tree_ptr);  // Процедура обратного правого обхода с выводом на консоль
procedure InnerOrderLeft(v: tree_ptr);  // Процедура левого внутреннего обхода с выводом на консоль
procedure InnerOrderRight(v: tree_ptr); // Процедура правого внутреннего обхода с выводом на консоль

// Процедуры пространственной печати и вспомогательные для них процедуры
procedure PrintTree(t: tree_ptr; h: Integer); // Простая АЛЬТЕРНАТИВНАЯ процедура печати дерева с h отступами
procedure CreateFullTree(p: tree_ptr; h: Integer); // Процедура создания полного (сбалансированного)  дерева
procedure CopyFullTree(sourse: tree_ptr; receiver: tree_ptr); // Процедура копирования ключей из неполного в полное (сбалансированное) дерево
procedure PrintLeftTree(v: tree_ptr); // ОСНОВНАЯ процедура полной пространственной печати дерева
procedure PrintLevel(v: tree_ptr; level: Integer; h: Integer); // Вспомогательная процедура пространственной печати узлов заданного уровня

// Процедуры и функции для вставки, поиска и удаления ключа и вспомогательные для них процедуры и функции
function HeightNode(t: tree_ptr): Integer;    // Вспомогательная функция возврата высоты узла
function FixHeight(v: tree_ptr): Integer; // Вспомогательная функция определения высоты вершины
function InsertKey(p: tree_ptr; k: Integer): tree_ptr; // ОСНОВНАЯ Функция вставки ключа k в дерево с корнем p
procedure BalancedDepthWeightHeight(v: tree_ptr; d: Integer; w: Integer); // Вспомогательная функция перерасчета высоты-ширины-глубины всех узлов дерева (при добавлении / удалении узла)
function FindMinNode(p: tree_ptr): tree_ptr;  // Вспомогательная функция поиска узла с минимальным ключем в дереве p
function FindMaxNode(p: tree_ptr): tree_ptr;  // Вспомогательная функция поиска узла с максимаьным ключем в дереве p
function RemoveMinNode(p: tree_ptr): tree_ptr; // Cлужебная функция для удаления минимального элемента из заданного дерева:
function RemoveMaxNode(p: tree_ptr): tree_ptr; // Cлужебная функция для удаления максимального элемента из заданного дерева:
function RightRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // ОСНОВНАЯ Функция ПРАВОГО удаления элемента по его ключу
function LeftRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // ОСНОВНАЯ Функция ЛЕВОГО удаления элемента по его ключу
//
function ParentCount(v: tree_ptr): Integer;  // Вспомогательная функция подсчета количества потомков узла
procedure CopyLR(v: tree_ptr; var arr : Mass); // Вспомогательная процедура поиска и копирования в массив ключей
function CopyLRtoMassiv(v: tree_ptr): Mass; // ОСНОВНАЯ функция поиска и копирования в массив ключей
function CountLR(v: tree_ptr): Integer;
//
function FindMiddleAndRightRemove(v: tree_ptr): tree_ptr; // Функция поиска и ПРАВОГО удаления средней по значению вершины среди тех, у который количество потомков справа и слева отличаются на 1
function FindMiddleAndLeftRemove(v: tree_ptr): tree_ptr; // Функция поиска и ЛЕВОГО удаления средней по значению вершины среди тех, у который количество потомков справа и слева отличаются на 1
//
procedure PrintArr(arr: Mass); // Процедура печати в консоль элементов массива в строчку с пробелами между элементами
//

function SumKey(v: tree_ptr): Integer; // Вспомогательная Функция вычисления суммы конечных элементов пути максимальной длины
function SumKey_MaxLenWay(v: tree_ptr): Integer; // Основная Функция вычисления суммы конечных элементов пути максимальной длины

//


function MaxLenWay(v: tree_ptr): Integer; // Функция определения максимальной длины пути, проходящего через заданный узел
function FindNodeBetween_MaxLenWay(v: tree_ptr): tree_ptr; // Основная функция поиска узла, через который проходит путь максимальной длины
procedure FindNode_MaxLenWay(v: tree_ptr); // Вспомогательная процедура обхода дерева и поиска узла, через который проходит путь максимальной длины


procedure PrintWayLeft(v: tree_ptr);  // Вспомогательная процедура (по одной ветви) ПЕЧАТИ узлов пути максимальной длины, проходящей через заданный узел
procedure PrintWayRight(v: tree_ptr); // Вспомогательная процедура (по правой ветви) ПЕЧАТИ узлов пути максимальной длины, проходящей через заданный узел
procedure PrintMaxLenWay(v: tree_ptr); // Основная процедура(по обеим ветвям) ПЕЧАТИ узлов пути максимальной длины, проходящей через заданный узел


// 36) ОСНОВНАЯ Процедура, делающая заданную вершину корневой для дерева и перестраивающая дерево
procedure RebuildTree(rootOld: tree_ptr; rootNew: tree_ptr); 

// 37) ВСПОМОГАТЕЛЬНАЯ процедура РАЗДЕЛЕНИЯ дерева на две части:
procedure TreeToPartition(rootOld: tree_ptr; rootNew: tree_ptr);

// 38) ВСПОМОГАТЕЛЬНАЯ Процедура, делающая заданную вершину корневой для дерева и перестраивающая дерево
procedure Rebuild(v: tree_ptr; rootNew: tree_ptr);

// 50) // Функция определения являются ли концы пути узлами одного уровня
function OneLevel(v: tree_ptr): Integer;

var i: Integer;
    massiv: array of Integer;

    tmpN: tree_ptr;  // Узел для хранения узла, через который проходит путь максимально длины
    tmpL: Integer; // Переменная для хранения длиня максимального пути
    tmpS: Integer; // Переменная для хранения минимальной суммы конечных элементов


implementation // ---- Раздел реализаций ---

// Процедуры обхода дерева (с печатью в одну строчку):
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
// Процедуры пространственной печати и вспомогательные для них процедуры

// 7) Простая АЛЬТЕРНАТИВНАЯ процедура печати дерева с h отступами (реализация по ВИРТУ)
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

// 8) Процедура создания полного (сбалансированного) дерева
// В качестве параметров выступают указатель на корень будущего дерева и требуемая высота дерева
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
    q^.info:= ' ';

    p^.left:= q;

    New(r);
    r^.key:= 0;
    r^.height:=0;
    r^.depth:= 0;
    r^.weight:= 0;
    r^.left:= nil;
    r^.right:= nil;
    r^.info:= ' ';

    p^.right:= r;

    CreateFullTree(p^.left, h-1);
    CreateFullTree(p^.right, h-1);
  end;
end;

// 9) Процедура копирования ключей из неполного в полное (сбалансированное) дерево
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


// 10) ОСНОВНАЯ процедура полной пространственной печати дерева
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
  // Бежим по уровням сверху вниз, от корня к листьям
  for lv:= 0 to h do
  begin
    // Формируем требуемый отступ слева (в соотвествии с текущим уровнем lv и высотой дерева h):
    t:= 1;
    while t < ( Power( 2, (h - lv) ) )+5 do          // +5 - это отступ слева
    begin
      write(' ');
      t:= t + 1;
    end;
    // Затем вызываем печать требуемого уровня
    PrintLevel(fullTree, lv, h);
    // Вытягиваем вниз
    Writeln;  Writeln; Writeln;
  end;
end;

// 11) Вспомогательная процедура пространственной печати узлов заданного уровня
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



// -----------------------------------------------------------------------------
// Процедуры и функции для вставки, поиска и удаления ключа и вспомогательные для них процедуры и функции

// 12) Вспомогательная функция возврата высоты узла
function HeightNode(t: tree_ptr): Integer;
begin
  if t <> nil then
  HeightNode:= t^.height
  else HeightNode:= 0;
end;

// 13) Вспомогательная функция определения и установки высоты вершины
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

// 14) ОСНОВНАЯ Функция вставки ключа k в дерево с корнем p
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

// 15) Вспомогательная функция перерасчета высоты-ширины-глубины всех узлов дерева (при добавлении / удалении узла)
procedure BalancedDepthWeightHeight(v: tree_ptr; d: Integer; w: Integer);
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

// 16) Вспомогательная функция поиска узла с минимальным ключем в дереве p
function FindMinNode(p: tree_ptr): tree_ptr;
begin
  if p^.left <> nil then Result:= FindMinNode(p^.left)
  else Result:= p;
end;

// 17) Вспомогательная функция поиска узла с максимальным ключем в дереве p
function FindMaxNode(p: tree_ptr): tree_ptr;
begin
  if p^.right <> nil then Result:= FindMaxNode(p^.right)
  else Result:= p;
end;

// 18) Cлужебная функция для удаления минимального элемента из заданного дерева
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

// 19) Cлужебная функция для удаления максимального элемента из заданного дерева
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

// 20) ОСНОВНАЯ Функция ПРАВОГО удаления элемента по его ключу
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
            p:= min;
            Result:= p;
          end;  
        end;  
  end;
  // И если не пустой указатель, то возвращаем узел, или просто возвращаем nil
  if p <> nil then Result:= p
  else Result:= nil;
end;

// 21) ОСНОВНАЯ Функция ЛЕВОГО удаления элемента по его ключу
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
            p:= max; // Вот этого не было // p:= min;
            Result:= p;
          end;  
        end;  
  end;
  // И если не пустой указатель, то возвращаем узел, или просто возвращаем nil
  if p <> nil then Result:= p //BalanceNode(p)
  else Result:= nil;
end;


// -----------------------------------------------------------------------------
// ФУНКЦИИ ДЛЯ РЕШЕНИЯ ЗАДАЧИ

// 22) Рекурсивная вспомогательная функция подсчета количества потомков узла
function ParentCount(v: tree_ptr): Integer;
begin
  if v <> nil then
  Result:= 1 + ParentCount(v^.left) + ParentCount(v^.right)
  else Result:= 0;
end;

// 23) Вспомогательная процедура поиска и копирования в массив ключей, у которых
// количество потомков в левом поддереве отличается от количества потомков в правом
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

// 24) ОСНОВНАЯ функция поиска и копирования в массив ключей
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

// 25) Функция подсчета количества узлов, у которых количество
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

// 26) Функция поиска и ПРАВОГО удаления средней по значению вершины среди тех,
// у который количество потомков справа и слева отличаются на 1
function FindMiddleAndRightRemove(v: tree_ptr): tree_ptr;
var arr: Mass;
    n: Integer; // Количество элементов
    key: Integer; // Найденный ключ средней по значению вершины
begin
  // Определяем количество подходящих элементов:
  n:= CountLR(v);
  //Writeln(n);
  if n = 0 then
    Writeln('   Подходящие узлы не найдены')
  else
  begin
    arr:= CopyLRtoMassiv(v); // Иначе все хорошо, переносим все подходящие элементы в массив
    QuickSortNonRecursive(arr); // Сортируем массив
    PrintArr(arr); // Печатаем все элементы массива
    if (n mod 2) = 0 then
    begin
      Writeln('   Подходящих элементов ', n, ', четное количество ');
      Writeln('   Нет медианы среди найденных узлов. Удалять нечего');
    end
    else
    begin
      key:= arr[(n div 2)];
      Writeln('   Подходящих элементов ', n, ', нечетное количество ');
      Writeln('   Средняя по значению вершина: ', key, '. Ее и удаляем');
      // И удаляем правым удалением ненужную вершину:
      v:= RightRemoveKey(v, key); // удаление ключа k из дерева p
      BalancedDepthWeightHeight(v, 0, 0); // Пересчитываем все глубины и смещения
    end;
  end;
  Result:= v;
end;

// 27) Функция поиска и ЛЕВОГО удаления средней по значению вершины среди тех,
// у который количество потомков справа и слева отличаются на 1
function FindMiddleAndLeftRemove(v: tree_ptr): tree_ptr;
var arr: Mass;
    n: Integer; // Количество элементов
    key: Integer; // Найденный ключ средней по значению вершины
begin
  // Определяем количество подходящих элементов:
  n:= CountLR(v);
  //Writeln(n);
  if n = 0 then
    Writeln('   Подходящие узлы не найдены')
  else
  begin
    arr:= CopyLRtoMassiv(v); // Иначе все хорошо, переносим все подходящие элементы в массив
    QuickSortNonRecursive(arr); // Сортируем массив
    PrintArr(arr); // Печатаем все элементы массива
    if (n mod 2) = 0 then
    begin
      Writeln('   Подходящих элементов ', n, ', четное количество ');
      Writeln('   Нет медианы среди найденных узлов. Удалять нечего');
    end
    else
    begin
      key:= arr[(n div 2)];
      Writeln('   Подходящих элементов ', n, ', нечетное количество ');
      Writeln('   Средняя по значению вершина: ', key, '. Ее и удаляем');
      // И удаляем правым удалением ненужную вершину:
      v:= LeftRemoveKey(v, key); // удаление ключа k из дерева p
      BalancedDepthWeightHeight(v, 0, 0); // Пересчитываем все глубины и смещения
    end;
  end;
  Result:= v;
end;

// 28) Процедура печати в консоль элементов массива в строчку с пробелами
// между элементами
procedure PrintArr(arr: Mass);
var j: Integer;
begin
  write('   Подходящие элементы: ');
  for j:= 0 to Length(arr)-1 do
  begin
    write(arr[j], ' ');
  end;
  Writeln;
end;

// 2016-11-07

// 29) Вспомогательная Функция (по одной ветви) вычисления суммы конечных элементов пути максимальной длины, проходящей через заданный узел
function SumKey(v: tree_ptr): Integer;
begin
  if ((v^.left = NIL) and (v^.right = NIL)) then   // Если дошли до листа, то
  Result:= v^.key // То возвращаем ключ этого листа
  else  // Иначе есть еще пути вниз, как минимум один, а то и все два
  begin
    if ((v^.left <> NIL) and (v^.right = NIL)) then    // Если есть только левый путь, то
    Result:= SumKey(v^.left);    // идем влево
    if ((v^.left = NIL) and (v^.right <> NIL)) then    // Если есть только правый путь, то
    Result:= SumKey(v^.right);    // идем вправо
    if ((v^.left <> NIL) and (v^.right <> NIL)) then    // Если же есть оба пути, то
    begin // Решаем, по какому пути пойдем, а пойдем мы по самому длинному
      // Проверяем, какая ветвь длиннее, по той и идем: // Если высота левой больше или равна, то по ней и идем
      if v^.left^.height >= v^.right^.height then Result:= SumKey(v^.left)
      else SumKey(v^.left);
    end;
  end;
end;  


// 30) Основная Функция (по обеим ветвям) вычисления суммы конечных элементов пути максимальной длины, проходящей через заданный узел
function SumKey_MaxLenWay(v: tree_ptr): Integer;
var sum: Integer;
begin
  sum:=0;
  if v <> nil then
  begin
    if v^.left <> nil then sum:= sum + SumKey(v^.left) else sum:= sum + v^.key;
    if v^.right <> nil then sum:= sum + SumKey(v^.right) else sum:= sum + v^.key;
  end; 
  Result:= sum;
end;

// 31) Функция определения максимальной длины пути, проходящего через заданный узел
function MaxLenWay(v: tree_ptr): Integer;
var len: Integer;
begin
  len:= 0;
  if v <> NIL then  // Если не ниловый узел, то
  begin
    if v^.left <> NIL then len:= len + 1 + v^.left^.height;  // увеличиваем на длину по левому плечу (+1 - т.к. еще путь до текущего)
    if v^.right <> NIL then len:= len + 1 + v^.right^.height; // увеличиваем на длину по правому плечу
  end;
  Result:= len;
end;

// 50) // Функция определения являются ли концы пути узлами одного уровня
function OneLevel(v: tree_ptr): Integer;
var len1, len2: Integer;
begin
  len1:= 0;
  len2:= 0;
  if v <> NIL then  // Если не ниловый узел, то
  begin
    if v^.left <> NIL then len1:= len1 + 1 + v^.left^.height;  // увеличиваем на длину по левому плечу (+1 - т.к. еще путь до текущего)
    if v^.right <> NIL then len2:= len2 + 1 + v^.right^.height; // увеличиваем на длину по правому плечу
  end;
  if len1 <> len2 then Result:= MaxLenWay(v)
  else Result:=   -100;
end;

// 32) Основная функция поиска узла, через который проходит путь максимальной длины
function FindNodeBetween_MaxLenWay(v: tree_ptr): tree_ptr;
begin
  tmpN:= NIL;   // Запоминаем в глобальной переменной указатель на NIL
  tmpL:= 0; // Считаем длину максимального пути равной 0
  tmpS:= 10000; // Запоминаем в глобальной переменной сумму конечных ключей, пусть она будет очень большой
  FindNode_MaxLenWay(v);  // И запускаем поиск узла с лучшими параметрами
  Result:= tmpN;
end;

// 33) Вспомогательная процедура обхода дерева и поиска узла, через который проходит путь максимальной длины
procedure FindNode_MaxLenWay(v: tree_ptr);
var len: Integer;
begin
  if v <> nil then
  begin
    len:= OneLevel(v); //  Определяем длину максимального пути через текущую вершину

    //Writeln(len);
    if len > tmpL  then  // Если она больше уже известной, то
    begin
      tmpN:= v;
      tmpL:= len;
      tmpS:= SumKey_MaxLenWay(v);
    end;
    if len = tmpL then // если же она равна уже известной, то нужно проверить, у которой сумма конечных меньше
    begin
      if SumKey_MaxLenWay(v) < tmpS then     // И если у новой сумма конечных меньше, она и становится временной
      begin
        tmpN:= v;
        tmpL:= len;
        tmpS:= SumKey_MaxLenWay(v);
      end;
    end;
    FindNode_MaxLenWay(v^.left); // Идем вниз влево
    FindNode_MaxLenWay(v^.right); // Идем вниз вправо
  end;
end;


// 33) Вспомогательная процедура (по левой ветви) ПЕЧАТИ узлов пути максимальной длины, проходящей через заданный узел
procedure PrintWayLeft(v: tree_ptr);
begin
  if ((v^.left = NIL) and (v^.right = NIL)) then   // Если дошли до листа, то
  write(v^.key, ' ') // То печатаем ключ этого листа
  else  // Иначе есть еще пути вниз, как минимум один, а то и все два
  begin
    if ((v^.left <> NIL) and (v^.right = NIL)) then    // Если есть только левый путь, то
      PrintWayLeft(v^.left);    // идем влево

    if ((v^.left = NIL) and (v^.right <> NIL)) then    // Если есть только правый путь, то
      PrintWayLeft(v^.right);    // идем вправо

    if ((v^.left <> NIL) and (v^.right <> NIL)) then    // Если же есть оба пути, то
    begin // Решаем, по какому пути пойдем, а пойдем мы по самому длинному
      // Проверяем, какая ветвь длиннее, по той и идем: // Если высота левой больше или равна, то по ней и идем
      if v^.left^.height >= v^.right^.height then PrintWayLeft(v^.left)    // идем влево
      else PrintWayLeft(v^.right);    // идем вправо
    end;
    write(v^.key, ' '); // и печатаем ключ этого листа
  end;
end;

// 34) Вспомогательная процедура (по правой ветви) ПЕЧАТИ узлов пути максимальной длины, проходящей через заданный узел
procedure PrintWayRight(v: tree_ptr);
begin
  if ((v^.left = NIL) and (v^.right = NIL)) then   // Если дошли до листа, то
  write(v^.key, ' ') // То печатаем ключ этого листа
  else  // Иначе есть еще пути вниз, как минимум один, а то и все два
  begin
    write(v^.key, ' '); // и печатаем ключ этого листа
    if ((v^.left <> NIL) and (v^.right = NIL)) then    // Если есть только левый путь, то
      PrintWayRight(v^.left);    // идем влево

    if ((v^.left = NIL) and (v^.right <> NIL)) then    // Если есть только правый путь, то
      PrintWayRight(v^.right);    // идем вправо

    if ((v^.left <> NIL) and (v^.right <> NIL)) then    // Если же есть оба пути, то
    begin // Решаем, по какому пути пойдем, а пойдем мы по самому длинному
      // Проверяем, какая ветвь длиннее, по той и идем: // Если высота левой больше или равна, то по ней и идем
      if v^.left^.height >= v^.right^.height then PrintWayRight(v^.left)    // идем влево
      else PrintWayRight(v^.right);    // идем вправо
    end;
  end;
end;


// 35) Основная процедура(по обеим ветвям) ПЕЧАТИ узлов пути максимальной длины, проходящей через заданный узел
procedure PrintMaxLenWay(v: tree_ptr);
begin
  if v <> nil then
  begin
    if v^.left <> nil then PrintWayLeft(v^.left);
    write (v^.key, ' ');
    if v^.right <> nil then PrintWayRight(v^.right);
  end; 
  Writeln;
end;

// 36) ОСНОВНАЯ Процедура, делающая заданную вершину корневой для дерева и перестраивающая дерево
procedure RebuildTree(rootOld: tree_ptr; rootNew: tree_ptr); // Передаем указатель на старую вершину и указатель на узел, который хотим сделать вершиной
begin
  // Сначала нужно разорвать на два дерева:
  TreeToPartition(rootOld, rootNew);
  BalancedDepthWeightHeight(rootOld, 0, 0); // Пересчитываем все глубины и смещения для оставшегося куска строго дерева
  BalancedDepthWeightHeight(rootNew, 0, 0); // Пересчитываем все глубины и смещения для нового дерева
  // А затем переписать из оставшегося куска старого дерева в новое дерево все оставшиеся узлы
  Rebuild(rootOld, rootNew);
end;

// 37) ВСПОМОГАТЕЛЬНАЯ процедура РАЗДЕЛЕНИЯ дерева на две части:
procedure TreeToPartition(rootOld: tree_ptr; rootNew: tree_ptr);
begin
  if rootOld <> nil then
  begin
    // rootOld не может быть листом, иначе нам нечего разделять
    if (rootOld^.left <> nil) then // Если есть левый потомок, то     // and (rootOld^.right = nil) then   // Если является, то
    begin
      // Проверяем на совпадение
      if rootOld^.left^.key = rootNew^.key then rootOld^.left:= nil    // Если ключи совпали, можем у текущей вершины rootOld оборвать связь:
      else  // иначе продолжаем движение
        begin
          TreeToPartition(rootOld^.left, rootNew);
        end;
    end;
    if (rootOld^.right <> nil) then // Если есть правый потомок, то
    begin
      // Проверяем на совпадение
      if rootOld^.right^.key = rootNew^.key then rootOld^.right:= nil    // Если ключи совпали, можем у текущей вершины rootOld оборвать связь:
      else  // иначе продолжаем движение
        begin
          TreeToPartition(rootOld^.right, rootNew);
        end;
    end;
  end;
end;

// 38) ВСПОМОГАТЕЛЬНАЯ Процедура, делающая заданную вершину корневой для дерева и перестраивающая дерево
procedure Rebuild(v: tree_ptr; rootNew: tree_ptr);
begin
  if v <> nil then
  begin
    if v^.key <> rootNew^.key then    // Если ключи не совпали, можем текущую вершину добавить в новое дерево:
    begin
      rootNew:= InsertKey(rootNew, v^.key);
      // и топать вниз по уровням дальше:
      Rebuild(v^.left, rootNew);
      Rebuild(v^.right, rootNew);
    end;
  end;
end;



// Окончание модуля.

end.
