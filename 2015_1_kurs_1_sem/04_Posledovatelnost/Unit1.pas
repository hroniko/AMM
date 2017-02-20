///////////////////////////////////////////////
// Программа  анализа текста на соотвествие  //
// условиям                                  //
// Автор: Anatoly                            //
// 4 задача                                  //
// ПММ, 1 курс, В/О, гр. 12, 3 вариант       //
// (№52, стр. 145)                           //
// 2015-10-12                                //
///////////////////////////////////////////////

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls;

type
  TForm1 = class(TForm)
    grp1: TGroupBox;
    grp2: TGroupBox;
    btn_OK: TButton;
    mmo1: TMemo;
    mmo_Input: TMemo;
    grp3: TGroupBox;
    mmo_Output: TMemo;
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
var slovo: string; // Переменная для хранения введенного текста
    i: Integer; // Счетчики для элементов суммы
    bed_sim: string; // Переменная для хранения запрещенных символов во введенной строке
    zakluchenie: string; // Текстовая переменная для хранения заключительной фразы
    max, min: Integer; // Переменные для хранения минимального и максимального кода элемента
begin
//
    mmo_Output.Clear; // Очищаем многострочную текстовую панель
    // 1. Пытаемся прочитать из текстового поля
    try
      slovo:=mmo_Input.Lines.Strings[0];
      if mmo_Input.Lines.Count > 1 then
      begin
        for i:=1 to mmo_Input.Lines.Count-1 do
          begin
            slovo:= slovo + mmo_Input.Lines.Strings[i];
          end;
        mmo_Input.Clear; // Очищаем многострочную текстовую панель
        mmo_Input.Lines.Add(slovo);
        //mmo_Output.Lines.Add('Введенный текст состоит из нескольких строк!');
        //mmo_Output.Lines.Add('При анализе текста значения всех строк были объединены в одну строку.');
      end;
    except
      mmo_Output.Lines.Add('Не удалось прочитать входные значения!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('Проверьте корректность введенных данных!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('Вычисления остановлены!');
      Exit // Выходим из подпрограммы
    end;

    // 2. Проверяем введенные данные:
    if (Length(slovo) = 0) then  // Если слово "пустое" (имеет нулевую дилину), то
      begin
        mmo_Output.Lines.Add('Введенный текст состоит из пустой строки!');
        mmo_Output.Lines.Add('');
        mmo_Output.Lines.Add('Вычисления остановлены!');
        Exit // и завершаем подпрограмму
      end;

    i:=1; bed_sim:='';
    while (i <= Length(slovo)) do // анализируем строку от начала до конца
      begin
        if not (slovo[i] in ['0'..'9']) and not (slovo[i] in ['0'..'9', 'A'..'Z','a'..'z', 'А'..'Я', 'а'..'я']) then // если не все слово состоит из разрешенных символов, то
          begin
            bed_sim:= bed_sim + slovo[i];
          end;
        i:=i+1; // делаем шаг к следующей букве строки
      end;
    if Length(bed_sim)>0 then  // и если количество "плохих" символов больше 0, то выводим сообщения:
    begin
      mmo_Output.Lines.Add('Введенный текст содержит запрещенные символы: ' + bed_sim);
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('Разрешены только цифры и буквы русского и латинского алфавитов.');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('Вычисления остановлены!');
      Exit {и завершаем программу}
    end;

    // 3. Работаем со строкой
    // Ищем максимальный и минимальный элемент по его номеру кода в таблице кодов символов
    max:= ord(slovo[1]);
    min:= max;

    for i:=2 to Length(slovo) do // Для все номеров со второго по последний элемент строки
    begin
      if ( ord(slovo[i]) > max ) then max:= ord(slovo[i]);
      if ( ord(slovo[i]) < min ) then min:= ord(slovo[i]);
    end;


    for i:=2 to Length(slovo) do // Для все номеров со второго по последний элемент строки
    begin
      if ( ord(slovo[i]) > max ) then max:= ord(slovo[i]);
      if ( ord(slovo[i]) < min ) then min:= ord(slovo[i]);
    end;


    zakluchenie:= '';
    for i:=1 to Length(slovo) do // Для все номеров со второго по последний элемент строки
    begin
      if ( ord(slovo[i]) <> max ) and ( ord(slovo[i]) <> min ) then zakluchenie:= zakluchenie + slovo[i];
    end;


    // 4. Выводим в многострочное текстовое поле результаты анализа:
    mmo_Output.Lines.Add('Вычисления выполнены!');
    mmo_Output.Lines.Add('');
    mmo_Output.Lines.Add('Новая последовательность:');
    mmo_Output.Lines.Add(zakluchenie);
    mmo_Output.Lines.Add('');
    mmo_Output.Lines.Add('Минимальный  элемент: ' + chr(min) + ' (код ' + IntToStr(min) + ')');
    mmo_Output.Lines.Add('Максимальный элемент: ' + chr(max) + ' (код ' + IntToStr(max) + ')');
end;

end.
