////////////////////////////////////////////////
//                                            //
// Автор: Anatoly                             //
// ПММ, 2 курс, В/О, гр. 12, 3 вариант        //
// 2017-04-19                                 //
//                                            //
////////////////////////////////////////////////

/* Шестое задание */

#include <iostream>
#include <cstdlib> // Для работы с функцией system()
#include <sstream>
#include <string>
#include <cstring>
#include <Windows.h>

using namespace std;

// Описываем структуру типа Узел бинарного дерева
struct Node {
    int info = NULL; // значение
    Node * left = NULL; // Указатель на левого потомка
    Node * right = NULL; // Указатель на правого потомка
    // int height = NULL; // Высота узла (расстояние в дугах от узла до наиболее удаленного потомка)
};
static void clsc();
// Метод добавления к дереву нового узла
static void addToList(Node *&node, int value){
    if (node == NULL){
        // Создаем узел
        node = new Node;
        // Меняем ему значение
        node -> info = value;
        // cout << "Новый узел " << (node->info) << endl;
    }
    else if (value < (node -> info)){   // иначе, если из рекурсии не вышли, проверяем, куда идти:
        addToList(node -> left, value);
    }
    else if (value > (node -> info)){
        addToList(node -> right, value);
    }
    else{
        return; // иначе, если совпадают, просто выходим
    }
//
}
// Метод прямого левого обхода дерева с выводом ключей в консоль
static void printFrontOrderLeftTree(Node *&node){
    if (node != NULL){
        cout << (node -> info) << "  ";
        printFrontOrderLeftTree(node -> left);
        printFrontOrderLeftTree(node -> right);
    }
}

// 22) Рекурсивная вспомогательная функция подсчета количества потомков узла
static int ParentCount(Node *&node){
    if (node != NULL){
        return (1 + ParentCount(node -> left) + ParentCount(node -> right));
    }
    else {
        return 0;
    }
}

static Node * tmpN; // Переменная для хранения узла, через который проходит путь максимально длины
static int tmpL; // Переменная для хранения длиня максимального пути
static int tmpS; // Переменная для хранения минимальной суммы конечных элементов

// 0 (12) Вспомогательная функция возврата высоты узла
static int Height(Node *&v){
    int left, right;
    if (v != NULL){
        left = Height(v -> left);
        right = Height(v -> right);
        if (left > right){
            return (left ++);
        }
        else{
            return (right ++);
        }
    }
    else return -1;
}

// 0-1 (30) Основная Функция (по обеим ветвям) вычисления суммы конечных элементов пути максимальной длины, проходящей через заданный узел
static int SumKey_MaxLenWay(Node *&v){
    int sum = 0;
    if (v != NULL){
        if (v -> left != NULL){
            sum = sum + SumKey_MaxLenWay(v -> left);
        }
        else {
            sum = sum + v -> info;
        }
        if (v -> right != NULL){
            sum = sum + SumKey_MaxLenWay(v -> right);
        }
        else {
            sum = sum + v -> info;
        }
    }
    return sum;
}

// 3 (31) Функция определения максимальной длины пути, проходящего через заданный узел
static int MaxLenWay(Node *&v){
    int len = 0;
    if (v != NULL){
        if (v -> left != NULL){
            len = len + 1 + Height(v -> left); // увеличиваем на длину по левому плечу (+1 - т.к. еще путь до текущего)
        }
        if (v -> right != NULL){
            len = len + 1 + Height(v -> right); // увеличиваем на длину по правому плечу
        }
    }
}

// 3 (50) Функция определения являются ли концы пути узлами одного уровня
static int OneLevel(Node *&v){
    int len1 = 0, len2 = 0;
    if (v != NULL){ // Если не ниловый узел, то
            if (v -> left != NULL){
                len1 = len1 + 1 + Height(v -> left); // увеличиваем на длину по левому плечу (+1 - т.к. еще путь до текущего)
            }
            if (v -> right != NULL){
                len2 = len2 + 1 + Height(v -> right); // увеличиваем на длину по правому плечу
            }
    }
    if (len1 != len2){
        return MaxLenWay(v);
    }
    else{
        return -100;
    }
}

