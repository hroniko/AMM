program Project1;

{$APPTYPE CONSOLE}

uses
  //SysUtils,
  EsConsole in 'EsConsole.pas';    // Подключаем модуль русификации

var myTextFile: TextFile; // Переменная типа тестовый Файл
    stroka: string; // переменная для хранения строки
    word, wordMax, wordOut: string; // текущее слово, слово максимальной длины, набор слов максимальной длины
    i: Integer; // Счетчик букв

begin
  { TODO -oUser -cConsole Main : Insert code here }

  try   // Пытаемся работать с текстовым файлом. Если файл недоступен, вывалится исключение, мы его отловым  в блоке except
    AssignFile(myTextFile, 'TestText.txt');  // Привязываем текстовый файл к переменной
    Reset(myTextFile); // Открываем файл для чтения


    // Запускаем поиск
    while (not EOF(myTextFile)) do   // Внешний цикл по файлу (шагаем от строки к строке)
    begin
      Readln(myTextFile, stroka); // Вытаскиваем текущую строку из файла в переменную stroka
      i:= 1;   // Обнуляем счетчик (А так как Паскаль, то строки нумеруются с 1ой, т.е. "объединичиваем"))
      word:= ''; // Обнуляем слово
      wordMax:= '';  // Обнуляем максимальное слово
      wordOut:= '';  // Обнуляем накопитель всех максимальных слов
      while (i <= Length(stroka)) do  // промежуточный цикл - по текущей строке (от буквы к букве)
      begin
        if (stroka[i] <> ' ') then  // Если текущая прочитанная буква не пробел, загоняем букву в текущее слово
        begin
          word:= word +  stroka[i];
        end
        else  // Иначе
        begin
          // Проверяем текущее слово, является ли оно максимальным:
          if Length(word) = Length(wordMax) then    // Если длина совпадает с текущим максимальным, то добавляем слово в набор слов максимальной длины
          begin
            wordOut:= wordOut + word + ' ';
          end
          else
            if Length(word) > Length(wordMax) then    // иначе, если слово больше максимального,
            begin
              wordMax:= word;  // переписываем максимальное,
              wordOut:= word + ' ';    // переписываем весь комплект накопленных слов
            end;
          word:= '';  // обнуляем слово
        end;

        i:= i + 1; // делаем шаг по строке
      end;

      // Проверяем последнее слово

          if Length(word) = Length(wordMax) then    // Если длина совпадает с текущим максимальным, то добавляем слово в набор слов максимальной длины
          begin
            wordOut:= wordOut + word + ' ';
          end
          else
            if Length(word) > Length(wordMax) then
            begin
              wordMax:= word;
              wordOut:= word + ' ';
            end;

      Writeln(wordOut); // выводим на экран совокупность слов максимальной длины текущей строки
    end;
    CloseFile(myTextFile);  // закрываем файл

  except // В случае чего, обрабатываем исключение
    Writeln('В папке с программой файл не найден!');
  end;

  Readln;  // Ждем подтверждения от пользователя
end.
