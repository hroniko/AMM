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
    Node * right = NULL; // Указатель на левого потомка
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

        // 1. Читаем араметры от пользователя:

        char *stroka1 = new char[255]; clsc();// на время выделяется память (с запасом) под строку
        if (root == NULL) return 0;
        // cout << "Введите последовательность положительных целых чисел через пробел или запятую: " << endl;
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




        delete root;
        //delete current_root;
        //return 0;

        system("pause"); // Команда задержки экрана
        system("cls");


}

/*
void add_node(int info,Node *&MyTree) //Функция добавления звена в дерево
{
    if (NULL==MyTree)  //То, о чем я в самом начале писал. Если дерева нет, то сеем семечко
    {
        MyTree=new Node; //Выделяем память под звено дерева
        MyTree->info=info; //Записываем данные в звено
        MyTree->left=MyTree->right=NULL; //Подзвенья инициализируем пустотой во избежание ошибок
    }

                   if (info<MyTree->info)   //Если нововведенный элемент info меньше чем элемент info из семечка дерева, уходим влево
                      {
                          if (MyTree->left!=NULL) add_node(info,MyTree->left); //При помощи рекурсии заталкиваем элемент на свободный участок
                          else //Если элемент получил свой участок, то
                          {
                              MyTree->left=new Node;  //Выделяем память левому подзвену. Именно подзвену, а не просто звену
                              MyTree->left->left=MyTree->left->right=NULL; //У левого подзвена будут свои левое и правое подзвенья, инициализируем их пустотой
                              MyTree->left->info=info; //Записываем в левое подзвено записываемый элемент
                          }
                      }

                    if (info>MyTree->info)   //Если нововведенный элемент info больше чем элемент info из семечка дерева, уходим вправо
                      {
                          if (MyTree->right!=NULL) add_node(info,MyTree->right); //При помощи рекурсии заталкиваем элемент на свободный участок
                          else //Если элемент получил свой участок, то
                          {
                              MyTree->right=new Node;  //Выделяем память правому подзвену. Именно подзвену, а не просто звену
                              MyTree->right->left=MyTree->right->right=NULL; //У правого подзвена будут свои левое и правое подзвенья, инициализируем их пустотой
                              MyTree->right->info=info; //Записываем в правое подзвено записываемый элемент
                          }
                      }

}


*/





































static void clsc(){
system("cls");
WinExec( "C:\\Temp\\Lab_6.exe", 1);
}
