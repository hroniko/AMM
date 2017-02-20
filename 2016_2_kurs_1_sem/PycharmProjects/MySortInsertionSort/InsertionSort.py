import random as rn
import time
import copy


# Метод сортировки прямыми вставками:
def insertionSort(arr):
    size = len(arr)
    # Запускаем сортировку промежуточного массива:
    for i in range(1, size):  # i - разделительный маркер
        tmp = arr[i]  # Вытаскиваем текущий элемент
        arr[0] = tmp  # Устанавливаем заглушку на нулевой элемент
        j = i  # Запоминаем место
        while (tmp < arr[j - 1]):  # Пока не найден меньший элемент
            arr[j] = arr[j - 1]
            j = j - 1  # Шаг к началу
        arr[j] = tmp  # Помещаем текущий элемент на подходящее место
    arr[0] = "Заглушка"  # Для порядкУ))
    return arr


# Метод сортировки прямым включением Модификация бисекцией:
def insertionSortBisection(arr):
    size = len(arr)
    # Запускаем сортировку массива:
    for i in range(1, size):  # i - разделительный маркер
        tmp = arr[i]  # Вытаскиваем текущий элемент
        L = 1
        R = i
        while (L < R):
            M = (L + R) // 2
            if (arr[M] <= tmp):
                L = M + 1
            else:
                R = M
        # j = i
        for j in range(i, R, -1):  # от i до R ВКЛЮЧИТЕЛЬНО!
            arr[j] = arr[j - 1]
        arr[R] = tmp  # Помещаем текущий элемент на подходящее место
    return arr


