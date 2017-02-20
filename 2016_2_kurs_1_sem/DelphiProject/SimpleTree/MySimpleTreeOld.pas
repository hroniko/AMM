unit MySimpleTreeOld; // ������ ���������� ������� ��������

interface // ---- ������ �������� ---

uses SysUtils, Math,
    MySimpleSort;  // ���������� ������ � ����������� ����������
    
// �������� ���� - ��������� ��������� ������ �� ����������:
// ������������� � ���� ��������� ���������:
type
  tree_ptr = ^ tree_node;
  tree_node = record
     key: Integer;    // ���� ����
     height: Integer; // ������ ���� (���������� � ����� �� ���� �� �������� ���������� �������)
     depth: Integer; // ������� ���� (���������� � ����� �� ����� �� ����)
     weight: Integer; // �������� �����-������ ������������ ��������� �������� (�� �����������)
     info: string;  // �������������� ����, ���� �� ������������
     //element: Real; // ������������ ��������, ���� �� ������������
     left: tree_ptr; // ����� ������� (���������)
     right: tree_ptr; // ������ ������� (���������)
  end;

type
  Mass = array of Integer;

procedure FrontOrderLeft(v: tree_ptr);  // 1) ��������� ������� ������ ������ � ������� ����� �� �������
procedure FrontOrderLeftPosition(v: tree_ptr);  // 1-1) ��������� ������� ������ ������ � ������� ����� � ��������� �� �������
procedure FrontOrderRight(v: tree_ptr); // 2) ��������� ������� ������� ������ � ������� �� �������
procedure BackOrderLeft(v: tree_ptr);   // 3) ��������� ��������� ������ ������ � ������� �� �������
procedure BackOrderRight(v: tree_ptr);  // 4) ��������� ��������� ������� ������ � ������� �� �������
procedure InnerOrderLeft(v: tree_ptr);  // 5) ��������� ������ ����������� ������ � ������� �� �������
procedure InnerOrderRight(v: tree_ptr); // 6) ��������� ������� ����������� ������ � ������� �� �������

//
procedure PrintTree(t: tree_ptr; h: Integer); // 9) ��������� ������ ������ � h ���������


procedure CreateFullTree(p: tree_ptr; h: Integer);
procedure CopyFullTree(sourse: tree_ptr; receiver: tree_ptr);

procedure PrintLeftTree(v: tree_ptr);

procedure PrintLevel(v: tree_ptr; level: Integer; h: Integer);
procedure PrintLine(v: tree_ptr; level: Integer; h: Integer);


function HeightNode(t: tree_ptr): Integer;    // 10) ������� �������� ������ ����
function FixHeight(v: tree_ptr): Integer; // 11) ������� ����������� ������ �������


// 16) ������� ������� ����� k � ������ � ������ p:
function InsertKey(p: tree_ptr; k: Integer): tree_ptr;
procedure BalancedDepthWeightHeight(v: tree_ptr; d: Integer; w: Integer);
//
// 17) ��������������� ������� ������ ���� � ����������� ������ � ������ p
function FindMinNode(p: tree_ptr): tree_ptr;
// 17) ��������������� ������� ������ ���� � ����������� ������ � ������ p
function FindMaxNode(p: tree_ptr): tree_ptr;
//
function RemoveMinNode(p: tree_ptr): tree_ptr; // 18) C�������� ������� ��� �������� ������������ �������� �� ��������� ������:
function RemoveMaxNode(p: tree_ptr): tree_ptr; // 18) C�������� ������� ��� �������� ������������� �������� �� ��������� ������:
//
function RightRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // ������� ������� �������� �������� �� ��� �����
function LeftRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // ������� ������ �������� �������� �� ��� �����

//

function ParentCount(v: tree_ptr): Integer;
procedure CopyLR(v: tree_ptr; var arr : Mass);
function CopyLRtoMassiv(v: tree_ptr): Mass;
function CountLR(v: tree_ptr): Integer;

//

function FindMiddleAndRightRemove(v: tree_ptr): tree_ptr; // ������� ������ � ������� �������� ������� �� �������� ������� ����� ���, � ������� ���������� �������� ������ � ����� ���������� �� 1
function FindMiddleAndLeftRemove(v: tree_ptr): tree_ptr; // ������� ������ � ������ �������� ������� �� �������� ������� ����� ���, � ������� ���������� �������� ������ � ����� ���������� �� 1

//

procedure PrintArr(arr: Mass);

var i: Integer;
    massiv: array of Integer;
    masPlot: array of Char;
    msv: array of array of String;  // ������������ ��������� ������ �� �����
    

implementation // ---- ������ ���������� ---


