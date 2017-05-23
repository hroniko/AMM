// Z3.cpp: ���������� ����� ����� ��� ����������� ����������.
//
#include "stdafx.h"
#include <iostream>
#include <cstdlib> // ��� ������ � �������� system()
#include <sstream>
#include <string>
#include <cstring>

using namespace std;

// ����� ��������������� � ������
template <typename T>
std::string toString(T val)
{
	std::ostringstream oss;
	oss << val;
	return oss.str();
}


// ����� ��������������� �� ���� ������ ������� � ������
static string convert(char *&stroka) {

	// 1. �������������� ������
	int *massiv = new int[3]; // ������� ������ ��� ��� ����
							  // 2. �������� �� ������ � ����������� �� ��� ������ � ���� �����, � ����� ����� � ������
	int list_count = 0;
	int position = -1;
	string substroka = "";
	for (int i = 0; i < strlen(stroka) + 1; i++) {
		if (stroka[i] >= '0' & stroka[i] <= '9') {
			substroka += stroka[i];
		}
		else { // ����� ������������������ ���� ���������, �������� ��������� �� ����������� ������������� � �����
			// �� ������� ��������, � ����� � ��� ������������ ������������� �����
			if (stroka[i] == '-') return "����� �� ����� ���� ��������������! ����������, ��������� ����";
			if (substroka.size() > 0) {
				// ����������� � ����:
				int n;
				istringstream ist(substroka);
				ist >> n;
				position++;
				// �������� ���������
				substroka = "";
				// cout << n << endl;

				// � ������� ����� � ������:
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

	// 2+) �������� �� �����:
	if ( (massiv[1] < 1) || (massiv[1] > 31) ) return "������� ����� ���� ������: " + toString(massiv[1]) + ". ��������� ����";
	if ((massiv[2] < 0) || (massiv[2] > 99)) return "������� ����� ���: " + toString(massiv[2]) + ". ��������� ����";


	// 3) ���������, ����� ��� ����� �����:
	string sub1 = "";
	switch (massiv[0])
	{
	case 1:
		sub1 = "������";
		break;
	case 2:
		sub1 = "�������";
		break;
	case 3:
		sub1 = "����";
		break;
	case 4:
		sub1 = "������";
		break;
	case 5:
		sub1 = "���";
		break;
	case 6:
		sub1 = "����";
		break;
	case 7:
		sub1 = "����";
		break;
	case 8:
		sub1 = "������";
		break;
	case 9:
		sub1 = "��������";
		break;
	case 10:
		sub1 = "�������";
		break;
	case 11:
		sub1 = "������";
		break;
	case 12:
		sub1 = "�������";
		break;
	default:
		return "������� ����� ����� ������: " + toString(massiv[0]) + ". ��������� ����";
	}

	
	return (sub1 + " " + toString(massiv[1]) + ", 19" + ( (massiv[2] > 9) ? toString(massiv[2]) : "0" + toString(massiv[2])) );
}


// �������� ���������
int main()
{
	setlocale(LC_ALL, "Russian");
	// �������������� ������:


	// � �������� ������ � ������� � ������������:

	while (true) {



		// 1. ������ �������� �� ������������:

		char *stroka1 = new char[255]; // �� ����� ���������� ������ (� �������) ��� ������
		cout << "������� ���� � ������� ��/��/��: " << endl;
		cin.getline(stroka1, 255); // ������ ������

		char *stroka = new char[strlen(stroka1) + 1]; // ���������� ����� ������ ��� ������ �������� ������

		// 2. ������������
		string stroka2 = convert(stroka1);


		// 3) ������� ��������:
		cout << "���������: " << stroka2 << endl;
		cout << endl;

		delete[] stroka1; // �������� ������ �������������
		system("pause"); // ������� �������� ������
		system("cls");
	}

}
