#include <iostream>
#include <cstdlib>
#include <ctime>
#include<conio.h>

using namespace std;

// ����� ���������� ������� ���������:
int insertionSort(int* arr, int ssize)
{
    int i, j;
    int tmp; //   ��������� ���������� ��� �������� ��������������� ��������
    // ��������� ���������� �������:
    for (i = 1; i < ssize; i++)
    {
        tmp = arr[i]; // ����������� ������� �������
        arr[0] = tmp; // ������������� �������� �� ������� �������
        j = i; // ���������� �����
        while(tmp < arr[j-1])
        {
            arr[j] = arr[j-1];
            --j; // ��� � ������
        }
        arr[j] = tmp; // �������� ������� ������� �� ���������� �����
    }
    return 0;
}

// ����� ���������� ������ ���������� ����������� ���������
int insertionSortBisection(int* arr, int ssize)
{
    int i, j;
    int M, L, R;
    int tmp; //   ��������� ���������� ��� �������� ��������������� ��������
    // ��������� ���������� �������:
    for (i = 1; i < ssize; i++)
    {
        tmp = arr[i]; // ����������� ������� �������
        L = 1;
        R = i;
        while(L < R){
            M = (L + R) / 2;
            if (arr[M] <= tmp) L = M + 1; // ����������� �������
            else R = M;
        }
        for (j = i; j >= R + 1; j--) arr[j] = arr[j-1]; // ����������� ��� �������� ������
        arr[R] = tmp; // ������������� �� ���������� ����� ������� �������
    }
    return 0;
}

// ����� ������� ���������� � ���������:
int ssort(int* arr, int L, int R)
{
	int i, j;
	int x, w;
	// ��������� ���������� �������:
	i = L; j = R;
	x = arr[(L + R) / 2];
	do{
		while (arr[i] < x) i++;
		while (x < arr[j]) j--;
		if (i <= j){
			w = arr[i]; arr[i] = arr[j]; arr[j] = w; i++; j--;
		}
	} while (i <= j);
	if (L < j) ssort(arr, L, j);
	if (i < R) ssort(arr, i, R);
	return 0;
}
int quickSort(int* arr, int size)
{
    ssort(arr, 1, size-1);
    return 0;
}




// ����� ������� ���������� ��� ��������:
int quickSortNonRecursive(int* arr, int ssize)
{
	int i, j;
	int L, R, s;
	int x, w;
	const int M = 12; // ������ �����
	// ����������� �������� ������ ��� �������� ���� �������� ������� size:
	int *stackLow = new int[M]; // ���� ������ ��������
	int *stackHigh = new int[M]; // ���� ������� ��������

	// ��������� ���������� �������:
	s = 1; // ������� ������� �� �������������, �� ��� �������� � ������ �����������, � ��� ���� �� s = 0;
        stackLow[1] = 1; // � ��������� stackLow[0] = 0; - ������� �� ����������
        stackHigh[1] = ssize - 1; // � ��������� stackHigh[0] = size - 1; - ������� �� ����������
        do { // ����� ������� ������ �� �����
            L = stackLow[s]; R = stackHigh[s]; s = s - 1;
            do { // ��������� ������� arr[L] ... arr[R]
                i = L; j = R;
                x = arr[(L + R) / 2];
                do {
                    while (arr[i] < x) i = i + 1;
                    while (x < arr[j]) j = j - 1;
                    if (i <= j){
                        w = arr[i]; arr[i] = arr[j]; arr[j] = w; i = i + 1; j = j - 1;
                    }
                } while (i < j); // ��������� ���� ��������, � � ����� - �� ��� ���, ���� �� ������ ������� - ��� ���� i > j
                if (i < R){ // ��������� � ����� ����� �� ���������� ������ �����
                    s = s + 1; stackLow[s] = i; stackHigh[s] = R;
                }
                R = j;
            } while (L < R); // ������ L � R ������������ ����� �����
        } while (s > 0); // c while (s >= 0) �� ���������  while (s = -1)
	return 0;
}

// ����� ���������� ������ �������:
int selectionSort(int* arr, int ssize)
{
	int i, j, k;
	int tmp;
	// ��������� ���������� �������:
    for (i = 1; i < ssize - 1; i++){
        k = i;
        tmp = arr[i];
        for(j = i + 1; j < ssize; j++){
            if (arr[j] < tmp){
                k = j;
                tmp = arr[k];
            }
        }
        arr[k] = arr[i];
        arr[i] = tmp;
    }
	return 0;
}

// ����� ���������� ������� ������ (����������� ����������):
int bubbleSort(int* arr, int ssize)
{
    int i, j;
    int tmp;
    // ��������� ���������� �������:
    for (i = 2; i < ssize; i++){
        for (j = ssize - 1; j >= i; j--){
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
            }
        }
    }
	return 0;
}

// ����� ��������� ���������� (�������� �������� � �������� ������, ����������� ����������� ����������):
int shakerSort(int* arr, int ssize)
{
    int k, j, L, R;
    int tmp;

    // ��������� ���������� �������:
    L = 2;
    R = ssize - 1;
    k = ssize - 1;
    do{
        for (j = R; j >= L; j--){ // ������ ������ ������
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
                k = j;
            }
        }
        L = k + 1; // �������� ����� ������� ������
        for (j = L; j <= R; j++){ // ������ ����� �������
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
                k = j; // �������� �������
            }
        }
        R = k - 1; // �������� ������ ������� �����
    } while (L <= R);
	return 0;
}

