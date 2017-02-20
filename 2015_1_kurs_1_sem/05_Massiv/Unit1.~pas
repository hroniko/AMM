unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    edt_X: TEdit;
    GroupBox2: TGroupBox;
    edt_N: TEdit;
    GroupBox3: TGroupBox;
    edt_E: TEdit;
    mmo_Result: TMemo;
    btn_OK: TButton;
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

procedure TForm1.btn_OKClick(Sender: TObject);   // Процедура обработки нажатия кнопки
var X, E: Extended; // Переменные под значения Х и Е
    N: Integer; // Переменная под количество слагаемых
    i, j, k: Integer; // Счетчики для элементов суммы
    Summa_all: Extended; // Накопитель для суммы по всем элементам
    Slagaemoe: Extended; // накопитель для слагаемого
begin
//
    mmo_Result.Clear; // Очищаем многострочную текстовую панель
    // 1. Пытаемся прочитать из текстовых полей
    try
      X:= StrToFloat(edt_X.Text);
      N:= StrToInt(edt_N.Text);
      E:= StrToFloat(edt_E.Text);
    except
      mmo_Result.Lines.Add('Не удалось прочитать входные значения!');
      mmo_Result.Lines.Add('Проверьте корректность введенных данных!');
      mmo_Result.Lines.Add('');
      mmo_Result.Lines.Add('Вычисления остановлены!');
      Exit // Выходим из подпрограммы
    end;

    // 2. Если корректно прочитали значения, выполняем задание (а) - вычисляем сумму N слагаемых заданного вида:
    i:= 1; // Сбрасываем счетчики
    j:= 1;
    k:= 1;
    Summa_all:= 0; // Обнуляем сумму
    Slagaemoe:= 0;
    while (i <= N ) do     // Для все элементов с певого до N считаем сумму по формуле
      begin
        //
        if ( (i mod 2) <> 0 ) then // Если слагаемое нечетное, то
          begin
            //
            Slagaemoe:= 1;  // Выставляем знак слагаемого
          end
        else
          begin
            Slagaemoe:= -1;  // Выставляем знак слагаемого
          end;

      i:= i + 1; // Делаем шаг по номеру слагаемого    
      end;

end;

end.