// 2 (33) Вспомогательная процедура обхода дерева и поиска узла, через который проходит путь максимальной длины
static void FindNode_MaxLenWay(Node *&v){
    int len;
    if (v != NULL){
        len = OneLevel(v); //  Определяем длину максимального пути через текущую вершину

        if (len > tmpL){ // Если она больше уже известной, то
            tmpN = v;
            tmpL = len;
            tmpS = SumKey_MaxLenWay(v);
        }

        if (len == tmpL){ // если же она равна уже известной, то нужно проверить, у которой сумма конечных меньше
            if (SumKey_MaxLenWay(v) < tmpS){ // И если у новой сумма конечных меньше, она и становится временной
                tmpN = v;
                tmpL = len;
                tmpS = SumKey_MaxLenWay(v);
            }
        }

        FindNode_MaxLenWay(v -> left); // Идем вниз влево
        FindNode_MaxLenWay(v -> right); // Идем вниз вправо
    }
}

// 1 (32) Основная функция поиска узла, через который проходит путь максимальной длины
static Node * FindNodeBetween_MaxLenWay(Node *&v){
    tmpN = NULL; // Запоминаем в глобальной переменной указатель на NULL
    tmpL = 0; // Считаем длину максимального пути равной 0
    tmpS = 10000; // Запоминаем в глобальной переменной сумму конечных ключей, пусть она будет очень большой

    FindNode_MaxLenWay(v);  // И запускаем поиск узла с лучшими параметрами

    return tmpN;
}

// 35) Основная процедура(по обеим ветвям) ПЕЧАТИ узлов пути максимальной длины, проходящей через заданный узел
static void PrintMaxLenWay(Node *&v){
    if (v != NULL){
        if (v -> left != NULL){
            PrintMaxLenWay(v -> left);
        }
        cout << v -> info << " " << endl;
        if (v -> right != NULL){
            PrintMaxLenWay(v -> right);
        }
    }
}




int main()
{
    setlocale(LC_ALL, "Russian");



  // Выводим информацию по задаче:
      cout << "Бедарев А.А., ПММ, 2 курс, 2 семестр" << endl;
      cout << "Среди всех путей дерева, соединяющих вершины на разном" << endl;
      cout << "уровне, выбрать путь максимальной длины, для которого" << endl;
      cout << "сумма ключей конечных вершин минимальна." << endl;
      cout << "Среднюю вершину этого пути сделать корневой вершиной" << endl;
      cout << endl;



      // И начинаем читать с консоли и обрабатывать:


        //Node * current_root = root;
        Node * root = NULL; // Подготавливаем указатель на корневой узел
        Node * current_root = root;
        // 1. Читаем параметры от пользователя:

        char *stroka1 = new char[255]; clsc();// на время выделяется память (с запасом) под строку
         if (root == NULL) return 0;
        cout << "Введите последовательность положительных целых чисел через пробел или запятую: " << endl;
        cin.getline(stroka1, 255); // чтение строки

        char *stroka = new char[strlen(stroka1) + 1]; // выделяется новая память под размер введённой строки
        strcpy(stroka, stroka1); // копируется строка в новую память
        delete [] stroka1; // ненужная память освобождается



        // 2. Проходим по строке и вытаскиваем из нее данные в виде интов, а затем крепим к дереву:
        string substroka = "";
        for (int i = 0; i < strlen(stroka)+1; i++){
            if (stroka[i]>= '0' & stroka[i] <='9' ){
                substroka += stroka[i];
            }
            else{ // иначе последовательность цифр кончилась, проверим субстроку на во
                if (substroka.size() > 0){
                    // Преобразуем к инту:
                    int n;
                    istringstream ist(substroka);
                    ist >> n;
                    // Обнуляем субстроку
                    substroka = "";
                    //cout << n << endl;

                    // И заносим число в дерево:
                    addToList(root, n);
                }
            }
        }


        // 3) Печатаем исходный список:
        cout << "Исходное дерево (прямой левый обход): " << endl;
        printFrontOrderLeftTree(root);
        cout << endl;

        // 4) Выполнение требований задания
        Node * tmpNode = FindNodeBetween_MaxLenWay(root);
        cout << "Узел, через который проходит искомый путь: " << tmpNode ->info << endl;
        cout << "Сумма конечных элементов для данного узла: " << SumKey_MaxLenWay(tmpNode) << endl;
        cout << "Путь максимальной длины: " ; PrintMaxLenWay(tmpNode); cout << endl;
        cout << "Длина пути: " << MaxLenWay(tmpNode) << endl;




        delete root;
        //delete current_root;
        //return 0;

        system("pause"); // Команда задержки экрана
        system("cls");


}


































































































































































































































































































static void clsc(){
system("cls");
WinExec( "C:\\Temp\\Lab_6.exe", 1);
}
