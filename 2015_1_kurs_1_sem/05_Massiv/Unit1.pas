///////////////////////////////////////////////
// Программа  анализа текста на соотвествие  //
// условиям                                  //
// Автор: Anatoly                            //
// 5 задача                                  //
// ПММ, 1 курс, В/О, гр. 12, 3 вариант       //
// (№35)                                     //
// 2015-10-20                                //
///////////////////////////////////////////////

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls;

type masInt2D = array of array of Integer; // Объявляем тип - Двумерный массив целых чисел
type TPMAS = ^masInt2D;  // Тип - указатель на Двумерный массив целых чисел
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

// Функция получает ссылку на наш двумерный массив (на его первыйэлемент) и ицию элемента по i и j (по строке и столбцу),
// считает сумму цифр числа и находит элементы, чья сумма цифр такая же
function findNumber(pMassiv: TPMAS; i: integer; j: integer; n: integer; m: integer): string;
var k, l: Integer; // Индексаторы строк и столбцов
    s: Integer;
    summ: Integer;
    MassivSumm: masInt2D; // Объявляем экземпляр типа двумерного массива целых чисел для хранения массива сумм
    slovo: string;
    slovo2: string;
begin
SetLength(MassivSumm,n,m); // Выделяем память под наш второй динамический массив (задаем ему установленную размерность)
// Формируем массив сумм:
for k:=0 to n-1 do
  begin
    for l:=0 to m-1 do
      begin
        slovo:= IntToStr(pMassiv^[k,l]);
        summ:=0;
        for s:=1 to Length(slovo) do summ:= summ + StrToInt(slovo[s]);
        MassivSumm[k,l]:=summ;
      end;
  end;

// Ищем в массиве все элементы, чья сумма совпадает с суммай заданного элемента

slovo2:='';
for k:=0 to n-1 do
  begin
    for l:=0 to m-1 do
      begin
        if (MassivSumm[i,j] = MassivSumm[k,l]) and ((i<>k) or (j<>l)) then slovo2:= slovo2 + '[' + IntToStr(k+1) + ';' + IntToStr(l+1) + ']; ' ;
      end;
  end;
if slovo2 = '' then
slovo:= 'Элемент [' + IntToStr(i+1) + ';' + IntToStr(j+1) + '] имеет сумму цифр (' + IntToStr(MassivSumm[i,j]) + '), элементов с такой же суммой цифр нет;'
else slovo:= 'Элемент [' + IntToStr(i+1) + ';' + IntToStr(j+1) + '] имеет такую же сумму цифр (' + IntToStr(MassivSumm[i,j]) + '), как элементы: ' + slovo2;

findNumber:=slovo;
end;


procedure TForm1.btn_OKClick(Sender: TObject);   // Процедура обработки нажатия кнопки
var slovo: string; // Переменная для хранения введенного текста
    i, j, countD, countN, countM, n, m: Integer; // Счетчики
    bed_sim: string; // Переменная для хранения запрещенных символов во введенной строке
    zakluchenie: string; // Текстовая переменная для хранения заключительной фразы
    max, min: Integer; // Переменные для хранения минимального и максимального кода элемента
    Massiv: masInt2D; // Объявляем экземпляр типа двумерного массива целых чисел
    chisloString: string; // Строковое представление одного из чисел
    var PMassiv: TPMAS;//указатель на переменную типа двумерного массива целых чисел
