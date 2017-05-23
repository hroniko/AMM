// Z3.cpp: определяет точку входа для консольного приложения.
//
#include "stdafx.h"
#include <iostream>
#include <cstdlib> // Для работы с функцией system()
#include <sstream>
#include <string>
#include <cstring>

using namespace std;

// Метод конвнртирования в строку
template <typename T>
std::string toString(T val)
{
	std::ostringstream oss;
	oss << val;
	return oss.str();
}


// Метод конвертирования из даты одного формата в другой
static string convert(char *&stroka) {

	// 1. Подготавливаем массив
	int *massiv = new int[3]; // Создаем массив под три инта
							  // 2. Проходим по строке и вытаскиваем из нее данные в виде интов, а затем аноим в массив
	int list_count = 0;
	int position = -1;
	string substroka = "";
	for (int i = 0; i < strlen(stroka) + 1; i++) {
		if (stroka[i] >= '0' & stroka[i] <= '9') {
			substroka += stroka[i];
		}
		else { // иначе последовательность цифр кончилась, проверим субстроку на возможность преобразовать в число
			// но сначала проверим, а вдруг у нас использовано отрицательное число
			if (stroka[i] == '-') return "Числа не могут быть отрицательными! Пожалуйста, повторите ввод";
			if (substroka.size() > 0) {
				// Преобразуем к инту:
				int n;
				istringstream ist(substroka);
				ist >> n;
				position++;
				// Обнуляем субстроку
				substroka = "";
				// cout << n << endl;

				// И заносим число в массив:
				if (position < 3) {
					massiv[position] = n;
				}
				else {
					break;
				}
				list_count++;
			}
		}
	}

	// 2+) Проверки на числа:
	if ( (massiv[1] < 1) || (massiv[1] > 31) ) return "Неверно задан день месяца: " + toString(massiv[1]) + ". Повторите ввод";
	if ((massiv[2] < 0) || (massiv[2] > 99)) return "Неверно задан год: " + toString(massiv[2]) + ". Повторите ввод";


	// 3) Вычисляем, какой нам нужен месяц:
	string sub1 = "";
	switch (massiv[0])
	{
	case 1:
		sub1 = "Январь";
		break;
	case 2:
		sub1 = "Февраль";
		break;
	case 3:
		sub1 = "Март";
		break;
	case 4:
		sub1 = "Апрель";
		break;
	case 5:
		sub1 = "Май";
		break;
	case 6:
		sub1 = "Июнь";
		break;
	case 7:
		sub1 = "Июль";
		break;
	case 8:
		sub1 = "Август";
		break;
	case 9:
		sub1 = "Сентябрь";
		break;
	case 10:
		sub1 = "Октябрь";
		break;
	case 11:
		sub1 = "Ноябрь";
		break;
	case 12:
		sub1 = "Декабрь";
		break;
	default:
		return "Неверно задан номер месяца: " + toString(massiv[0]) + ". Повторите ввод";
	}

	
	return (sub1 + " " + toString(massiv[1]) + ", 19" + ( (massiv[2] > 9) ? toString(massiv[2]) : "0" + toString(massiv[2])) );
}


// Основная программа
int main()
{
	setlocale(LC_ALL, "Russian");
	// Подготавливаем данные:


	// И начинаем читать с консоли и обрабатывать:

	while (true) {



		// 1. Читаем араметры от пользователя:

		char *stroka1 = new char[255]; // на время выделяется память (с запасом) под строку
		cout << "Введите дату в формате мм/дд/гг: " << endl;
		cin.getline(stroka1, 255); // чтение строки

		char *stroka = new char[strlen(stroka1) + 1]; // выделяется новая память под размер введённой строки

		// 2. Конвертируем
		string stroka2 = convert(stroka1);


		// 3) Выводим результа:
		cout << "Результат: " << stroka2 << endl;
		cout << endl;

		delete[] stroka1; // ненужная память освобождается
		system("pause"); // Команда задержки экрана
		system("cls");
	}

}
