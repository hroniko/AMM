#include <iostream>
#include <cstdlib> // ��� ������ � �������� system()
#include <math.h>	//���������� ����������
#include <iomanip>

using namespace std;

typedef double (*func)(double a);

// �������, ������� ����� ������������ ��� �������� (����� �������� �����)
double myFunction(double x){
    double y = x; // y = 5*x*x*x - 17*x + 21;
    return y;
}

// � ��� ������� ��� ��������� �������� �� ������� �������� �� ��������� a, b ��� ������� f � �������� ��������� e
double mySimpson(double a, double b, func f, double e){
    int n = 7;	//������������� ��������� ���������� a,b �� n ������
    double h = (b - a) / n;	//��������� ��� ��������
    double h1, x1, x2, s, S, I1 = 0, I2, w;	//���������� ����������� ��� ��������
    int k = 1;	//����� ��������� ���������
    double s0 = f(a) + f(b);	//������� ���� ����� ����� �������� ������� �� ������ �������
    do {
        cout << "���������� �������� ���������: " << n << endl;
        x1 = a + h;	//������ ���
        S = 0; // �������� � �������� �������� �����
        for (int i = 1; i < n; i++){
            s = (k + 3) * f(x1);
            k = -k;
            x2 = x1 + h;	// ���� ������ ������ ����� �������� ������� � ����� ��������������
            x1 = x2;
            S += s;
        }

        x1 = 0;
        n = 2 * n;	//��������� ���������� ���������
        h1 = (b - a) / n;	//��������� ����� ���
        I2 = h / 3.0 *(s0 + S);	//������� �������� ��������� �� ����� �������
        w = fabs(I2-I1);	//��������� ������ �������� ������ �������� ��������� � ���� ��� ����
        I1 = I2;
        h = h1;

    } while (w > e);	//���� do �������� ���� �� ����� ���������� ������ ��������
    return I2;
}


// ����������, ���� �������� ���������
int main()
{
    setlocale(LC_ALL, "Russian");
    // �������������� ������:
    double a, b, e;
    cout << "������� ����� � ������ ������ ��������������, a � b: " << endl;
    cin >> a >> b;

    cout << "������� �������� ������� ��������� �� ������� ��������, e (��������, 0.00001): " << endl;
    cin >> e;
    cout << "�������� ��������, ��������� �������� ��������: \n" << endl;
    // �������� � �������, ����������� ������� ��������, ��������� � ������ �� �������� �������, �� ������� ���� ����� ��������:
    double integral = mySimpson(a, b, &myFunction, e);
    cout << "��������� ��������! \n" << endl;
    cout << "�������� �� ������� �����: " << integral << endl;

    system("pause"); // ������� �������� ������
}
