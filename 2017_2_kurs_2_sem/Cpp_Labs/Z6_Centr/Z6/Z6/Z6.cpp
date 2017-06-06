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
	int l_height = NULL; // Короткая высота слева - расстояние до ближайшего узла слева (измеряется в дугах)
	int r_height = NULL; // Короткая высота слева - расстояние до ближайшего узла слева (измеряется в дугах)
	int l_sum = NULL; // Сумма ключей узлов по минимальному пути слева
	int r_sum = NULL; // Сумма ключей узлов по минимальному пути справа
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
int balancedRLHeight(Node *&v);
int balancedSum(Node *&v);
void printMinWay(Node *&node);
void printMinWay2(Node *&node);
Node* findMediane(Node *&p, int len);
Node* findMediane2(Node *&p, int len);
void printTree(Node *&node, int h);

// Основная программа
int main() {

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

	balancedRLHeight(root); // И обновляем информацию о высотах 
	balancedSum(root); // И обновляем информацию о суммах


	// 3) Печатаем исходный список:
	cout << "Исходное дерево (прямой левый обход): " << endl;
	printFrontOrderLeftTree(root); // Выводим на консоль прямым левым обходом наше дерево
	cout << endl;
	cout << endl;
	// И исходное дерево
	printTree(root, 0);
	cout << endl;


	// 4) Ищем узел, через который проходит искомый путь: и удаляем ПРАВЫМ удалением среднюю по значению
	Node * root2 = findNodeBetween_MinLenWay(root);
	cout << "Узел, через который проходит искомый путь: " << root2->key << endl;

	// 5) Печатаем минимальный путь:
	cout << "Минимальный путь: " << endl;
	printMinWay(root2);
	cout << endl;
/*
	// 6) Проверяем, можно ли удалять вершину из пути (можно, еслм вершин нечетное количество, в этом случае есть медиана)
	int len = root2->l_height + root2->r_height; // Определяем длину пути
	cout << "Длина минимального пути: " << len << " дуг (" << len + 1 << " вершин)" << endl;
	if ((len + 1) % 2 == 0) {
		cout << "Четное количество вершин, медианы нет, удалять нечего" << endl;
	}
	else {
		// Иначе ищем и удаляем медиану		
		root2 = findMediane(root2, len);
		cout << "Удаляем медиану " << root2->key << " правым удалением" << endl;

		// 7) Удаляем правым удалением
		root = rightRemoveKey(root, root2->key);
		balancedDepthWeightHeight(root, 0, 0); // И обновляем информацию о высотах
		balancedRLHeight(root); // И обновляем информацию о высотах 
		balancedSum(root); // И обновляем информацию о суммах


		// 8) Печатаем новый список (после удаления):
		cout << "Новое дерево (прямой левый обход): " << endl;
		printFrontOrderLeftTree(root); // Выводим на консоль прямым левым обходом наше дерево
		cout << endl;
		cout << endl;
		// И новое дерево
		printTree(root, 0);
		cout << endl;
	}

*/
	cout << "Удаляем среднюю корневую вершину пути " << root2->key << " правым удалением" << endl;

	// 7) Удаляем правым удалением
	root = rightRemoveKey(root, root2->key);
	balancedDepthWeightHeight(root, 0, 0); // И обновляем информацию о высотах
	balancedRLHeight(root); // И обновляем информацию о высотах 
	balancedSum(root); // И обновляем информацию о суммах


	// 8) Печатаем новый список (после удаления):
	cout << "Новое дерево (прямой левый обход): " << endl;
	printFrontOrderLeftTree(root); // Выводим на консоль прямым левым обходом наше дерево
	cout << endl;
	cout << endl;
	// И новое дерево
	printTree(root, 0);
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
	if (v->left != NULL) {
		balancedDepthWeightHeight(v->left, d + 1, w - 1);
	}
	if (v->right != NULL) {
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

// !!! Основная функция пересчета минимальных расстояний до листьев слева и справа от узла
int balancedRLHeight(Node *&v) {
	if (v == NULL) return 0; // Если узла нет, возвращаем ноль
							 // Иначе считаем слева и справа:
	v->l_height = balancedRLHeight(v->left);
	v->r_height = balancedRLHeight(v->right);

	if (v->l_height == 0 && v->r_height != 0) { // На случай, если один из листов нулевой, а второй есть, возвращаем высоту того, который есть, а не нулевого
		return v->r_height + 1;
	}

	if (v->l_height != 0 && v->r_height == 0) { // На случай, если один из листов нулевой, а второй есть, возвращаем высоту того, который есть, а не нулевого
		return v->l_height + 1;
	}

	// И остались варианты, когда либо оба нулевые, либо оба ненулевые
	if (v->l_height <= v->r_height) {
		return v->l_height + 1;
	}
	else {
		return v->r_height + 1;
	}
}

// !!! Основная функция пересчета сумм ключей узлов минимальных путей, проходящих через данную вершину
int balancedSum(Node *&v) {
	if (v == NULL) return 0; // Если узла нет, возвращаем ноль
							 // Иначе считаем слева и справа:
	int l_sum = balancedSum(v->left);
	int r_sum = balancedSum(v->right);

	if (v->l_height == 0 && v->r_height == 0) { // На случай, если оба листа нулевые
		v->l_sum = 0;
		v->r_sum = 0;
		return v->key;
	}

	if (v->l_height == 0 && v->r_height != 0) { // На случай, если один из листов нулевой, а второй есть, возвращаем сумму ключей того, который есть, а не нулевого
		v->l_sum = 0;
		v->r_sum = r_sum;
		return v->l_sum + v->r_sum + v->key;
	}

	if (v->l_height != 0 && v->r_height == 0) { // На случай, если один из листов нулевой, а второй есть, возвращаем сумму ключей того, который есть, а не нулевого
		v->l_sum = l_sum;
		v->r_sum = 0;
		return v->l_sum + v->r_sum + v->key;
	}

	// И остались варианты, когда оба ненулевые
	if (v->l_height <= v->r_height) {
		v->l_sum = l_sum;
		v->r_sum = r_sum;
		return v->l_sum + 0 + v->key;
	}
	else {
		v->l_sum = l_sum;
		v->r_sum = r_sum;
		return 0 + v->r_sum + v->key;
	}
}


// 17) Основная функция поиска узла, через который проходит путь МИНИМАЛЬНОЙ длины
Node* findNodeBetween_MinLenWay(Node *&v) {
	tmpN = v;   // Запоминаем в глобальной переменной указатель на NULL
	tmpL = 10000; // Считаем длину максимального пути равной 10000
	tmpS = 10000; // Запоминаем в глобальной переменной сумму ВСЕХ ключей, пусть она будет очень  большой

	findNode_MinLenWay(v);  // И запускаем поиск узла с лучшими параметрами

	return tmpN;
}

// 18) Вспомогательная процедура обхода дерева и поиска узла, через который проходит путь МИНИМАЛЬНОЙ длины
void findNode_MinLenWay(Node *&v) {
	if (v == NULL) return; // Если пустой узел, выходим
						   // Иначе продолжаем
						   // Учитываем только те узлы, которы нам подходят
	if (v->l_height > 0 && v->r_height > 0) { // А именно те, у которых есть пути слева и справа
		int len = v->l_height + v->r_height + 1; // Рассчитываем длину пути в дугах
		int sum = v->l_sum + v->r_sum + v->key; // Рассчитываем сумму значащих ключей

		if (len < tmpL) { // Если длина пути меньше уже известной, то
			tmpN = v; // запоминаем текущую вершину
			tmpL = len; // обновляем информацию о минимальном длине пути
			tmpS = sum; // обновляем информацию о сумме значащих ключей
		}

		if (len == tmpL) { // если же она равна уже известной, то нужно проверить, у которой из них сумма значащих ключей меньше
			if (sum < tmpS) { // И если у новой сумма ключей меньше, она и становится текущей
				tmpN = v;
				tmpL = len;
				tmpS = sum;
			}
		}
		findNode_MinLenWay(v->left); // Идем вниз влево
		findNode_MinLenWay(v->right); // Идем вниз вправо

	}

}


/*
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
*/


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
		// cout << "\n" << (node->key) << "  ";
		// cout << "Высота " << (node->height) << "  ";
		// cout << "Высота L " << (node->l_height) << "  ";
		// cout << "Высота R " << (node->r_height) << "  ";
		// cout << "Сумма L " << (node->l_sum) << "  ";
		// cout << "Сумма R " << (node->r_sum) << "  ";
		printFrontOrderLeftTree(node->left);
		printFrontOrderLeftTree(node->right);
	}
}

