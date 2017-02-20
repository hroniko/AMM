///////////////////////////////////////////////
// Программа  анализа текста на соотвествие  //
// условиям                                  //
// Автор: Anatoly                            //
// ПММ, 1 курс, В/О, гр. 12, 3 вариант       //
// (№16, стр. 103)                           //
// 2015-10-02                                //
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
    flag_a, flag_b, flag_c: Boolean; // Флаги соотвествия введенного текста условиям а, б и с
    summa_digit: Integer; // переменная для количества цифровых символов в слове
    zakluchenie: string; // Текстовая переменная для хранения заключительной фразы
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
        mmo_Output.Lines.Add('Введенный текст состоит из нескольких строк!');
        mmo_Output.Lines.Add('При анализе текста значения всех строк были объединены в одну строку.');
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

    // 3. Анализируем текст (проверяем на соотвествие заданным условиям)

    // а) Если текст начинается с некоторой ненулевой цифры,
    // за которой следуют только буквы, и их кол-во равно числовому значению этой цифры
    flag_a:= True; // Выставляем флаг (соответсвует)
    if (slovo[1] in ['1'..'9']) and (  (Length(slovo)-1) = StrToInt(slovo[1])  ) then // Если текст начинается с некоторой ненулевой цифры и количество последующих символов совпадает со значением цифры, то
    begin
      i:= 2;
      while (i <= Length(slovo)) and (flag_a = True) do // анализируем строку от второго символа до конца и пока не встретим хоть одну цифру
      begin
        if not (slovo[i] in ['A'..'Z','a'..'z', 'А'..'Я', 'а'..'я']) then // если не все слово состоит из разрешенных символов, то
          begin
            flag_a:= False;
          end;
        i:=i+1; // делаем шаг к следующей букве строки
      end;
    end
    else
      flag_a:= False; // Иначе не соответствует!

    // b) Если текст начинается с k букв (1<=k<=9),
    // за которыми следует только 1 литера - цифра с числовым значением k
    flag_b:= True; // Выставляем флаг (соответсвует)
    if (slovo[Length(slovo)] in ['1'..'9']) and (  StrToInt(slovo[Length(slovo)]) = (Length(slovo)-1)  ) then // Если текст заканчивается на цифру и ее значение совпадает с количеством предыдущих символов, то
    begin
      i:= 1;
      while (i <= ( Length(slovo)-1 ) ) and (flag_b = True) do // анализируем строку с начала до предпоследнего символа и пока не встретим хоть одну цифру
        begin
          if not (slovo[i] in ['A'..'Z','a'..'z', 'А'..'Я', 'а'..'я']) then // если не все слово состоит из разрешенных символов, то
            begin
              flag_b:= False;
            end;
          i:=i+1; // делаем шаг к следующей букве строки
        end;
    end
    else
      flag_b:= False; // Иначе не соответствует!

    // c) Сумма числовых значений цифр, входящих в текст, равна длине текста
    flag_c:= True; // Выставляем флаг (соответсвует)
    i:= 1;
    summa_digit:= 0; // Обнуляем накопитель чисел в слове
    while ( i <= Length(slovo) ) do // анализируем строку с начала до предпоследнего символа и пока не встретим хоть одну цифру
      begin
        if (slovo[i] in ['1'..'9']) then // если попалась цифра (а не буква), то
          begin
            summa_digit:= summa_digit + StrToInt(slovo[i]); // Увеличиваем сумму
          end;
        i:=i+1; // делаем шаг к следующему символу строки
      end;
   if ( summa_digit <> Length(slovo) ) then flag_c:= False; // И если не совпадают, то не соответсвует!


    // 4. Выводим в многострочное текстовое поле результаты анализа:
    mmo_Output.Lines.Add('Вычисления выполнены!');
    mmo_Output.Lines.Add('');
    if (flag_a = True)then zakluchenie:= 'Введенный текст удовлетворяет условию (a), '
    else zakluchenie:= 'Введенный текст НЕ удовлетворяет условию (a), ';

    if (flag_b = True)then zakluchenie:= zakluchenie + 'удовлетворяет условию (b) и '
    else zakluchenie:= zakluchenie +'НЕ удовлетворяет условию (b) и ';

    if (flag_c = True)then zakluchenie:= zakluchenie + 'удовлетворяет условию (c).'
    else zakluchenie:= zakluchenie + 'НЕ удовлетворяет условию (c).';

    mmo_Output.Lines.Add(zakluchenie);
end;

end.
