program Project2; 

{$APPTYPE CONSOLE} 
uses
  SysUtils,
  System,
  Math;

var x,eps,sum,a, delit:Real;
i,j,N:Integer;
begin 
repeat
write('Vvedite N: ');readln(N);
until N>0;
repeat
write('Vvedite x: ');Readln(x);
until (x>-1)and(x<1);
repeat 
write('Vvedite e: ');Readln(eps);
until eps<1;


// Òî÷íîå çíà÷åíèå ôóíêöèè:
writeln('ln(1-x) = ', ln(1-x):8:5);

// Ñóììà N ïåğâûõ ñëàãàåìûõ
a:= -1; sum:= 0; i:= 1; delit:=0;
while (i <= N ) do
begin
a:= a * x;
delit:= delit + 1;
sum:= sum + (a / delit);
i:= i + 1;
end;
writeln('Summa ',N,' elementov: ',sum:8:5);

// Ñóììà ıëåìåíòîâ, ïî ìîäóëş áîëüøèõ ÷åì eps
a:= -1; sum:= 0; i:= 1; delit:=0;
while (True) do
begin
a:= a * x;
delit:= delit + 1;
if (Abs(a/delit) < Eps) then Break;
sum:= sum + (a / delit);
i:= i + 1;
end;
writeln('Summa elementov bolshe eps: ',sum:8:5,', N=', i);

// Ñóììà ıëåìåíòîâ, ïî ìîäóëş áîëüøèõ ÷åì eps/10
eps:=eps/10;
a:= -1; sum:= 0; i:= 1; delit:=0;
while (True) do
begin
a:= a * x;
delit:= delit + 1;
if (Abs(a/delit) < Eps) then Break;
sum:= sum + (a / delit);
i:= i + 1;
end;
writeln('Summa elementov bolshe eps/10: ',sum:8:5,' N=',i);
readln;
end.
