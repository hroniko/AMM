#include <iostream>
#include <cstdlib>
#include <ctime>
#include<conio.h>

using namespace std;

// Метод сортировки прямыми вставками:
int insertionSort(int* arr, int ssize)
{
    int i, j;
    int tmp; //   Временная переменная для хранения обрабатываемого элемента
    // Запускаем сортировку массива:
    for (i = 1; i < ssize; i++)
    {
        tmp = arr[i]; // Вытаскиваем текущий элемент
        arr[0] = tmp; // Устанавливаем заглушку на нулевой элемент
        j = i; // Запоминаем место
        while(tmp < arr[j-1])
        {
            arr[j] = arr[j-1];
            --j; // Шаг к началу
        }
        arr[j] = tmp; // Помещаем текущий элемент на подходящее место
    }
    return 0;
}

// Метод сортировки прямым включением Модификация бисекцией
int insertionSortBisection(int* arr, int ssize)
{
    int i, j;
    int M, L, R;
    int tmp; //   Временная переменная для хранения обрабатываемого элемента
    // Запускаем сортировку массива:
    for (i = 1; i < ssize; i++)
    {
        tmp = arr[i]; // Вытаскиваем текущий элемент
        L = 1;
        R = i;
        while(L < R){
            M = (L + R) / 2;
            if (arr[M] <= tmp) L = M + 1; // Передвигаем границы
            else R = M;
        }
        for (j = i; j >= R + 1; j--) arr[j] = arr[j-1]; // Переместить все элементы вправо
        arr[R] = tmp; // Устанавливаем на подходящее место текущий элемент
    }
    return 0;
}

