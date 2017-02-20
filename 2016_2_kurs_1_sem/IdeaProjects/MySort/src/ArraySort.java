/**
 * Created by Hroniko on 11.09.2016.
 */
import java.util.Random;

public class ArraySort {
    private int[] arr; // Ссылка на вложенный массив интов
    private int size; // Размер вложенного массива

    // Конструктор обычный
    public ArraySort(int max){
    	arr = new int[max + 1]; // Выделяем место под массив
        arr[0] = 0; // Забиваем заглушку
    	size = 1; // Меняем размер массива
    }

    // Конструктор через генератор случайных чисел:
    public ArraySort(int max, int start, int end){ // Атрибуты: размер, начало и конец диапазона
        size = max + 1;
        arr = new int[size];
        arr[0] = 0; // Забиваем заглушку
        Random random = new Random(System.currentTimeMillis());
        for(int i = 1; i < size; i++){
            arr[i] = random.nextInt(end - start) + start; //arr[i] = start + (int)(random.nextDouble()*(end - start)); // random.nextInt(end) - start; //
        }
    }

    // Конструктор на основе уже существующего массива - простой копировщик (клонер)
    public ArraySort(ArraySort arrOld){
        size = arrOld.getSize(); // Выставляем размер массива
        arr = new int[size]; // Выделяем место под массив
        for(int i = 0; i < size; i++){ // И копируем поэлементно
            arr[i] =  arrOld.arr[i];
        }
    }

    // Метод получения размера массива:
    public int getSize() {
        return size;
    }

    // Метод добавления элемента:
    public void add(int value){
    	arr[size] = value; // Вставляем в конец
    	size++; // Увеличиваем размер
    }

    // Вывод содержимого массива на экран:
    public void display(){
    	for(int i = 1; i < size; i++)
    		System.out.print(arr[i] + "; "); // Выводим на консоль один элемент
    	System.out.println(""); // Переход на новую строку
    }

    // Метод сортировки прямыми вставками:
    public void insertionSort() {
        int i, j;

        // Запускаем сортировку массива:
        for(i = 1; i < size; i++){ // i - разделительный маркер
            int tmp = arr[i]; // Вытаскиваем текущий элемент
            arr[0] = tmp; // Устанавливаем заглушку на нулевой элемент
            j = i; // Запоминаем место

            while (tmp < arr[j-1]){ // Пока не найден меньший элемент
                arr[j] = arr[j-1];
                --j; // Шаг к началу
            }
            arr[j] = tmp; // Помещаем текущий элемент на подходящее место
        }
    }

    // Метод сортировки прямым включением Модификация бисекцией
    public void insertionSortBisection(){
        int i, j;
        int M, L, R;
        int tmp;

        // Запускаем сортировку массива:
        for(i = 1; i < size; i++){
            tmp = arr[i];
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
    }
	
	// Метод быстрой сортировки с рекурсией:
	public void Sort(int L, int R){
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
		if (L < j) Sort(L, j);
		if (i < R) Sort(i, R);
	}
    public void quickSort(){
        Sort(1, size - 1);
    }

    // Метод быстрой сортировки без рекурсии:
    public void quickSortNonRecursive(){
        int i, j;
        int L, R, s;
        int x, w;
        int[] stackLow = new int[size]; // Стек нижних индексов
        int[] stackHigh = new int[size]; // Стек верхних индексов

        // Запускаем сортировку массива:
        s = 1; // Нулевой элемент не рассматриваем, он для заглушки в других сортировках, а так надо бы s = 0;
        stackLow[1] = 1; // В оригинале stackLow[0] = 0; - нулевой не используем
        stackHigh[1] = size - 1; // В оригинале stackHigh[0] = size - 1; - нулевой не используем
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
        } while (s >= 0); // while (s = -1)

    }

    // Метод сортировки прямым выбором:
    public void selectionSort(){
        int i, j, k;
        int tmp;
        // Запускаем сортировку массива:
        for (i = 1; i < size - 1; i++){
            k = i;
            tmp = arr[i];
            for(j = i + 1; j < size; j++){
                if (arr[j] < tmp){
                    k = j;
                    tmp = arr[k];
                }
            }
            arr[k] = arr[i];
            arr[i] = tmp;
        }
    }

    // Метод сортировки прямого обмена (Пузырьковая сортировка):
    public void bubbleSort(){
        int i, j;
        int tmp;
        // Запускаем сортировку массива:
        for (i = 2; i < size; i++){
            for (j = size - 1; j >= i; j--){
                if (arr[j-1] > arr[j]){
                    tmp = arr[j-1];
                    arr[j-1] = arr[j];
                    arr[j] = tmp;
                }
            }
        }
    }

    // Метод шейкерной сортировки (хождение зигзагом с сужением границ, модификация пузырьковой сортировки):
    public void shakerSort(){
        int k, j, L, R;
        int tmp;

        // Запускаем сортировку массива:
        L = 2;
        R = size - 1;
        k = size - 1;
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
                    k = j; 
                }
            }
            R = k - 1; // Сдвигаем правую границу влево
        } while (L <= R);
    }

    // Метод сртировки Шелла (несколько последовательных сортировок с разной дальностью):
    public void shellSort(){
        final int T = 4; // Всего T расстояний сортировки
        int i, j, k, m;
        int tmp;
        int[] h = new int[T]; // Массив расстояний сортировок

        // Заускаем сортировку массива:
        h[0] = 9; h[1] = 5; h[2] = 3; h[3] = 1; // Задаем расстояния сортировки в массив расстояний
        for (m = 0; m < T; m++){
            k = h[m];
            for (i = k; i < size; i++){ // ?? i = k+1 из-за того, что у нас нулевой элемент используется в других сортировках как заглушка
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
    }

}
