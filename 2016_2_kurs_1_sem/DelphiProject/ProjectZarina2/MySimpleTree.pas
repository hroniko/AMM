unit MySimpleTree; // Модуль реализации простых деревьев

interface // ---- Раздел описаний ---

uses SysUtils, Math;

// Описание типа - структура бинарного дерева на указателях:
// Представление в виде списковой структуры:
type
  tree_ptr = ^ tree_node;
  tree_node = record
     key: Integer;    // Ключ узла
     height: Integer; // Высота узла (расстояние в дугах от узла до наиболее удаленного потомка)
     left: tree_ptr; // Левый потомок (указатель)
     right: tree_ptr; // Правый потомок (указатель)
  end;


// ФУНКЦИИ И ПРОЦЕДУРЫ
procedure FrontOrderLeft(v: tree_ptr);  // Процедура прямого левого обхода с выводом ключа на консоль
function HeightNode(t: tree_ptr): Integer;    // Вспомогательная функция возврата высоты узла
function FixHeight(v: tree_ptr): Integer; // Вспомогательная функция определения высоты вершины
function InsertKey(p: tree_ptr; k: Integer): tree_ptr; // ОСНОВНАЯ Функция вставки ключа k в дерево с корнем p
procedure BalancedDepthWeightHeight(v: tree_ptr; d: Integer; w: Integer); // Вспомогательная функция перерасчета высоты-ширины-глубины всех узлов дерева (при добавлении / удалении узла)
function FindMinNode(p: tree_ptr): tree_ptr;  // Вспомогательная функция поиска узла с минимальным ключем в дереве p
function RemoveMinNode(p: tree_ptr): tree_ptr; // Cлужебная функция для удаления минимального элемента из заданного дерева:
function RemoveMaxNode(p: tree_ptr): tree_ptr; // Cлужебная функция для удаления максимального элемента из заданного дерева:
function RightRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // ОСНОВНАЯ Функция ПРАВОГО удаления элемента по его ключу
function MinLenWay(v: tree_ptr): Integer; // ОСНОВНАЯ Функция определения МИНИМАЛЬНОЙ длины пути, проходящего через заданный узел
function MinLenWayOne(v: tree_ptr): Integer; // ВСПОМОГАТЕЛЬНАЯ Функция определения МИНИМАЛЬНОЙ длины пути, проходящего через заданный узел
function SumAllKey(v: tree_ptr): Integer; // Вспомогательная Функция (по одной ветви) вычисления суммы ВСЕХ элементов пути МИНИМАЛЬНОЙ длины, проходящей через заданный узел
function FindNodeBetween_MinLenWay(v: tree_ptr): tree_ptr; // Основная функция поиска узла, через который проходит путь МИНИМАЛЬНОЙ длины
procedure FindNode_MinLenWay(v: tree_ptr);  // Вспомогательная процедура обхода дерева и поиска узла, через который проходит путь МИНИМАЛЬНОЙ длины




var
    tmpN: tree_ptr;  // Узел для хранения узла
    tmpL: Integer; // Переменная для хранения длины пути
    tmpS: Integer; // Переменная для хранения минимальной суммы конечных элементов


implementation // ---- Раздел реализаций ---

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

// -----------------------------------------------------------------------------
// Процедуры и функции для вставки, поиска и удаления ключа и вспомогательные для них процедуры и функции

// 2) Вспомогательная функция возврата высоты узла
function HeightNode(t: tree_ptr): Integer;
begin
  if t <> nil then
  HeightNode:= t^.height
  else HeightNode:= 0;
end;

// 3) Вспомогательная функция определения и установки высоты вершины
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

// 4) ОСНОВНАЯ Функция вставки ключа k в дерево с корнем p
function InsertKey(p: tree_ptr; k: Integer): tree_ptr;
begin
  if p = nil then
  begin
    New(p);
    p^.key:= k;
    p^.height:=0;
    p^.left:= nil;
    p^.right:= nil;
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

// 5) Вспомогательная функция перерасчета высоты-ширины-глубины всех узлов дерева (при добавлении / удалении узла)
procedure BalancedDepthWeightHeight(v: tree_ptr; d: Integer; w: Integer);
begin
  if v <> nil then
  begin
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

// 6) Вспомогательная функция поиска узла с минимальным ключем в дереве p
function FindMinNode(p: tree_ptr): tree_ptr;
begin
  if p^.left <> nil then Result:= FindMinNode(p^.left)
  else Result:= p;
end;    

// 7) Cлужебная функция для удаления минимального элемента из заданного дерева
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

// 8) Cлужебная функция для удаления максимального элемента из заданного дерева
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

// 9) ОСНОВНАЯ Функция ПРАВОГО удаления элемента по его ключу
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

// -----------------------------------------------------------------------------
// ФУНКЦИИ ДЛЯ РЕШЕНИЯ ЗАДАЧИ

// 10) Рекурсивная вспомогательная функция подсчета количества потомков узла
function ParentCount(v: tree_ptr): Integer;
begin
  if v <> nil then
  Result:= 1 + ParentCount(v^.left) + ParentCount(v^.right)
  else Result:= 0;
