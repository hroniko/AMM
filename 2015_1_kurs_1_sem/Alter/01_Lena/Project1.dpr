program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Math;

var x1, x2, x3, y1, y2, y3:integer;
   var a, b, c, Plosh :real;
begin
   write ('Enter x1='); read(x1);
   write ('Enter y1='); read(y1);
   write ('Enter x2='); read(x2);
   write ('Enter y2='); read(y2);
   write ('Enter x3='); read(x3);
   write ('Enter y3='); read(y3);

   a:=sqrt(    power((x1-x2),2)+power((y1-y2),2)  );
   b:=sqrt(    power((x2-x3),2)+power((y2-y3),2)  );
   c:=sqrt(    power((x3-x1),2)+power((y3-y1),2)  );
   if (a = 0) or (b = 0) or (c = 0) then   // ≈сли есть хоть одна нулева€ сторона, то дальше не считаем
     begin
       writeln('Odna iz storon = 0');
     end

   else
     begin
       if (a >= b + c) or (b >= a + c) or (c >= a + b) then  // ≈сли нарушаетс€ неравенство треугольника хот€ бы дл€ одной стороны, то не считаем дальше
         begin
           writeln('Figura ne yavlyaetsya treugolnikom');
         end
       else
         begin
         if (a*a= b*b+ c*c) then
         begin
           writeln('Treugolnik yavlyaetsya pryamougolnim!');
           Plosh:=(b*c)/2;
           if b<c then writeln('b=',b:5:2, ' c=', c:5:2,' a=',a:5:2, 'Plosh = ',Plosh:5:2)
           else writeln('c=',c:5:2, ' b=', b:5:2,' a=',a:5:2, ' Plosh = ',Plosh:5:2);
         end;
         if (b*b=a*a+c*c) then
         begin
           writeln('Treugolnik yavlyaetsya pryamougolnim!');
           Plosh:=(a*c)/2;
           if a<c then writeln('a=',a:5:2, ' c=',c:5:2,' b=',b:5:2, 'Plosh = ',Plosh:5:2)
           else writeln('c=',c:5:2, ' a=',a:5:2,' b=',b:5:2, ' Plosh = ',Plosh:5:2);
         end;
         if (c*c=a*a+b*b) then
         begin
           writeln('Treugolnik yavlyaetsya pryamougolnim!');
           Plosh:=(a*b)/2;
           if a<b then writeln('a=',a:5:2, ' b=',b:5:2,' c=',c:5:2, 'Plosh = ',Plosh:5:2)
           else writeln('b=',b:5:2, ' a=',a:5:2,' c=',c:5:2, ' Plosh = ',Plosh:5:2);
         end;
         if  ((power(a,2)<>power(b,2)+power(c,2)) and (power(b,2)<>power(a,2)+power(c,2)) and (power(c,2)<>power(b,2)+power(a,2))) then
         writeln('Treugolnik NE yavlyaetsya pryamougolnim!');
         end;

     end;



readln;
readln;
end.