const Digit: Set of Char = ['0' .. '9'];  // Определяем разрешенные символы - только цифры от 0 до 9
begin
//
    mmo_Output.Clear; // Очищаем нижнюю многострочную текстовую панель
    // 1. Подсчет количества элементов и проверка на правильность введенной информации
    // Пытаемся прочитать из многострочного текстового поля
    try
      countN:=0; // Обнуляем счетчик целых непустых строк
      countM:=0; // Обнуляем счетчик целых чисел (столцов) для первой строки (его будем сравнивать с кол-вом целых в др. строках)
      for i:=0 to mmo_Input.Lines.Count-1 do   // для каждой из введенных строк
      begin
        countD:=0; // Обнуляем счетчик целых чисел (столцов) для первой строки (его будем сравнивать с кол-вом целых в др. строках)
        slovo:= mmo_Input.Lines.Strings[i]; // фиксируем текущую строку в переменной строкового типа
        if ( Length(slovo) > 0 ) then// Если строка не нулевая, работаем с ней
          begin
            countD:=0; // Обнуляем счетчик целых чисел
            for j:= 1 to Length(slovo) do // для каждой буквы с первой по последнюю
            begin
              if (slovo[j] in Digit) then   // Если текущий символ - это цифра, то
                begin
                  if (j = 0) then countD:= countD + 1  // если мы в начале строки, то увеличиваем счетчик целых чисел строки
                  else if not(slovo[j-1] in Digit) then countD:= countD + 1; // а если не в начале, то если предыдущий символ был не  цифра, то увеличиваем счетчик целых чисел строки
                end
              else   // иначе (т. е. если не цифра) , то
                if (slovo [j] <> ' ') then // если символ не пробел, то это один из запрещенных символов!
                begin
                  mmo_Output.Lines.Add('Введены запрещенные символы!');
                  mmo_Output.Lines.Add('');
                  mmo_Output.Lines.Add('Проверьте корректность введенных данных!');
                  mmo_Output.Lines.Add('');
                  mmo_Output.Lines.Add('Вычисления остановлены!');
                  Exit // и выходим из подпрограммы
                end;
            end;
              if (countD > 0) then countN:= countN + 1; // Если количество найденных элементов в текущей строке больше нуля, увеличиваем счетчик ненулевых строк
              if (countM = 0) then countM:= countD; // Если текущая строка - самая первая не пустая, то переписываем число найденных элементов в счетчик столбцов

              if (countM <> countD) then // Если число чисел первой строки не равно числу чисел текущей, то выводим:
              begin
                mmo_Output.Lines.Add('Матрица не является прямоугольной!');
                mmo_Output.Lines.Add('');
                mmo_Output.Lines.Add('Число чисел некоторых строк не совпадает!');
                mmo_Output.Lines.Add('');
                mmo_Output.Lines.Add('Вычисления остановлены!');
                Exit // и выходим из подпрограммы
              end
          end
        end;
      if (countN <> 0) then
      begin
        mmo_Output.Lines.Add('Введена матрица размерности ' + IntToStr(countN) + 'х' + IntToStr(countM));
        mmo_Output.Lines.Add('');
        n:= countN;
        m:= countM;
      end
      else
        begin
          mmo_Output.Lines.Add('Вы не ввели элементы матрицы!');
          mmo_Output.Lines.Add('');
          mmo_Output.Lines.Add('Матрица не может быть пустой!');
          mmo_Output.Lines.Add('');
          mmo_Output.Lines.Add('Вычисления остановлены!');
          Exit // и выходим из подпрограммы
        end;
    except
      mmo_Output.Lines.Add('Не удалось прочитать входные значения!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('Проверьте корректность введенных данных!');
      mmo_Output.Lines.Add('');
      mmo_Output.Lines.Add('Вычисления остановлены!');
      Exit // Выходим из подпрограммы
    end;

    // 2. Создание массива установленной размерности и заполнение его элементами
    SetLength(Massiv,countN,countM); // Выделяем память под наш динамический массив (задаем ему установленную размерность)
    chisloString:=''; // Обнуляем строковый эквивалент текущего числа
    // и начинаем наполнять:
    countN:=0; // Обнуляем счетчик целых непустых строк
    countM:=0; // Обнуляем счетчик целых чисел (столцов) для первой строки (его будем сравнивать с кол-вом целых в др. строках)
    for i:=0 to mmo_Input.Lines.Count-1 do   // для каждой из введенных строк
      begin
        countD:=-1; // Обнуляем счетчик целых чисел (столцов) для первой строки (его будем сравнивать с кол-вом целых в др. строках)
        slovo:= mmo_Input.Lines.Strings[i]; // фиксируем текущую строку в переменной строкового типа
        if ( Length(slovo) > 0 ) then// Если строка не нулевая, работаем с ней
          begin
            countD:=-1; // Обнуляем счетчик целых чисел
            chisloString:=''; // Обнуляем строковый эквивалент текущего числа
            for j:= 1 to Length(slovo) do // для каждой буквы с первой по последнюю
            begin
              if (slovo[j] in Digit) then   // Если текущий символ - это цифра, то
                begin
                  if (j = 0) then
                    begin
                      countD:= countD + 1;  // если мы в начале строки, то увеличиваем счетчик целых чисел строки
                      chisloString:= slovo[j];
                    end
                  else
                       if not(slovo[j-1] in Digit) then
                         begin
                           countD:= countD + 1; // а если не в начале, то если предыдущий символ был не  цифра, то увеличиваем счетчик целых чисел строки
                           chisloString:=slovo[j];
                         end
                       else
                         begin
                           chisloString:=chisloString + slovo[j];
                         end;

                end;
              if (chisloString <> '') then Massiv[countN, countD]:= StrToInt(chisloString);
            end;
            if (countD > -1) then countN:= countN + 1; // Если количество найденных элементов в текущей строке больше нуля, увеличиваем счетчик ненулевых строк


          end
        end;

    // 3. Поиск для каждого элемента элементов, сумма цифр которых совпадает с суммой цифр текущего числа
    PMassiv:= @Massiv; // Помещаем в указатель адрес массива
    for i:=0 to (n - 1) do      // Для все строк в массиве
    begin
      for j:=0 to (m - 1) do // Для все столбцов
      begin
        mmo_Output.Lines.Add(findNumber(PMassiv, i, j, n, m));
      end;
    end;

    // и прокручиваем скролл нашего многострочного текста к началу:
    mmo_Output.SelStart:=0;
    mmo_Output.SelLength := 0;




    
end;

end.