// Метод прямого левого обхода дерева с выводом значащих ключей в консоль (вывод искомого минимального пути)
void printMinWay(Node *&node) {
	if (node != NULL) {
		printMinWay2(node->left);
		cout << (node->key) << "  ";
		printMinWay2(node->right);
	}
}

void printMinWay2(Node *&node) {
	if (node != NULL) {


		if (node->l_height <= node->r_height) {
			printMinWay2(node->left);
		}

		cout << (node->key) << "  ";

		if (node->l_height > node->r_height) {
			printMinWay2(node->right);
		}

	}
}



// !!! Метод поиска медианы
Node* findMediane(Node *&p, int len) {
	if ((len + 1) % 2 == 0) return NULL;
	if (p == NULL) return NULL;
	if (p->l_height == p->r_height) return p;

	if (p->l_height > p->r_height) {
		return findMediane2(p->left, len / 2);
	}
	else {
		return findMediane2(p->right, len / 2);
	}
}

Node* findMediane2(Node *&p, int len) {
	if (p == NULL) return NULL;
	int tmp = (p->l_height <= p->r_height) ? p->l_height : p->r_height;
	if (tmp == len) return p;
	return (p->l_height <= p->r_height) ? findMediane2(p->left, len) : findMediane2(p->right, len);
}

// Функция печати дерева по Вирту
void printTree(Node *&node, int h) {
	if (node != NULL) {
		printTree(node->right, h + 4);
		//printTree(node->left, h+4);
		for (int j = 0; j < h; j++) {
			cout << " ";
		}
		cout << node->key << "\n\n";
		printTree(node->left, h + 4);
		//printTree(node->right, h+4);
	}
}