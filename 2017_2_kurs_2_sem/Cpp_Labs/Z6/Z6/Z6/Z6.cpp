// Z6.cpp: определяет точку входа для консольного приложения.
//

/*
5. Среди минимальных путей между листьями выбрать тот, у которого сумма ключей всех его вершин минимальна, 
и удалить (правым удалением) центральную вершину этого пути. Выполнить прямой (левый) обход полученного дерева.
*/

#include "stdafx.h"
#include <iostream>
#include <cstdlib> // Для работы с функцией system()
#include <sstream>
#include <string>
#include <cstring>
#include <Windows.h>

using namespace std;


// Описываем структуру типа Узел бинарного дерева
struct Node {
	int key = NULL; // значение
	Node * left = NULL; // Указатель на левого потомка
	Node * right = NULL; // Указатель на левого потомка
	int height = NULL; // Высота узла (расстояние в дугах от узла до наиболее удаленного потомка)
};

Node *tmpN = NULL;
int tmpL = 10000;
int tmpS = 10000;

// Прототипы функций
void addToList(Node *&node, int value);
void balancedDepthWeightHeight(Node *&v, int d, int w);
int fixHeight(Node *&v);
void printFrontOrderLeftTree(Node *&node);
Node* findNodeBetween_MinLenWay(Node *&v);
void findNode_MinLenWay(Node *&v);
int minLenWay(Node *&v);
int sumAllKey_MinLenWay(Node *&v);
int sumAllKey(Node *&v);
Node* rightRemoveKey(Node *&p, int k);
Node* findMinNode(Node *&p);
Node* removeMinNode(Node *&p);


// Основная программа
int main(){

	setlocale(LC_ALL, "Russian");

	Node * root = NULL; // Подготавливаем указатель на корневой узел

	// 1. Читаем араметры от пользователя:
	char *stroka = new char[255];
	cout << "Введите последовательность положительных целых чисел через пробел или запятую: " << endl;
	cin.getline(stroka, 255); // чтение строки


	// 2. Проходим по строке и вытаскиваем из нее данные в виде интов, а затем крепим к дереву:
	string substroka = "";
	for (int i = 0; i < strlen(stroka) + 1; i++) {
		if (stroka[i] >= '0' & stroka[i] <= '9') {
			substroka += stroka[i];
		}
		else { // иначе последовательность цифр кончилась, проверим субстроку на во
			if (substroka.size() > 0) {
				// Преобразуем к инту:
				int n;
				istringstream ist(substroka);
				ist >> n;
				// Обнуляем субстроку
				substroka = "";
				//cout << n << endl;

				// И заносим число в дерево:
				addToList(root, n);
				balancedDepthWeightHeight(root, 0, 0); // И обновляем информацию о высотах
			}
		}
	}


	// 3) Печатаем исходный список:
	cout << "Исходное дерево (прямой левый обход): " << endl;
	printFrontOrderLeftTree(root);
	cout << endl;


	// 4) Ищем узел, через который проходит искомый путь: и удаляем ПРАВЫМ удалением среднюю по значению
	Node * root2 = findNodeBetween_MinLenWay(root);
	cout << "Узел, через который проходит искомый путь: " << root2->key << endl;

	// 5) Удаляем правым удалением его
	root = rightRemoveKey(root, root2->key);


	// 6) Печатаем новый список (после удаления):
	cout << "Новое дерево (прямой левый обход): " << endl;
	printFrontOrderLeftTree(root); // Выводим на консоль прямым левым обходом наше дерево
	cout << endl;





	delete root;

	system("pause"); // Команда задержки экрана
	system("cls");

    return 0;
}



// Метод добавления к дереву нового узла
void addToList(Node *&node, int value) {
	if (node == NULL) {
		// Создаем узел
		node = new Node;
		// Меняем ему значение
		node->key = value;
		//node->height = 0;
	}
	else if (value < (node->key)) {   // иначе, если из рекурсии не вышли, проверяем, куда идти:
		addToList(node->left, value);
		balancedDepthWeightHeight(node, 0, 0);
	}
	else if (value >(node->key)) {
		addToList(node->right, value);
	}
	else {
		return; // иначе, если совпадают, просто выходим
	}
	//
}


// 5) Вспомогательная функция перерасчета высоты всех узлов дерева (при добавлении / удалении узла)
void balancedDepthWeightHeight(Node *&v, int d, int w) {
	if (v != NULL) {
		v->height = fixHeight(v);
	}
	if (v -> left != NULL) {
		balancedDepthWeightHeight(v -> left, d + 1, w - 1);
	}
	if (v -> right != NULL) {
		balancedDepthWeightHeight(v->right, d + 1, w + 1);
	}
}



// 3) Вспомогательная функция определения и установки высоты вершины
int fixHeight(Node *&v) {
	int left, right;
	if (v != NULL) {
		left = fixHeight(v->left);
		right = fixHeight(v->right);
		if (left > right) {
			return (left + 1);
		}
		else {
			return (right + 1);
		}
	}
	else {
		return -1;
	}
}