// -----------------------------------------------------------------------------
// ������ �����
// ������ ������� ������ (FrontOrder, DirectOrder, TopDownOrder, ������ ����)
// ����������� � ���, ��� ������ ���������� ������ ���������� ������,
// ��� ��� ����������. ���� ����� ����� ���������� ��� ����� (������)
// ���������, �� ����� ���������� ������ ����� (������) �������.

// 1) ��������� ������� ������ ������ � ������� ����� �� �������
procedure FrontOrderLeft(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, ' '); // ���������� �������� �����
    FrontOrderLeft(v^.left);
    FrontOrderLeft(v^.right);
  end;
end;
// 1.1) ��������� ������� ������ ������ � ������� ����� � ������� �� �������
procedure FrontOrderLeftPosition(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, '[', v^.depth, ',', v^.weight, ',', v^.height, '] '); // ���������� �������� �����
    FrontOrderLeftPosition(v^.left);
    FrontOrderLeftPosition(v^.right);
  end;
end;

// 2) ��������� ������� ������� ������ � ������� �� �������
procedure FrontOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, ' '); // ���������� �������� �����
    FrontOrderRight(v^.right);
    FrontOrderRight(v^.left);
  end;
end;

// -----------------------------------------------------------------------------
// �������� �����
// �������� ������� ������ (BackOrder, DownTopOrder, ����� �����)
// ����������� � ���, ��� ������ ������ ���������� ����� ��� �����������.
// ���� ������� ���������� ����� (������) ��������� �����,
// �� ����� ���������� �������� ����� (������) �������.

// 3) ��������� ��������� ������ ������ � ������� �� �������
procedure BackOrderLeft(v: tree_ptr);
begin
  if v <> nil then
  begin
    BackOrderLeft(v^.left);
    BackOrderLeft(v^.right);
    Write(v^.key, ' '); // ���������� �������� �����
  end;
end;

// 4) ��������� ��������� ������� ������ � ������� �� �������
procedure BackOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    BackOrderRight(v^.right);
    BackOrderRight(v^.left);
    Write(v^.key, ' '); // ���������� �������� �����
  end;
end;

// -----------------------------------------------------------------------------
// ���������� �����
// ���������� ������� ������ (InnnerOrder, ����� ������� ��� ������ ������)
// ����������� � ���, ��� ������ ���������� ����� ��������� ������ �� ���
// �����������. ���� ������ ���������� ����� ��������� ��� ������ (�������)
// ���������, �� ����� ���������� ���������� ����� (������) �������. �������,
// ��� ���������� ����� (������) ����� �������� ������� ������ � �������
// ����������� (��������) ������ ������.

// 5) ��������� ������ ����������� ������ � ������� �� �������
procedure InnerOrderLeft(v: tree_ptr);
begin 
  if v <> nil then
  begin
    InnerOrderLeft(v^.left);
    Write(v^.key, ' '); // ���������� �������� �����
    InnerOrderLeft(v^.right);
  end;
end;

// 6) ��������� ������� ����������� ������ � ������� �� �������
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
// ��������������� �������

