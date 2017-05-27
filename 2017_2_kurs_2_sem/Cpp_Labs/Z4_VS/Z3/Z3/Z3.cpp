// Z3.cpp: определяет точку входа для консольного приложения.
//
#include "stdafx.h"
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


int main()
{
    setlocale(LC_ALL, "Russian");
    // Подготавливаем данные:


    // И начинаем читать с консоли и обрабатывать:

    while(true){

        Node * root = new Node; // Подготавливаем указатель на корневой узел
        Node * current_root = root;

        // 1. Читаем араметры от пользователя:

        char *stroka = new char[255]; // на время выделяется память (с запасом) под строку
        cout << "Введите последовательность положительных целых чисел через пробел или зяпятую: " << endl;
        cin.getline(stroka, 255); // чтение строки



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


        // 4) Обходим и удаляем первый элемент, больший числа 4

        // Сначала проверяем корень:
        if(root -> info > 4){
            root = root -> next;
        }
        else{
            // Иначе проверяем все остальные узлы

            Node * current_root0 = root;
            while (current_root0 -> next != NULL){
                    if((current_root0 -> next -> info) > 4){
                            current_root0 -> next = current_root0 -> next -> next;
                            break;

                    }
                    else{
                        current_root0 = current_root0 -> next;
                    }
            }
        }

        // 5) Печатаем список после удаления:
        cout << "Список после удаления первого встретившегося элемента больше 4: " << endl;
        printList(root);


        // 6) Обходим и вставляем десятки
        Node * current_root0 = root;
        while (current_root0 -> next != NULL){
                if(current_root0 -> next -> info == 15){
                        Node * tmp = new Node;
                        tmp -> info = 10;
                        (tmp -> next) = (current_root0 -> next);
                        current_root0 -> next = tmp;
                        current_root0 = tmp -> next;

                }
                else{
                    current_root0 = current_root0 -> next;
                }
        }
        // А еще проверяем корень:
        if(root -> info == 15){
            Node * tmp = new Node;
            tmp -> info = 10;
            tmp -> next = root;
            root = tmp;
        }


        // 7) Печатаем список после вставки:
        cout << "Список после вставки десяток перед элементами равными 15: " << endl;
        printList(root);

        cout << endl;


        delete root;
        delete current_root;
        //return 0;

        system("pause"); // Команда задержки экрана
        system("cls");
    }

}

