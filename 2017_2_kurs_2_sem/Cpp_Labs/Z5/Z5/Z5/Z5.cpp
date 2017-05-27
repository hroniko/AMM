// Z5.cpp: определяет точку входа для консольного приложения.
//

/*

Если будет Ошибка	C4996	'strcpy': This function or variable may be unsafe. Consider using strcpy_s instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS,
То не забыть в настройках убрать проверку "таких" ошибок:

Проект -> Свойства -> С/С++ -> Общие -> Проверка SDL -> Выбрать Нет(/sdl-)

*/


#include "stdafx.h"

#include <iostream>
#include <string> // подключаем строки
#include <cstring>
#include <fstream> // подключаем файлы
#include <cstdlib> // Для работы с функцией system()

#include <algorithm>
#include <cctype> // Для работы функций  tolower и toupper
#include "windows.h"


using namespace std; // используем стандартное пространство имен



// Прототип функций
void readln(string, string);
bool isContained(string, string);


int main()
{
	// setlocale(LC_ALL, "Russian");
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);

	// Бесконечный цикл
	while (true) {
		cout << "Введите слово для поиска: " << endl; // выводим эту строку на экран


		char *stroka = new char[255]; // на время выделяется память (с запасом) под строку
		cin.getline(stroka, 255); // чтение строки

		string word = string(stroka);
		cout << "Выполняю поиск..." << endl;

		readln("myFile.txt", word); // Вся логика тут: отдаем в функцию имя файла и слово, которое нужно будет построчно искать

		system("pause"); // Команда задержки экрана
		system("cls");
	}

    return 0;
}

// 1 Функция построчного чтения файла и вывода всех строк до строки, в которой есть заданное слово
void readln(string putch, string word) {
	string s; // сюда будем класть считанные строки
	ifstream file("C:\\tmpFiles\\" + putch); // // файл из которого читаем (для линукс путь будет выглядеть по другому)

	
	int i = 0; // Счетчик строк
	while (getline(file, s)) { // пока не достигнут конец файла и пока не встретилось искомое слово, помещать очередную строку в переменную (s)
		
		i++;
		if (!isContained(s, word)) { // Проверяем текущую строку на вхождение данного слова
			//
			cout << i << ": " << s << endl; // Если вхождения нет, то выводим эту строку на экран
		}
		else {
			// Иначе выводим сообщение о том, что слово найдено в такой-то строке и выходим
			cout << "\nВнимание!\nОбнаружено вхождение искомого слова в строку № " << i << ":" << endl; // Если вхождения нет, то выводим эту строку на экран
			cout << i << ": " << s << endl; // выводим эту строку на экран
			file.close(); // обязательно закрываем файл что бы не повредить его
			return;
		}
	}
	// Иначе, если дошли до этой точки, выводим сообщение о том, что слово НЕ найдено и выходим
	cout << "\nНеудача!\nФайл не содержит искомого слова!" << endl; // Если вхождения нет, то выводим эту строку на экран
	file.close(); // обязательно закрываем файл что бы не повредить его
}

// 2 Функция проверки на вхождение в строку данного слова
bool isContained(string stroka, string substroka) {
	if (stroka.length() < 1) return false; // Проверяем, воа вдруг мы передали пустую строку, тогда выходим
	if (substroka.length() < 1) return false; // Проверяем, а вдруг мы передали пустую подстроку, тогда выходим

	// А тут переводим строки к нижнему регистру, чтобы искало и с маленькой, и с большой // Чего-то не заработало. Пишут, что только для английских букв. Поэтому поиск регистрозависимый будет
	// transform(stroka.begin(), stroka.end(), stroka.begin(), tolower);
	// transform(substroka.begin(), substroka.end(), substroka.begin(), tolower);

	// Превращаем строку в массив символов:
	char *str = new char[stroka.length() + 1]; 
	strcpy(str, stroka.c_str());

	// И подстроку тоже:
	char *substr = new char[substroka.length() + 1];
	strcpy(substr, substroka.c_str());

	// Ищем вхождение слова в строку
	char *res = strstr(str, substr);

	if (res != NULL) return true; // Если есть вхождение, возвращаем true
	// Иначе возвращаем false
	return false;
}