// 7) ��������� ������ ������ � h ���������
procedure PrintTree(t: tree_ptr; h: Integer);
var j: Integer;
begin
  if t <> nil then
  begin
    PrintTree(t^.left, h+1);
    for j:= 0 to h do Write(#9); // ���� ���������
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

procedure CopyFullTree(sourse: tree_ptr; receiver: tree_ptr);  // ������� ������ ����� �������
begin
  if sourse <> nil then
  begin
    receiver^.key:= sourse^.key;
    receiver^.info:= sourse^.info;
    CopyFullTree(sourse^.left, receiver^.left);
    CopyFullTree(sourse^.right, receiver^.right);
  end;
end;


// 8) ��������� ������ ������
procedure PrintLeftTree(v: tree_ptr);
var lv, h, t: Integer;
    fullTree: tree_ptr;
begin
  h:= v^.height;
  // �������� ����� ���������� ������:
  New(fullTree);
  CreateFullTree(fullTree, h);  //PrintTree(fullTree, h);
  BalancedDepthWeightHeight(fullTree, 0, 0);
  // � ��������� �������� �� ������ ��������� ������ � ��� ���������� ������:
  CopyFullTree(v, fullTree);


  for lv:= 0 to h do
  begin
    // ������ ������ �����:
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
      Write(v^.info); // ���������� �������� �����

      // ������ ����������� ������ ����� ������� ��������:
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

      Write('|'); // ���������� �������� �����

      // ������ ����������� ������ ����� ������� ��������:
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
// ������� ��� ���������� ������, ������� ��������

// 10) ������� �������� ������ ����:
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

// 16) ������� ������� ����� k � ������ � ������ p:
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

// 16) ������� ��������� �������, �������� �� ����� �����-������ � �����������:
procedure BalancedDepthWeightHeight(v: tree_ptr; d: Integer; w: Integer); // ������������� �������, ������ � �������� ����
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

// 17) ��������������� ������� ������ ���� � ����������� ������ � ������ p
function FindMinNode(p: tree_ptr): tree_ptr;
begin
  if p^.left <> nil then Result:= FindMinNode(p^.left)
  else Result:= p;
end;

// 17) ��������������� ������� ������ ���� � ����������� ������ � ������ p
function FindMaxNode(p: tree_ptr): tree_ptr;
begin
  if p^.right <> nil then Result:= FindMaxNode(p^.right)
  else Result:= p;
end;


// -----------------------------------------------------------------------------
// ������� ��� ���������� ��������, �������� ��������  

// 18) C�������� ������� ��� �������� ������������ �������� �� ��������� ������:
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

// 18) C�������� ������� ��� �������� ������������� �������� �� ��������� ������:
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

// 19) ������� ������� �������� �������� �� ��� �����:
function RightRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // �������� ����� k �� ������ p
var q, r, min: tree_ptr;
begin
  if p = nil then Result:= nil
  else
  begin
    if k < p^.key then p^.left:= RightRemoveKey(p^.left, k)
    else
      if k > p^.key then p^.right:= RightRemoveKey(p^.right, k)
      else  // ����� ����, �.�. k = p^.key
        begin
          // Writeln(p^.key); // 11 ��� �������
          q:= p^.left; // ��������� ����� ���������   // 10
          r:=p^.right; // ��������� ������ ���������  // 13
          if r = nil then p:= q   // ���� ������� ��������� ���, ������ ��������� �� ����� ������ ���� �����
          else
          begin
            min:= FindMinNode(r); // ����� ���� ����������� ������� � ������ ��������� � ���������� ���
            // Writeln(min^.key); // 12 ��� �������
            min^.right:= RemoveMinNode(r); // ��������� � ������ ��������� 12 �������� ������� 13 � ��� ��� �������
            // Writeln((min^.right)^.key);  // ��� �������
            min^.left:= q;
            p:= min; // ��� ����� �� ���� // p:= min; // ��� ����� �� ����
            Result:= p; //BalanceNode(min);
          end;  
        end;  
  end;
  // � ���� �� ������ ���������, �� ����������� ����, ��� ������ ���������� nil
  if p <> nil then Result:= p //BalanceNode(p)
  else Result:= nil;
end;

// 19) ������� ������ �������� �������� �� ��� �����:
function LeftRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // �������� ����� k �� ������ p
var q, r, max: tree_ptr;
begin
  if p = nil then Result:= nil
  else
  begin
    if k < p^.key then p^.left:= LeftRemoveKey(p^.left, k)
    else
      if k > p^.key then p^.right:= LeftRemoveKey(p^.right, k)
      else  // ����� ����, �.�. k = p^.key
        begin
          // Writeln(p^.key); // 11 ��� �������
          q:= p^.left; // ��������� ����� ���������   // 10
          r:=p^.right; // ��������� ������ ���������  // 13
          if r = nil then p:= q   // ���� ������� ��������� ���, ������ ��������� �� ����� ������ ���� �����
          else
          begin
            max:= FindMaxNode(r); // ����� ���� ����������� ������� � ������ ��������� � ���������� ���
            // Writeln(min^.key); // 12 ��� �������
            max^.right:= RemoveMaxNode(r); // ��������� � ������ ��������� 12 �������� ������� 13 � ��� ��� �������
            // Writeln((min^.right)^.key);  // ��� �������
            max^.left:= q;
            p:= max; // ��� ����� �� ���� // p:= min; // ��� ����� �� ����
            Result:= p; //BalanceNode(min);
          end;  
        end;  
  end;
  // � ���� �� ������ ���������, �� ����������� ����, ��� ������ ���������� nil
  if p <> nil then Result:= p //BalanceNode(p)
  else Result:= nil;
end;


// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ������� ��� ���������� ������� ������

// 20) ����������� ������� �������� ���������� ����������� � ����
function ParentCount(v: tree_ptr): Integer;
begin
  if v <> nil then
  Result:= 1 + ParentCount(v^.left) + ParentCount(v^.right)
  else Result:= 0;
end;

// 21) ��������� ������ � ����������� � ������ ������ ��� �����, � ������� ����������
// �������� � ����� ��������� ���������� �� ���������� �������� � ������
// ��������� �� 1
// �������� ��������� �� ������, ������ �� ������ � ����� ��������
procedure CopyLR(v: tree_ptr; var arr : Mass);
begin
  if v <> nil then
  begin
    if Abs( ParentCount(v^.left) - ParentCount(v^.right) ) = 1 then
    begin
      i:= i + 1;
      arr[i]:= v^.key; // ����������� �������� �����
      // Writeln(arr[i]);
    end;
    CopyLR(v^.left, arr);
    CopyLR(v^.right, arr);
  end;
end;

// ������� ����������� � ������
function CopyLRtoMassiv(v: tree_ptr): Mass;
var size : Integer;
    arr : Mass;
begin
  if v <> nil then
  begin
    // ���������� ���������� ���������, ����� �����, ������ ������� ������� ������:
    size:= CountLR(v);
    SetLength(arr, size);  // ���������� ����� ����������� �������
    i:= -1;
    CopyLR(v, arr); // ��������� ����������� ���������� �������� � ������
    Result:= arr;
  end
  else Result:= nil;
end;

// 22) ������� �������� ���������� �����, � ������� ����������
// �������� � ����� ��������� ���������� �� ���������� �������� � ������
// ��������� �� 1
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

// ��������� ���������� � �������� (������ ���������) ������� �� ��������
// ������� �� ������ ������, � ������� ���������� �������� � ����� ���������
// ���������� �� ���������� �������� � ������ ��������� �� 1
function FindMiddleAndRightRemove(v: tree_ptr): tree_ptr;
var arr: Mass;
    n: Integer; // ���������� ���������
    key: Integer; // ��������� ���� ������� �� �������� �������
begin
  // ���������� ���������� ���������� ���������:
  n:= CountLR(v);
  //Writeln(n);
  if n = 0 then
    Writeln('���������� ����� �� �������. ���������� ���������')
  else
  begin
    arr:= CopyLRtoMassiv(v); // ����� ��� ������, ��������� ��� ���������� �������� � ������
    QuickSortNonRecursive(arr); // ��������� ������
    PrintArr(arr); // �������� ��� �������� �������
    if (n mod 2) = 0 then
    begin
      Writeln('���������� ��������� ������ ���������� (', n, ')');
      Writeln('��� ������� ����� ��������� �����. ���������� ���������');
    end
    else
    begin
      key:= arr[(n div 2)];
      Writeln('���������� ��������� �������� ���������� (', n, ')');
      Writeln('������� �� �������� �������: ', key);
      // � ������� ������ ��������� �������� �������:
      v:= RightRemoveKey(v, key); // �������� ����� k �� ������ p
      BalancedDepthWeightHeight(v, 0, 0); // ������������� ��� ������� � ��������
    end;
  end;
  Result:= v;
end;

// ������� ���������� � �������� (����� ���������) ������� �� ��������
// ������� �� ������ ������, � ������� ���������� �������� � ����� ���������
// ���������� �� ���������� �������� � ������ ��������� �� 1
function FindMiddleAndLeftRemove(v: tree_ptr): tree_ptr;
var arr: Mass;
    n: Integer; // ���������� ���������
    key: Integer; // ��������� ���� ������� �� �������� �������
begin
  // ���������� ���������� ���������� ���������:
  n:= CountLR(v);
  //Writeln(n);
  if n = 0 then
    Writeln('���������� ����� �� �������. ���������� ���������')
  else
  begin
    arr:= CopyLRtoMassiv(v); // ����� ��� ������, ��������� ��� ���������� �������� � ������
    QuickSortNonRecursive(arr); // ��������� ������
    PrintArr(arr); // �������� ��� �������� �������
    if (n mod 2) = 0 then
    begin
      Writeln('���������� ��������� ������ ���������� (', n, ')');
      Writeln('��� ������� ����� ��������� �����. ���������� ���������');
    end
    else
    begin
      key:= arr[(n div 2)];
      Writeln('���������� ��������� �������� ���������� (', n, ')');
      Writeln('������� �� �������� �������: ', key);
      // � ������� ������ ��������� �������� �������:
      v:= LeftRemoveKey(v, key); // �������� ����� k �� ������ p
      BalancedDepthWeightHeight(v, 0, 0); // ������������� ��� ������� � ��������
    end;
  end;
  Result:= v;
end;

// ��������� ������ �� ������� ��������� ������� �����
procedure PrintArr(arr: Mass);
var j: Integer;
begin
  write('���������� ��������: ');
  for j:= 0 to Length(arr)-1 do
  begin
    write(arr[j], ' ');
  end;
  Writeln;
end;



end.
