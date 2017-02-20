///////////////////////////////////////////////
// Программа  расчета площади  тупоугольного //
// равнобедренного треугольника по  трем его //
// точкам (координатам точек). Выводит длины //
// сторон  треугольника и  площадь в порядке //
// возрастания (только  для  равнобедренного //
// тупоугольного треугольника)               //
// Автор: Anatoly                            //
// ПММ, 1 курс, В/О, гр. 12, 16 вариант      //
// 2015-09-10                                //
///////////////////////////////////////////////

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm1 = class(TForm)
    mmo_Output: TMemo;
    btn_OK: TButton;
    grp_A: TGroupBox;
    edt_A_x: TEdit;
    lbl_A_x: TLabel;
    lbl_A_y: TLabel;
    edt_A_y: TEdit;
    grp_B: TGroupBox;
    lbl_B_x: TLabel;
    lbl_B_y: TLabel;
    edt_B_x: TEdit;
    edt_B_y: TEdit;
    grp_C: TGroupBox;
    lbl_C_x: TLabel;
    lbl_C_y: TLabel;
    edt_C_x: TEdit;
    edt_C_y: TEdit;
    grp_Zadanie: TGroupBox;
    lbl_Zadanie: TLabel;
    procedure btn_OKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn_OKClick(Sender: TObject);  // Процедура обработки нажатия кнопки и вычисления площади треугольника при выполнении всех условий
var x1, y1, x2, y2, x3, y3: Extended;    // Координаты точек
    AB, BC, AC: Extended;  // Длины сторок треугольника
    LMax, LMin: Extended;  // Максимальная и минимальная длины сторон треугольника
    H, S: Extended; // Высота и площадь треугольника
    H1: Extended; // Вторая и третья высоты треугольника
