////////////////////////////////////////////////
//                                            //
// Автор: Anatoly                             //
// ПММ, 2 курс, В/О, гр. 12, 3 вариант        //
// 2017-04-04                                 //
//                                            //
////////////////////////////////////////////////

/* Пятое задание */

#include <iostream>
#include <cstdlib> // Для работы с функцией system()
#include <sstream>
#include <string>
#include <cstring>

using namespace std;



// Описываем структуру типа Узел односвязного списка
struct Node {
    int info = 0; // значение
    Node * next = NULL; // Указатель на следующий узел
};

static void printList(Node * root){
    // cout << "Печать списка слева направо от корня: " << endl;
    while (root-> next != NULL){
            cout << root -> info << "  ";
            root = root -> next;
    }
    cout << endl;
}

static int count7(Node * root){
    // cout << "Печать списка слева направо от корня: " << endl;
    int sum = 0;
    while (root-> next != NULL){
            if (root -> info > 7){
                sum ++;
            }
            root = root -> next;
    }
    return sum;
}

int main()
{
    setlocale(LC_ALL, "Russian");
    // Подготавливаем данные:


    // И начинаем читать с консоли и обрабатывать:

    while(true){

        Node * root = new Node; // Подготавливаем указатель на корневой узел
        Node * current_root = root;

        // 1. Читаем араметры от пользователя:

        char *stroka1 = new char[255]; // на время выделяется память (с запасом) под строку
        cout << "Введите последовательность положительных целых чисел через пробел или зяпятую: " << endl;
        cin.getline(stroka1, 255); // чтение строки

        char *stroka = new char[strlen(stroka1) + 1]; // выделяется новая память под размер введённой строки
        strcpy(stroka, stroka1); // копируется строка в новую память
        delete [] stroka1; // ненужная память освобождается



        // 2. Проходим по строке и вытаскиваем из нее данные в виде интов, а затем крепим к листу:
        int list_count = 0;
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
                    // cout << n << endl;

                    // И заносим число в список:
                    if (list_count == 0){
                        current_root -> info = n;
                        current_root -> next = new Node;
                    }
                    else {
                        // Создаем новый узел в качестве потомка текущего узла:
                        current_root = current_root -> next;
                        // И переносим значение:
                        current_root -> info = n;
                        current_root -> next = new Node;
                        // Перекидываем указатель на него:

                    }
                    list_count ++;
                }
            }
        }


        // 3) Печатаем исходный список:
        cout << "Исходный список: " << endl;
        printList(root);

        //cout << root ->info << endl;
        //cout << root ->next ->info  << endl;
        //cout << list_count << endl;

        // 4) Обходим и вставляем нули
        Node * current_root0 = root;
        while (current_root0 -> next != NULL){
                if((current_root0 -> next -> info > 1) & (current_root0 -> next -> info < 8)){
                        Node * tmp = new Node;
                        tmp -> info = 0;
                        (tmp -> next) = (current_root0 -> next);
                        current_root0 -> next = tmp;
                        //cout << "!" << endl; // де-то тут циклится
                        current_root0 = tmp -> next;

                }
                else{
                    current_root0 = current_root0 -> next;
                }
        }
        // А еще проверяем корень:
        if((root -> info > 1) & (root -> info < 8)){
            Node * tmp = new Node;
            tmp -> info = 0;
            tmp -> next = root;
            root = tmp;
        }


        // 5) Печатаем исходный список:
        cout << "Список после вставки нулей перед узлами со значением от 2 до 7 включительно: " << endl;
        printList(root);

        // 6) Считаем сумму чисел больше 7:
        cout << "Сумма чисел больше семи: " << count7(root) << endl;
        cout << endl;


        delete root;
        delete current_root;
        //return 0;

        system("pause"); // Команда задержки экрана
        system("cls");
    }

}
