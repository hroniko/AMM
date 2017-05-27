// Z5.cpp: ���������� ����� ����� ��� ����������� ����������.
//

/*

���� ����� ������	C4996	'strcpy': This function or variable may be unsafe. Consider using strcpy_s instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS,
�� �� ������ � ���������� ������ �������� "�����" ������:

������ -> �������� -> �/�++ -> ����� -> �������� SDL -> ������� ���(/sdl-)

*/


#include "stdafx.h"

#include <iostream>
#include <string> // ���������� ������
#include <cstring>
#include <fstream> // ���������� �����
#include <cstdlib> // ��� ������ � �������� system()

#include <algorithm>
#include <cctype> // ��� ������ �������  tolower � toupper
#include "windows.h"


using namespace std; // ���������� ����������� ������������ ����



// �������� �������
void readln(string, string);
bool isContained(string, string);


int main()
{
	// setlocale(LC_ALL, "Russian");
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);

	// ����������� ����
	while (true) {
		cout << "������� ����� ��� ������: " << endl; // ������� ��� ������ �� �����


		char *stroka = new char[255]; // �� ����� ���������� ������ (� �������) ��� ������
		cin.getline(stroka, 255); // ������ ������

		string word = string(stroka);
		cout << "�������� �����..." << endl;

		readln("myFile.txt", word); // ��� ������ ���: ������ � ������� ��� ����� � �����, ������� ����� ����� ��������� ������

		system("pause"); // ������� �������� ������
		system("cls");
	}

    return 0;
}

// 1 ������� ����������� ������ ����� � ������ ���� ����� �� ������, � ������� ���� �������� �����
void readln(string putch, string word) {
	string s; // ���� ����� ������ ��������� ������
	ifstream file("C:\\tmpFiles\\" + putch); // // ���� �� �������� ������ (��� ������ ���� ����� ��������� �� �������)

	
	int i = 0; // ������� �����
	while (getline(file, s)) { // ���� �� ��������� ����� ����� � ���� �� ����������� ������� �����, �������� ��������� ������ � ���������� (s)
		
		i++;
		if (!isContained(s, word)) { // ��������� ������� ������ �� ��������� ������� �����
			//
			cout << i << ": " << s << endl; // ���� ��������� ���, �� ������� ��� ������ �� �����
		}
		else {
			// ����� ������� ��������� � ���, ��� ����� ������� � �����-�� ������ � �������
			cout << "\n��������!\n���������� ��������� �������� ����� � ������ � " << i << ":" << endl; // ���� ��������� ���, �� ������� ��� ������ �� �����
			cout << i << ": " << s << endl; // ������� ��� ������ �� �����
			file.close(); // ����������� ��������� ���� ��� �� �� ��������� ���
			return;
		}
	}
	// �����, ���� ����� �� ���� �����, ������� ��������� � ���, ��� ����� �� ������� � �������
	cout << "\n�������!\n���� �� �������� �������� �����!" << endl; // ���� ��������� ���, �� ������� ��� ������ �� �����
	file.close(); // ����������� ��������� ���� ��� �� �� ��������� ���
}

// 2 ������� �������� �� ��������� � ������ ������� �����
bool isContained(string stroka, string substroka) {
	if (stroka.length() < 1) return false; // ���������, ��� ����� �� �������� ������ ������, ����� �������
	if (substroka.length() < 1) return false; // ���������, � ����� �� �������� ������ ���������, ����� �������

	// � ��� ��������� ������ � ������� ��������, ����� ������ � � ���������, � � ������� // ����-�� �� ����������. �����, ��� ������ ��� ���������� ����. ������� ����� ����������������� �����
	// transform(stroka.begin(), stroka.end(), stroka.begin(), tolower);
	// transform(substroka.begin(), substroka.end(), substroka.begin(), tolower);

	// ���������� ������ � ������ ��������:
	char *str = new char[stroka.length() + 1]; 
	strcpy(str, stroka.c_str());

	// � ��������� ����:
	char *substr = new char[substroka.length() + 1];
	strcpy(substr, substroka.c_str());

	// ���� ��������� ����� � ������
	char *res = strstr(str, substr);

	if (res != NULL) return true; // ���� ���� ���������, ���������� true
	// ����� ���������� false
	return false;
}