begin
    mmo_Output.Clear;
    // 1. Пытаемся прочитать координаты точек с полей:
    try
      x1:= StrToFloat(edt_A_x.Text);
      y1:= StrToFloat(edt_A_y.Text);
      x2:= StrToFloat(edt_B_x.Text);
      y2:= StrToFloat(edt_B_y.Text);
      x3:= StrToFloat(edt_C_x.Text);
      y3:= StrToFloat(edt_C_y.Text);
    except
      mmo_Output.Lines.Add('Не удалось прочитать все координаты точек!');
      mmo_Output.Lines.Add('Проверьте правильность введенных данных!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('Вычисления остановлены!');
      Exit // и завершаем подпрограмму
    end;

    // 2. Если прочитали координаты и не возникло исключения при преобразовании, то
    // проверяем, не совпадают ли точки:
    if ((x1 = x2) and (y1 = y2)) or ((x1 = x3) and (y1 = y3)) or ((x3 = x2) and (y3 = y2)) then   // если любые две точки совпали, то
      begin
        mmo_Output.Lines.Add('Введены координаты совпадающих точек!');
        mmo_Output.Lines.Add('Данная фигура не является треугольником!');
        mmo_Output.Lines.Add('');
        mmo_Output.Lines.Add('Вычисления остановлены!');
        Exit // и завершаем подпрограмму
      end;

    // 3. Если точки не совпали, вычисляем длины сторон треугольника:
    AB:= Sqrt(Power((x1 - x2), 2) + Power((y1 - y2), 2));
    BC:= Sqrt(Power((x2 - x3), 2) + Power((y2 - y3), 2));
    AC:= Sqrt(Power((x1 - x3), 2) + Power((y1 - y3), 2));


    // 4. Проверяем, соответствуют ли размеры отрезков треугольнику вообще
    // (если сумма двух сторон меньше или равна третьей, то это не теугольник)
    if ( ((AB+BC) <= AC) or ((AB+AC) <= BC) or ((BC+AC) <= AB) ) then
    begin
      mmo_Output.Lines.Add('Данная фигура не является треугольником!');
      mmo_Output.Lines.Add('Сумма длин двух сторон не превышает длины третьей!');
      mmo_Output.Lines.Add('AB= ' + FloatToStrF(AB,fffixed,8,3)
      + '; BC= ' + FloatToStrF(BC,fffixed,8,3)
      + '; AC= ' + FloatToStrF(AC,fffixed,8,3));
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('Вычисления остановлены!');
      Exit // и завершаем подпрограмму
    end;

    // 5. Проверяем, является ли треугольник равнобедренным, и если ДА, то находим его основание (большую сторону) и боковую сторону (меньшую):
    if (AB = BC) then
      begin
        LMin:= AB;
        LMax:= AC;
      end
    else
      if (AB = AC) then
        begin
          LMin:= AB;
          LMax:= BC;
        end
      else
        if (BC = AC) then
          begin
            LMin:= BC;
            LMax:= AB;
          end
        else   // Если нет равных сторон, тругольник не равнобедренный
          begin
            mmo_Output.Lines.Add('Данный треугольник не является равнобедренным!');
            mmo_Output.Lines.Add('');
            mmo_Output.Lines.Add('Вычисления остановлены!');
            Exit // и завершаем подпрограмму
          end;

     // 6. Если на предыдущем шаге не вышли из подпрограммы, то треугольник равнобедренный,
     // проверяем, является ли он тупоугольным:
     if ( (Power(LMax, 2)) > (Power(LMin, 2) * 2.0)  )  then     // Если квадрат большей стороны больше удвоенного квадрата меньшей, то треугольник тупоугольный
       begin
         mmo_Output.Lines.Add('Треугольник является равнобедренным и тупоугольным!');
       end
     else
       begin
         mmo_Output.Lines.Add('Данный треугольник является равнобедренным, но');
         mmo_Output.Lines.Add('не является тупоугольным!');
         mmo_Output.Lines.Add('');
         mmo_Output.Lines.Add('Вычисления остановлены!');
         Exit // и завершаем подпрограмму
       end;

     // 7. Если на предыдущем шаге не вышли из подпрограммы, то вычисляем высоту и площадь:
     H:= Sqrt( Power(LMin, 2) - Power( (LMax/2), 2) ); // Использована теорема Пифагора


     S:= 0.5 * LMax * H;  // Использована формула площади треугольника

     if (AB > AC) or (BC > AC) then  // Если АВ - большая сторона, то

         H1:= 2.0 * S / AC

     else
         H1:=  2.0 * S / AB;


     mmo_Output.Lines.Add('Длина боковой  (меньшей)  стороны: ' + FloatToStrF(LMin,fffixed,8,3));
     mmo_Output.Lines.Add('Длина основания (большей стороны): ' + FloatToStrF(LMax,fffixed,8,3));
     mmo_Output.Lines.Add('Высоты треугольника H = ' + FloatToStrF(H,fffixed,8,3)+ '; ' + FloatToStrF(H1,fffixed,8,3)+ '; ' + FloatToStrF(H1,fffixed,8,3));
     mmo_Output.Lines.Add('Площадь треугольника S = ' + FloatToStrF(S,fffixed,8,3));

     // 8. По заданию выводим длины сторон и площадь в порядке возрастания:
     mmo_Output.Lines.Add('');
     mmo_Output.Lines.Add('Длины сторон и площадь в порядке возрастания: ');
     if (S > LMax) then  mmo_Output.Lines.Add( FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(LMax,fffixed,8,3) + '; '  + FloatToStrF(S,fffixed,8,3) )
     else
       if (S < LMin) then  mmo_Output.Lines.Add( FloatToStrF(S,fffixed,8,3) + '; ' + FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(LMin,fffixed,8,3) + '; '  + FloatToStrF(LMax,fffixed,8,3) )
       else mmo_Output.Lines.Add( FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(LMin,fffixed,8,3) + '; ' + FloatToStrF(S,fffixed,8,3) + '; '  + FloatToStrF(LMax,fffixed,8,3) )
end;

end.