end;

// 11) Вспомогательная Функция (по одной ветви) вычисления суммы конечных элементов пути максимальной длины, проходящей через заданный узел
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

// 12) Основная Функция (по обеим ветвям) вычисления суммы конечных элементов пути максимальной длины, проходящей через заданный узел
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

// 13) ОСНОВНАЯ Функция определения МИНИМАЛЬНОЙ длины пути, проходящего через заданный узел
function MinLenWay(v: tree_ptr): Integer;
var len: Integer;
begin
  len:= 0;
  if v <> NIL then  // Если не ниловый узел, то
  begin
    if v^.left <> NIL then len:= len + 1 + MinLenWayOne(v^.left);  // увеличиваем на длину по левому плечу (+1 - т.к. еще путь до текущего)
    if v^.right <> NIL then len:= len + 1 + MinLenWayOne(v^.right); // увеличиваем на длину по правому плечу
  end;
  Result:= len;
end;

// 14) ВСПОМОГАТЕЛЬНАЯ Функция определения МИНИМАЛЬНОЙ длины пути, проходящего через заданный узел
function MinLenWayOne(v: tree_ptr): Integer;
var len: Integer;
begin
  len:= 0;
  if v <> NIL then  // Если не ниловый узел, то
  begin
    if (v^.left <> NIL) and (v^.right <> NIL) then
    begin
      // И идем в ту ветвь, которая короче:
      if v^.left.height < v^.right^.height then len:= len + 1 + MinLenWayOne(v^.left)  // увеличиваем на длину по левому плечу (+1 - т.к. еще путь до текущего)
      else len:= len + 1 + MinLenWayOne(v^.right); // увеличиваем на длину по правому плечу
    end;
    if (v^.left <> NIL) and (v^.right = NIL) then len:= len + 1 + MinLenWayOne(v^.left);
    if (v^.left = NIL) and (v^.right <> NIL) then len:= len + 1 + MinLenWayOne(v^.right);
  end;
  Result:= len;
end;

// 15) Основная Функция (по обеим ветвям) вычисления суммы ВСЕХ элементов пути минимальной длины, проходящей через заданный узел
function SumAllKey_MinLenWay(v: tree_ptr): Integer;
var sum: Integer;
begin
  sum:=0;
  if v <> nil then sum:= v^.key + SumAllKey(v^.left) + SumAllKey(v^.right);
  Result:= sum;
end;

// 16) Вспомогательная Функция (по одной ветви) вычисления суммы ВСЕХ элементов пути МИНИМАЛЬНОЙ длины, проходящей через заданный узел
function SumAllKey(v: tree_ptr): Integer;
var sum: Integer;
begin
  sum:= 0;
  if v <> NIL then  // Если не ниловый узел, то
  begin
    if (v^.left <> NIL) and (v^.right <> NIL) then
    begin
      // И идем в ту ветвь, которая короче, или, если равны, то в левую - там ключ меньше!:
      if v^.left.height <= v^.right^.height then sum:= sum + SumAllKey(v^.left)
      else sum:= sum + SumAllKey(v^.right);
    end;
    if (v^.left <> NIL) and (v^.right = NIL) then sum:= sum + SumAllKey(v^.left);
    if (v^.left = NIL) and (v^.right <> NIL) then sum:= sum + SumAllKey(v^.right);
  end;
  Result:= sum;
end;

// 17) Основная функция поиска узла, через который проходит путь МИНИМАЛЬНОЙ длины
function FindNodeBetween_MinLenWay(v: tree_ptr): tree_ptr;
begin
  tmpN:= v;   // Запоминаем в глобальной переменной указатель на NIL
  tmpL:= 10000; // Считаем длину максимального пути равной 0
  tmpS:= 10000; // Запоминаем в глобальной переменной сумму ВСЕХ ключей, пусть она будет очень  большой
  FindNode_MinLenWay(v);  // И запускаем поиск узла с лучшими параметрами
  Result:= tmpN;
end;

// 18) Вспомогательная процедура обхода дерева и поиска узла, через который проходит путь МИНИМАЛЬНОЙ длины
procedure FindNode_MinLenWay(v: tree_ptr);
var len: Integer;
begin
  len:= MinLenWay(v);
  if (v <> nil) and (len > 1)then
  begin
    //len:= MinLenWay(v); // Определяем длину МИНИМАЛЬНОГО пути через текущую вершину


      if len < tmpL then  // Если она меньше уже известной, то
      begin
        tmpN:= v;
        tmpL:= len;
        tmpS:= SumAllKey_MinLenWay(v);
      end;
      if len = tmpL then // если же она равна уже известной, то нужно проверить, у которой сумма ВСЕХ ключей меньше
      begin
        if SumAllKey_MinLenWay(v) < tmpS then     // И если у новой сумма ВСЕХ меньше, она и становится временной
        begin
          tmpN:= v;
          tmpL:= len;
          tmpS:= SumAllKey_MinLenWay(v);
        end;
      end;
      FindNode_MinLenWay(v^.left); // Идем вниз влево
      FindNode_MinLenWay(v^.right); // Идем вниз вправо
  end;
end;



end.
