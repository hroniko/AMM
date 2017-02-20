unit MySimpleTree; // ������ ���������� ������� ��������

interface // ---- ������ �������� ---

uses SysUtils, Math;

// �������� ���� - ��������� ��������� ������ �� ����������:
// ������������� � ���� ��������� ���������:
type
  tree_ptr = ^ tree_node;
  tree_node = record
     key: Integer;    // ���� ����
     height: Integer; // ������ ���� (���������� � ����� �� ���� �� �������� ���������� �������)
     left: tree_ptr; // ����� ������� (���������)
     right: tree_ptr; // ������ ������� (���������)
  end;


// ������� � ���������
procedure FrontOrderLeft(v: tree_ptr);  // ��������� ������� ������ ������ � ������� ����� �� �������
function HeightNode(t: tree_ptr): Integer;    // ��������������� ������� �������� ������ ����
function FixHeight(v: tree_ptr): Integer; // ��������������� ������� ����������� ������ �������
function InsertKey(p: tree_ptr; k: Integer): tree_ptr; // �������� ������� ������� ����� k � ������ � ������ p
procedure BalancedDepthWeightHeight(v: tree_ptr; d: Integer; w: Integer); // ��������������� ������� ����������� ������-������-������� ���� ����� ������ (��� ���������� / �������� ����)
function FindMinNode(p: tree_ptr): tree_ptr;  // ��������������� ������� ������ ���� � ����������� ������ � ������ p
function RemoveMinNode(p: tree_ptr): tree_ptr; // C�������� ������� ��� �������� ������������ �������� �� ��������� ������:
function RemoveMaxNode(p: tree_ptr): tree_ptr; // C�������� ������� ��� �������� ������������� �������� �� ��������� ������:
function RightRemoveKey(p: tree_ptr; k: Integer): tree_ptr; // �������� ������� ������� �������� �������� �� ��� �����
function MinLenWay(v: tree_ptr): Integer; // �������� ������� ����������� ����������� ����� ����, ����������� ����� �������� ����
function MinLenWayOne(v: tree_ptr): Integer; // ��������������� ������� ����������� ����������� ����� ����, ����������� ����� �������� ����
function SumAllKey(v: tree_ptr): Integer; // ��������������� ������� (�� ����� �����) ���������� ����� ���� ��������� ���� ����������� �����, ���������� ����� �������� ����
function FindNodeBetween_MinLenWay(v: tree_ptr): tree_ptr; // �������� ������� ������ ����, ����� ������� �������� ���� ����������� �����
procedure FindNode_MinLenWay(v: tree_ptr);  // ��������������� ��������� ������ ������ � ������ ����, ����� ������� �������� ���� ����������� �����




var
    tmpN: tree_ptr;  // ���� ��� �������� ����
    tmpL: Integer; // ���������� ��� �������� ����� ����
    tmpS: Integer; // ���������� ��� �������� ����������� ����� �������� ���������


implementation // ---- ������ ���������� ---

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

// -----------------------------------------------------------------------------
// ��������� � ������� ��� �������, ������ � �������� ����� � ��������������� ��� ��� ��������� � �������

// 2) ��������������� ������� �������� ������ ����
function HeightNode(t: tree_ptr): Integer;
begin
  if t <> nil then
  HeightNode:= t^.height
  else HeightNode:= 0;
end;

// 3) ��������������� ������� ����������� � ��������� ������ �������
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

// 4) �������� ������� ������� ����� k � ������ � ������ p
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

// 5) ��������������� ������� ����������� ������-������-������� ���� ����� ������ (��� ���������� / �������� ����)
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

// 6) ��������������� ������� ������ ���� � ����������� ������ � ������ p
function FindMinNode(p: tree_ptr): tree_ptr;
begin
  if p^.left <> nil then Result:= FindMinNode(p^.left)
  else Result:= p;
end;    

// 7) C�������� ������� ��� �������� ������������ �������� �� ��������� ������
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

// 8) C�������� ������� ��� �������� ������������� �������� �� ��������� ������
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

// 9) �������� ������� ������� �������� �������� �� ��� �����
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
            p:= min;
            Result:= p;
          end;  
        end;  
  end;
  // � ���� �� ������ ���������, �� ���������� ����, ��� ������ ���������� nil
  if p <> nil then Result:= p
  else Result:= nil;
end;

// -----------------------------------------------------------------------------
// ������� ��� ������� ������

// 10) ����������� ��������������� ������� �������� ���������� �������� ����
function ParentCount(v: tree_ptr): Integer;
begin
  if v <> nil then
  Result:= 1 + ParentCount(v^.left) + ParentCount(v^.right)
  else Result:= 0;
end;

// 11) ��������������� ������� (�� ����� �����) ���������� ����� �������� ��������� ���� ������������ �����, ���������� ����� �������� ����
function SumKey(v: tree_ptr): Integer;
begin
  if ((v^.left = NIL) and (v^.right = NIL)) then   // ���� ����� �� �����, ��
  Result:= v^.key // �� ���������� ���� ����� �����
  else  // ����� ���� ��� ���� ����, ��� ������� ����, � �� � ��� ���
  begin
    if ((v^.left <> NIL) and (v^.right = NIL)) then    // ���� ���� ������ ����� ����, ��
    Result:= SumKey(v^.left);    // ���� �����
    if ((v^.left = NIL) and (v^.right <> NIL)) then    // ���� ���� ������ ������ ����, ��
    Result:= SumKey(v^.right);    // ���� ������
    if ((v^.left <> NIL) and (v^.right <> NIL)) then    // ���� �� ���� ��� ����, ��
    begin // ������, �� ������ ���� ������, � ������ �� �� ������ ��������
      // ���������, ����� ����� �������, �� ��� � ����: // ���� ������ ����� ������ ��� �����, �� �� ��� � ����
      if v^.left^.height >= v^.right^.height then Result:= SumKey(v^.left)
      else SumKey(v^.left);
    end;
  end;
