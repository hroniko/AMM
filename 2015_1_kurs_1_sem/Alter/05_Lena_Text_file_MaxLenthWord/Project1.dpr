program Project1;

{$APPTYPE CONSOLE}

uses
  //SysUtils,
  EsConsole in 'EsConsole.pas';    // ���������� ������ �����������

var myTextFile: TextFile; // ���������� ���� �������� ����
    stroka: string; // ���������� ��� �������� ������
    word, wordMax, wordOut: string; // ������� �����, ����� ������������ �����, ����� ���� ������������ �����
    i: Integer; // ������� ����

begin
  { TODO -oUser -cConsole Main : Insert code here }

  try   // �������� �������� � ��������� ������. ���� ���� ����������, ��������� ����������, �� ��� �������  � ����� except
    AssignFile(myTextFile, 'TestText.txt');  // ����������� ��������� ���� � ����������
    Reset(myTextFile); // ��������� ���� ��� ������


    // ��������� �����
    while (not EOF(myTextFile)) do   // ������� ���� �� ����� (������ �� ������ � ������)
    begin
      Readln(myTextFile, stroka); // ����������� ������� ������ �� ����� � ���������� stroka
      i:= 1;   // �������� ������� (� ��� ��� �������, �� ������ ���������� � 1��, �.�. "��������������"))
      word:= ''; // �������� �����
      wordMax:= '';  // �������� ������������ �����
      wordOut:= '';  // �������� ���������� ���� ������������ ����
      while (i <= Length(stroka)) do  // ������������� ���� - �� ������� ������ (�� ����� � �����)
      begin
        if (stroka[i] <> ' ') then  // ���� ������� ����������� ����� �� ������, �������� ����� � ������� �����
        begin
          word:= word +  stroka[i];
        end
        else  // �����
        begin
          // ��������� ������� �����, �������� �� ��� ������������:
          if Length(word) = Length(wordMax) then    // ���� ����� ��������� � ������� ������������, �� ��������� ����� � ����� ���� ������������ �����
          begin
            wordOut:= wordOut + word + ' ';
          end
          else
            if Length(word) > Length(wordMax) then    // �����, ���� ����� ������ �������������,
            begin
              wordMax:= word;  // ������������ ������������,
              wordOut:= word + ' ';    // ������������ ���� �������� ����������� ����
            end;
          word:= '';  // �������� �����
        end;

        i:= i + 1; // ������ ��� �� ������
      end;

      // ��������� ��������� �����

          if Length(word) = Length(wordMax) then    // ���� ����� ��������� � ������� ������������, �� ��������� ����� � ����� ���� ������������ �����
          begin
            wordOut:= wordOut + word + ' ';
          end
          else
            if Length(word) > Length(wordMax) then
            begin
              wordMax:= word;
              wordOut:= word + ' ';
            end;

      Writeln(wordOut); // ������� �� ����� ������������ ���� ������������ ����� ������� ������
    end;
    CloseFile(myTextFile);  // ��������� ����

  except // � ������ ����, ������������ ����������
    Writeln('� ����� � ���������� ���� �� ������!');
  end;

  Readln;  // ���� ������������� �� ������������
end.