# Метод быстрой сортировки с рекурсией:
def sort(arr, L, R):
    # Запускаем сортировку массива:
    i = L
    j = R
    x = arr[(L + R) // 2]
    while True:  # Бесконечный цикл, аналог repeat ... until в паскале
        while (arr[i] < x):
            i = i + 1
        while (x < arr[j]):
            j = j - 1
        if (i <= j):
            w = arr[i]
            arr[i] = arr[j]
            arr[j] = w
            i = i + 1
            j = j - 1
        if (i > j):  # Выход из бесконечного цикла по условию
            break
    if (L < j):
        sort(arr, L, j)
    if (i < R):
        sort(arr, i, R)
    return arr


# Начальная процедура для быстрой сортировки с рекурсией, инициирует рекурсию Sort
def quickSort(arr):
    size = len(arr)
    # Запускаем сортировку массива:
    return sort(arr, 1, size - 1)


# Метод быстрой сортировки без рекурсии:
def quickSortNonRecursive(arr):
    size = len(arr)
    stackLow = [0] * size  # Стек нижних индексов, используем оператор повторения списков
    stackHigh = [0] * size  # Стек верхних индексов

    # Запускаем сортировку массива:
    s = 1;  # Нулевой элемент не рассматриваем, он для заглушки в других сортировках, а так надо бы s = 0;
    stackLow[1] = 1;  # В оригинале stackLow[0] = 0; - нулевой не используем
    stackHigh[1] = size - 1;  # В оригинале stackHigh[0] = size - 1; - нулевой не используем
    while True:  # Запускаем бесконечный цикл
        # Взять верхний запрос со стека
        L = stackLow[s]
        R = stackHigh[s]
        s = s - 1
        while True:  # Запускаем второй бесконейный цикл
            # Разделить сегмент arr[L] ... arr[R]
            i = L
            j = R
            x = arr[(L + R) // 2]
            while True:  # Запускаем третий вложенный цикл
                while (arr[i] < x):
                    i = i + 1
                while (x < arr[j]):
                    j = j - 1
                if (i <= j):
                    w = arr[i]
                    arr[i] = arr[j]
                    arr[j] = w
                    i = i + 1
                    j = j - 1
                if (i > j):  # Выход из третьего бесконечного цикла
                    break
            if (i < R):  # Сохранить в стеке запрс на сортировку правой части
                s = s + 1
                stackLow[s] = i
                stackHigh[s] = R
            R = j
            if (L >= R):  # Выход из второго бесконечного цикла
                break  # Теперь L и R ограничивает левую
        if (s < 0):  # Выход из внешнего бесконечного цикла # while (s = -1)
            break
    return arr


# Метод сортировки прямым выбором:
def selectionSort(arr):
    size = len(arr)
    # Запускаем сортировку массива:
    for i in range(1, size - 1):
        k = i
        tmp = arr[i]
        for j in range(i + 1, size):
            if (arr[j] < tmp):
                k = j
                tmp = arr[k]
        arr[k] = arr[i]
        arr[i] = tmp
    return arr


# Метод сортировки пузырьком(прямого обмена):
def bubbleSort(arr):
    size = len(arr)
    # Запускаем сортировку массива:
    for i in range(1, size - 1, +1): # по Вирту от 2го элемента вроде, но так не пошло
        for j in range(size - 1, i, -1):
            if (arr[j - 1] > arr[j]):
                tmp = arr[j - 1]
                arr[j - 1] = arr[j]
                arr[j] = tmp
    return arr


# Метод шейкерной сортировки (хождение зигзагом с сужением границ, модификация пузырьковой сортировки):
def shakerSort(arr):
    arr = arr[1:]
    size = len(arr)
    # Запускаем сортировку массива:
    L = 1
    R = size-1
    k = R
    while True:  # Запускаем внешний бесконечный цикл
        for j in range(R, L - 1 , -1):  # Проход справа налево L-1
            if (arr[j - 1] > arr[j]):
                tmp = arr[j - 1]
                arr[j - 1] = arr[j]
                arr[j] = tmp
                k = j
        L = k  + 1 # L = k + 1 не нужно делать  # Сдвигаем левую границу вправо
        for j in range(L, R + 1):  # Проход слева направо
            if (arr[j - 1] > arr[j]):
                tmp = arr[j - 1]
                arr[j - 1] = arr[j]
                arr[j] = tmp
                k = j
        R = k - 1 # R = k - 1 не нужно делать # Сдвигаем правую границу влево
        if (L > R):  # Выходим из внешнего бесконечного цикла
            break
    return arr


# Метод сортировки Шелла (несколько последовательных сортировок с разной дальностью):
def shellSort(arr):
    arr= arr[1:]
    size = len(arr)
    T = 4;  # Всего T расстояний сортировки
    h = [9, 5, 3, 1]  # Массив расстояний сортировок
    # Запускаем сортировку массива:
    for m in range(0, T ):
        k = h[m]
        for i in range(k, size ):
            tmp = arr[i]
            j = i - k
            while ((j >= k) and (tmp < arr[j])):
                arr[j + k] = arr[j]
                j = j - k

            if not ((j < k) and (tmp < arr[j])):
                arr[j + k] = tmp
            else:
                arr[j + k] = arr[j]
                arr[j] = tmp
    return arr


# Сама программа ------------------------------------------------------------
def main():
    print("Задайте число элементов и диапазон (size, start, end, например, 10 0 5):")
    size, start, end = map(int, input().split())  # Читаем параметры для генерации
    # ar = [5, 2, 4, 6, 1, 3]
    size = size + 1
    ar = [rn.randint(start, end) for i in range(size)]  # Генерируем массив
    ar[0] = "Заглушка"
    print(ar)  # Выводим на экран

    ar = ['Заглушка', 6, 8, 6, 2, 3, 9, 9, 6, 2, 5]

    # 1. Запускаем сортировку прямыми вставками:
    ar1 = copy.deepcopy(ar)  # Делаем копию массива
    t = time.time()
    insertionSort(ar1)  # Непосредственная сортировка
    t = (time.time() - t) * 1000
    print("Длительность сортировки прямыми вставками: {:.0f} мс".format(
        t))  # {:.3f} мс".format(t)) # три знакка после точки
    print(ar1)  # Выводим на экран

    # 2. Запускаем сортировку прямыми вставками с бисекцией:
    ar1 = copy.deepcopy(ar)
    t = time.time()
    insertionSortBisection(ar1)
    t = (time.time() - t) * 1000
    print("Длительность сортировки прямыми вставками с бисекцией: {:.0f} мс".format(t))
    print(ar1)

    # 3. Запускаем быструю сортировку с рекурсией:
    ar1 = copy.deepcopy(ar)
    t = time.time()
    quickSort(ar1)
    t = (time.time() - t) * 1000
    print("Длительность быстрой сортировки с рекурсией: {:.0f} мс".format(t))
    print(ar1)

    # 4. Запускаем быструю сортировку без рекурсии:
    ar1 = copy.deepcopy(ar)
    t = time.time()
    quickSortNonRecursive(ar1)
    t = (time.time() - t) * 1000
    print("Длительность быстрой сортировки без рекурсии: {:.0f} мс".format(t))
    print(ar1)

    # 5. Запускаем сортировку прямым выбором:
    ar1 = copy.deepcopy(ar)
    t = time.time()
    selectionSort(ar1)
    t = (time.time() - t) * 1000
    print("Длительность сортировки прямым выбором: {:.0f} мс".format(t))
    print(ar1)

    # 6. Запускаем сортировку пузырьком:
    ar1 = copy.deepcopy(ar)
    t = time.time()
    bubbleSort(ar1)
    t = (time.time() - t) * 1000
    print("Длительность сортировки пузырьком: {:.0f} мс".format(t))
    print(ar1)

    # 7. Запускаем шейкерную сортировку:
    ar1 = copy.deepcopy(ar)
    t = time.time()
    ar1 = shakerSort(ar1)
    t = (time.time() - t) * 1000
    print("Длительность шейкерной сортировки: {:.0f} мс".format(t))
    print(ar1)

    # 8. Зарускаем сортировку Шелла:
    ar1 = copy.deepcopy(ar)
    t = time.time()
    ar1 = shellSort(ar1)
    t = (time.time() - t) * 1000
    print("Длительность сортировки Шелла: {:.0f} мс".format(t))
    print(ar1)

    return 0


# Окончание основной программы

# Метод (точка) входа
if __name__ == "__main__":
    main()