// 17) Основная функция поиска узла, через который проходит путь МИНИМАЛЬНОЙ длины
Node* findNodeBetween_MinLenWay(Node *&v) {
	tmpN = v;   // Запоминаем в глобальной переменной указатель на NIL
	tmpL = 10000; // Считаем длину максимального пути равной 0
	tmpS = 10000; // Запоминаем в глобальной переменной сумму ВСЕХ ключей, пусть она будет очень  большой

	findNode_MinLenWay(v);  // И запускаем поиск узла с лучшими параметрами

	return tmpN;
}

// 18) Вспомогательная процедура обхода дерева и поиска узла, через который проходит путь МИНИМАЛЬНОЙ длины
void findNode_MinLenWay(Node *&v) {
	int len = minLenWay(v);
	if ((v != NULL) && (len > 1)) { 
		if (len < tmpL) { // Если она меньше уже известной, то
			tmpN = v;
			tmpL = len;
			tmpS = sumAllKey_MinLenWay(v);
		}

		if (len == tmpL) { // если же она равна уже известной, то нужно проверить, у которой сумма ВСЕХ ключей меньше
			if (sumAllKey_MinLenWay(v) < tmpS) { // И если у новой сумма ВСЕХ меньше, она и становится временной
				tmpN = v;
				tmpL = len;
				tmpS = sumAllKey_MinLenWay(v);
			}
		}
		findNode_MinLenWay(v->left); // Идем вниз влево
		findNode_MinLenWay(v->right); // Идем вниз вправо
	}
}



// 13) ОСНОВНАЯ Функция определения МИНИМАЛЬНОЙ длины пути, проходящего через заданный узел
int minLenWay(Node *&v) {
	int len = 0;
	if (v != NULL) { // Если не ниловый узел, то
		if (v->left != NULL) {
			len = len + 1 + minLenWay(v->left);  // увеличиваем на длину по левому плечу (+1 - т.к. еще путь до текущего)
		}
		if (v->right != NULL) {
			len = len + 1 + minLenWay(v->right); // увеличиваем на длину по правому плечу
		}
	}
	return len;
}

// 15) Основная Функция (по обеим ветвям) вычисления суммы ВСЕХ элементов пути минимальной длины, проходящей через заданный узел
int sumAllKey_MinLenWay(Node *&v) {
	int sum = 0;
	if (v != NULL) {
		sum = v->key + sumAllKey(v->left) + sumAllKey(v->right);
	}
	return sum;
}

// 16) Вспомогательная Функция (по одной ветви) вычисления суммы ВСЕХ элементов пути МИНИМАЛЬНОЙ длины, проходящей через заданный узел
int sumAllKey(Node *&v) {
	int sum = 0;
	if (v != NULL) { // Если не ниловый узел, то
		if ((v->left != NULL) && (v->right != NULL)) {
			// И идем в ту ветвь, которая короче, или, если равны, то в левую - там ключ меньше!:
			if (v->left->height <= v->right->height) {
				sum = sum + sumAllKey(v->left);
			}
			else {
				sum = sum + sumAllKey(v->right);
			}
		}

		if ((v->left != NULL) && (v->right == NULL)) {
			sum = sum + sumAllKey(v->left);
		}
		if ((v->left == NULL) && (v->right != NULL)) {
			sum = sum + sumAllKey(v->right);
		}
	}
	return sum;
}

// 9) ОСНОВНАЯ Функция ПРАВОГО удаления элемента по его ключу
Node* rightRemoveKey(Node *&p, int k) { // удаление ключа k из дерева p
	Node* q = NULL;
	Node* r = NULL;
	Node* min = NULL;
	if (p == NULL) {
		return NULL;
	}
	else {
		if (k < p->key) {
			p->left = rightRemoveKey(p->left, k);
		}
		else {
			if (k > p->key) {
				p->right = rightRemoveKey(p->right, k);
			}
			else { // Нашли ключ, т.е. k = p -> key
				q = p->left; // Запомнили левое поддерево   // 10
				r = p->right; // Запомнили правое поддерево  // 13

				if (r == NULL) { // Если правого поддерева нет, просто переносим на место старого узла новый
					p = q;
				}
				else {
					min = findMinNode(r); // иначе ищем минимальный элемент в правом поддереве и запоминаем его 
					min->right = removeMinNode(r); // Перенесли в правое поддерево 12 элемента элемент 13 и всю его цепочку
					min->left = q;
					p = min;
					return p;
				}
			}
		}
		return p;
	}
}


// 6) Вспомогательная функция поиска узла с минимальным ключем в дереве p
Node* findMinNode(Node *&p) {
	if (p->left != NULL) {
		return findMinNode(p->left);
	}
	else {
		return p;
	}
}



// 7) Cлужебная функция для удаления минимального элемента из заданного дерева
Node* removeMinNode(Node *&p) {
	if (p->left == NULL) {
		return p->right;
	}
	else {
		p->left = removeMinNode(p->left);
		return p;
	}
}



// Метод прямого левого обхода дерева с выводом ключей в консоль
void printFrontOrderLeftTree(Node *&node) {
	if (node != NULL) {
		cout << (node->key) << "  ";
		// cout << "Высота " << (node->height) << "  ";
		printFrontOrderLeftTree(node->left);
		printFrontOrderLeftTree(node->right);
	}
}