end;

// 12) �������� ������� (�� ����� ������) ���������� ����� �������� ��������� ���� ������������ �����, ���������� ����� �������� ����
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

// 13) �������� ������� ����������� ����������� ����� ����, ����������� ����� �������� ����
function MinLenWay(v: tree_ptr): Integer;
var len: Integer;
begin
  len:= 0;
  if v <> NIL then  // ���� �� ������� ����, ��
  begin
    if v^.left <> NIL then len:= len + 1 + MinLenWayOne(v^.left);  // ����������� �� ����� �� ������ ����� (+1 - �.�. ��� ���� �� ��������)
    if v^.right <> NIL then len:= len + 1 + MinLenWayOne(v^.right); // ����������� �� ����� �� ������� �����
  end;
  Result:= len;
end;

// 14) ��������������� ������� ����������� ����������� ����� ����, ����������� ����� �������� ����
function MinLenWayOne(v: tree_ptr): Integer;
var len: Integer;
begin
  len:= 0;
  if v <> NIL then  // ���� �� ������� ����, ��
  begin
    if (v^.left <> NIL) and (v^.right <> NIL) then
    begin
      // � ���� � �� �����, ������� ������:
      if v^.left.height < v^.right^.height then len:= len + 1 + MinLenWayOne(v^.left)  // ����������� �� ����� �� ������ ����� (+1 - �.�. ��� ���� �� ��������)
      else len:= len + 1 + MinLenWayOne(v^.right); // ����������� �� ����� �� ������� �����
    end;
    if (v^.left <> NIL) and (v^.right = NIL) then len:= len + 1 + MinLenWayOne(v^.left);
    if (v^.left = NIL) and (v^.right <> NIL) then len:= len + 1 + MinLenWayOne(v^.right);
  end;
  Result:= len;
end;

// 15) �������� ������� (�� ����� ������) ���������� ����� ���� ��������� ���� ����������� �����, ���������� ����� �������� ����
function SumAllKey_MinLenWay(v: tree_ptr): Integer;
var sum: Integer;
begin
  sum:=0;
  if v <> nil then sum:= v^.key + SumAllKey(v^.left) + SumAllKey(v^.right);
  Result:= sum;
end;

// 16) ��������������� ������� (�� ����� �����) ���������� ����� ���� ��������� ���� ����������� �����, ���������� ����� �������� ����
function SumAllKey(v: tree_ptr): Integer;
var sum: Integer;
begin
  sum:= 0;
  if v <> NIL then  // ���� �� ������� ����, ��
  begin
    if (v^.left <> NIL) and (v^.right <> NIL) then
    begin
      // � ���� � �� �����, ������� ������, ���, ���� �����, �� � ����� - ��� ���� ������!:
      if v^.left.height <= v^.right^.height then sum:= sum + SumAllKey(v^.left)
      else sum:= sum + SumAllKey(v^.right);
    end;
    if (v^.left <> NIL) and (v^.right = NIL) then sum:= sum + SumAllKey(v^.left);
    if (v^.left = NIL) and (v^.right <> NIL) then sum:= sum + SumAllKey(v^.right);
  end;
  Result:= sum;
end;

// 17) �������� ������� ������ ����, ����� ������� �������� ���� ����������� �����
function FindNodeBetween_MinLenWay(v: tree_ptr): tree_ptr;
begin
  tmpN:= v;   // ���������� � ���������� ���������� ��������� �� NIL
  tmpL:= 10000; // ������� ����� ������������� ���� ������ 0
  tmpS:= 10000; // ���������� � ���������� ���������� ����� ���� ������, ����� ��� ����� �����  �������
  FindNode_MinLenWay(v);  // � ��������� ����� ���� � ������� �����������
  Result:= tmpN;
end;

// 18) ��������������� ��������� ������ ������ � ������ ����, ����� ������� �������� ���� ����������� �����
procedure FindNode_MinLenWay(v: tree_ptr);
var len: Integer;
begin
  len:= MinLenWay(v);
  if (v <> nil) and (len > 1)then
  begin
    //len:= MinLenWay(v); // ���������� ����� ������������ ���� ����� ������� �������


      if len < tmpL then  // ���� ��� ������ ��� ���������, ��
      begin
        tmpN:= v;
        tmpL:= len;
        tmpS:= SumAllKey_MinLenWay(v);
      end;
      if len = tmpL then // ���� �� ��� ����� ��� ���������, �� ����� ���������, � ������� ����� ���� ������ ������
      begin
        if SumAllKey_MinLenWay(v) < tmpS then     // � ���� � ����� ����� ���� ������, ��� � ���������� ���������
        begin
          tmpN:= v;
          tmpL:= len;
          tmpS:= SumAllKey_MinLenWay(v);
        end;
      end;
      FindNode_MinLenWay(v^.left); // ���� ���� �����
      FindNode_MinLenWay(v^.right); // ���� ���� ������
  end;
end;



end.