// ����� ���������� ����� (��������� ���������������� ���������� � ������ ����������):
int shellSort(int* arr, int ssize){
    const int T = 4; // ����� T ���������� ����������
    int i, j, k, m;
    int tmp;
    // ����������� �������� ������ ��� �������� ������� ����������
	int *h = new int[T]; // ������ ���������� ����������

    // ��������� ���������� �������:
    h[0] = 9; h[1] = 5; h[2] = 3; h[3] = 1; // ������ ���������� ���������� � ������ ����������
    for (m = 0; m < T; m++){
        k = h[m];
        for (i = k; i < ssize; i++){ // ?? i = k+1 ��-�� ����, ��� � ��� ������� ������� ������������ � ������ ����������� ��� ��������
            tmp = arr[i]; j = i - k;
            while ( (j >= k) && (tmp < arr[j]) ){
                arr[j+k] = arr[j];
                j = j - k;
            }
            if ( (j >= k) || (tmp >= arr[j]) ){
                arr[j+k] = tmp;
            }
            else {
                arr[j+k] = arr[j];
                arr[j] = tmp;
            }
        }
    }
    return 0;
}

// ----------------------------------------------------------------------------------------
// ��������������� ������:

// ����������� �������:
int* copyA(int* arr1, int ssize)
{
    int *arr2 = new int[ssize];
    for (int i = 0; i < ssize; i++) arr2[i] = arr1[i];
	return arr2;
}

// ������ �������:
int printA(int* arr1, int ssize)
{
    for (int i = 1; i < ssize; i++) cout << arr1[i] << ' '; // ������� ��������������� ������
    cout << endl;
    return 0;
}

int start, endd; // ���������� ��� �������

// ������������ �������:
int* generateA(int ssize)
{
    int *arr1 = new int[ssize]; // ����������� �������� ������ ��� �������� ������� ������� size
    // ��������� ��������� ��������� ����� ��� �������:
    arr1[0] = 0; // ��������
    for (int i = 1; i < ssize; i++)
	{
		arr1[i] = start + rand() % (endd - start + 1);	// start ... end
	}
	return arr1;
}
// -----------------------------------------------------------------------------------------
// �������� ����� ���������:
int main()
{
    setlocale(LC_ALL, "rus");

    cout << "������� ����� ��������� � �������� ��� ������������� (size, start, end, ��������, 10 0 5): " << endl;
    int asize;
    cin >> asize; asize = asize + 1; // ����������� �� 1, ��� ��� � ������� �������� � ��������� ����������� ����� ������� ��������
    cin >> start;
    cin >> endd; cout << endl;
    int *aa = generateA(asize); // ����������� �������� ������ ��� �������� ������� ������� size � ���������� ��� ��������
    // printA(aa, asize); // ������� ��������������� ������

    int t; // ������� ������� ����������

    // 1. ��������� ���������� ������� ���������:
    int * a1 = copyA(aa, asize); // ������ ����� �������
    t = clock(); // ���������� ������
    insertionSort(a1, asize); // ����������
    t = clock() - t; // �, �������, ��������� ������������ ����������
    cout << "������������ ���������� ������� ���������: " << t << " ��" << endl;
    // printA(a1, asize); //������� ��������������� ������
    delete [] a1;

    // 2. ��������� ���������� ������� ��������� c ���������:
    int * a2 = copyA(aa, asize);
    t = clock();
    insertionSortBisection(a2, asize);
    t = clock() - t;
    cout << "������������ ���������� ������� ��������� � ���������: " << t << " ��" << endl;
    // printA(a2, asize);
    delete [] a2;

    // 3. ��������� ������� ���������� � ���������:
    int * a3 = copyA(aa, asize);
    t = clock();
    quickSort(a3, asize);
    t = clock() - t;
    cout << "������������ ������� ���������� � ���������: " << t << " ��" << endl;
    // printA(a3, asize);
    delete [] a3;

    // 4. ��������� ������� ���������� ��� ��������:
    int * a4 = copyA(aa, asize);
    t = clock();
    quickSortNonRecursive(a4, asize);
    t = clock() - t;
    cout << "������������ ������� ���������� ��� ��������: " << t << " ��" << endl;
    // printA(a4, asize);
    delete [] a4;

    // 5. ��������� ���������� ������ �������:
    int * a5 = copyA(aa, asize);
    t = clock();
    selectionSort(a5, asize);
    t = clock() - t;
    cout << "������������ ���������� ������ �������: " << t << " ��" << endl;
    // printA(a5, asize);
    delete [] a5;

    // 6. ��������� ���������� ���������:
    int * a6 = copyA(aa, asize);
    t = clock();
    bubbleSort(a6, asize);
    t = clock() - t;
    cout << "������������ ���������� ���������: " << t << " ��" << endl;
    // printA(a6, asize);
    delete [] a6;

    // 7. ��������� ��������� ����������:
    int * a7 = copyA(aa, asize);
    t = clock();
    shakerSort(a7, asize);
    t = clock() - t;
    cout << "������������ ��������� ����������: " << t << " ��" << endl;
    // printA(a7, asize);
    delete [] a7;

    // 8. ��������� ���������� �����:
    int * a8 = copyA(aa, asize);
    t = clock();
    shellSort(a8, asize);
    t = clock() - t;
    cout << "������������ ���������� �����: " << t << " ��" << endl;
    // printA(a8, asize);
    delete [] a8;

    cout << endl << "��� ������ �� ��������� ������� Enter...";
    char c = getch();
    return 0;
}