// Метод быстрой сортировки с рекурсией:
int ssort(int* arr, int L, int R)
{
	int i, j;
	int x, w;
	// Запускаем сортировку массива:
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




// Метод быстрой сортировки без рекурсии:
int quickSortNonRecursive(int* arr, int ssize)
{
	int i, j;
	int L, R, s;
	int x, w;
	const int M = 12; // Размер стека
	// Динамически выделяем память под хранение двух массивов размера size:
	int *stackLow = new int[M]; // Стек нижних индексов
	int *stackHigh = new int[M]; // Стек верхних индексов

	// Запускаем сортировку массива:
	s = 1; // Нулевой элемент не рассматриваем, он для заглушки в других сортировках, а так надо бы s = 0;
        stackLow[1] = 1; // В оригинале stackLow[0] = 0; - нулевой не используем
        stackHigh[1] = ssize - 1; // В оригинале stackHigh[0] = size - 1; - нулевой не используем
        do { // Взять верхний запрос со стека
            L = stackLow[s]; R = stackHigh[s]; s = s - 1;
            do { // Разделить сегмент arr[L] ... arr[R]
                i = L; j = R;
                x = arr[(L + R) / 2];
                do {
                    while (arr[i] < x) i = i + 1;
                    while (x < arr[j]) j = j - 1;
                    if (i <= j){
                        w = arr[i]; arr[i] = arr[j]; arr[j] = w; i = i + 1; j = j - 1;
                    }
                } while (i < j); // выполнять пока истинной, а в делфи - до тех пор, пока не станет истинно - там надо i > j
                if (i < R){ // Сохранить в стеке запрс на сортировку правой части
                    s = s + 1; stackLow[s] = i; stackHigh[s] = R;
                }
                R = j;
            } while (L < R); // Теперь L и R ограничивает левую часть
        } while (s > 0); // c while (s >= 0) не заработал  while (s = -1)
	return 0;
}

// Метод сортировки прямым выбором:
int selectionSort(int* arr, int ssize)
{
	int i, j, k;
	int tmp;
	// Запускаем сортировку массива:
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

// Метод сортировки прямого обмена (Пузырьковая сортировка):
int bubbleSort(int* arr, int ssize)
{
    int i, j;
    int tmp;
    // Запускаем сортировку массива:
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

// Метод шейкерной сортировки (хождение зигзагом с сужением границ, модификация пузырьковой сортировки):
int shakerSort(int* arr, int ssize)
{
    int k, j, L, R;
    int tmp;

    // Запускаем сортировку массива:
    L = 2;
    R = ssize - 1;
    k = ssize - 1;
    do{
        for (j = R; j >= L; j--){ // Проход справа налево
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
                k = j;
            }
        }
        L = k + 1; // Сдвигаем левую границу вправо
        for (j = L; j <= R; j++){ // Проход слева направо
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
                k = j; // Сдвигаем границу
            }
        }
        R = k - 1; // Сдвигаем правую границу влево
    } while (L <= R);
	return 0;
}

// Метод сортировки Шелла (несколько последовательных сортировок с разной дальностью):
int shellSort(int* arr, int ssize){
    const int T = 4; // Всего T расстояний сортировки
    int i, j, k, m;
    int tmp;
    // Динамически выделяем память под хранение массива сортировок
	int *h = new int[T]; // Массив расстояний сортировок

    // Запускаем сортировку массива:
    h[0] = 9; h[1] = 5; h[2] = 3; h[3] = 1; // Задаем расстояния сортировки в массив расстояний
    for (m = 0; m < T; m++){
        k = h[m];
        for (i = k; i < ssize; i++){ // ?? i = k+1 из-за того, что у нас нулевой элемент используется в других сортировках как заглушка
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
// Вспомогательные методы:

// Копированиа массива:
int* copyA(int* arr1, int ssize)
{
    int *arr2 = new int[ssize];
    for (int i = 0; i < ssize; i++) arr2[i] = arr1[i];
	return arr2;
}

// Печать массива:
int printA(int* arr1, int ssize)
{
    for (int i = 1; i < ssize; i++) cout << arr1[i] << ' '; // Выводим отсортированный массив
    cout << endl;
    return 0;
}

int start, endd; // Переменные для рандома

// Рандомизация массива:
int* generateA(int ssize)
{
    int *arr1 = new int[ssize]; // Динамически выделяем память под хранение массива размера size
    // Запускаем генерацию случайных чисел для массива:
    arr1[0] = 0; // Заглушка
    for (int i = 1; i < ssize; i++)
	{
		arr1[i] = start + rand() % (endd - start + 1);	// start ... end
	}
	return arr1;
}
// -----------------------------------------------------------------------------------------
// Основная часть программы:
int main()
{
    setlocale(LC_ALL, "rus");

    cout << "Задайте число элементов и диапазон для генерирования (size, start, end, например, 10 0 5): " << endl;
    int asize;
    cin >> asize; asize = asize + 1; // Увеличиваем на 1, так как в нулевом элементе в некоторых сортировках будем хранить заглушку
    cin >> start;
    cin >> endd; cout << endl;
    int *aa = generateA(asize); // Динамически выделяем память под хранение массива размера size и генерируем его элементы
    // printA(aa, asize); // Выводим сгенерированный массив

    int t; // Счетчик времени сортировки

    // 1. Выполняем сортировку прямыми вставками:
    int * a1 = copyA(aa, asize); // Делаем копию массива
    t = clock(); // Запоминаем начало
    insertionSort(a1, asize); // Сортировка
    t = clock() - t; // и, наконец, вычисляем длительность сортировки
    cout << "Длительность сортировки прямыми вставками: " << t << " мс" << endl;
    // printA(a1, asize); //Выводим отсортированный массив
    delete [] a1;

    // 2. Выполняем сортировку прямыми вставками c бисекцией:
    int * a2 = copyA(aa, asize);
    t = clock();
    insertionSortBisection(a2, asize);
    t = clock() - t;
    cout << "Длительность сортировки прямыми вставками с бисекцией: " << t << " мс" << endl;
    // printA(a2, asize);
    delete [] a2;

    // 3. Выполняем быструю сортировку с рекурсией:
    int * a3 = copyA(aa, asize);
    t = clock();
    quickSort(a3, asize);
    t = clock() - t;
    cout << "Длительность быстрой сортировки с рекурсией: " << t << " мс" << endl;
    // printA(a3, asize);
    delete [] a3;

    // 4. Выполняем быструю сортировку без рекурсии:
    int * a4 = copyA(aa, asize);
    t = clock();
    quickSortNonRecursive(a4, asize);
    t = clock() - t;
    cout << "Длительность быстрой сортировки без рекурсии: " << t << " мс" << endl;
    // printA(a4, asize);
    delete [] a4;

    // 5. Выполняем сортировку прямым выбором:
    int * a5 = copyA(aa, asize);
    t = clock();
    selectionSort(a5, asize);
    t = clock() - t;
    cout << "Длительность сортировки прямым выбором: " << t << " мс" << endl;
    // printA(a5, asize);
    delete [] a5;

    // 6. Выполняем сортировку пузырьком:
    int * a6 = copyA(aa, asize);
    t = clock();
    bubbleSort(a6, asize);
    t = clock() - t;
    cout << "Длительность сортировки пузырьком: " << t << " мс" << endl;
    // printA(a6, asize);
    delete [] a6;

    // 7. Выполняем шейкерную сортировку:
    int * a7 = copyA(aa, asize);
    t = clock();
    shakerSort(a7, asize);
    t = clock() - t;
    cout << "Длительность шейкерной сортировки: " << t << " мс" << endl;
    // printA(a7, asize);
    delete [] a7;

    // 8. Выполняем сортировку Шелла:
    int * a8 = copyA(aa, asize);
    t = clock();
    shellSort(a8, asize);
    t = clock() - t;
    cout << "Длительность сортировки Шелла: " << t << " мс" << endl;
    // printA(a8, asize);
    delete [] a8;

    cout << endl << "Для выхода из программы нажмите Enter...";
    char c = getch();
    return 0;
}
