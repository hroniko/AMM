// Z6.cpp: ���������� ����� ����� ��� ����������� ����������.
//

/*
5. ����� ����������� ����� ����� �������� ������� ���, � �������� ����� ������ ���� ��� ������ ����������, 
� ������� (������ ���������) ����������� ������� ����� ����. ��������� ������ (�����) ����� ����������� ������.
*/

#include "stdafx.h"
#include <iostream>
#include <cstdlib> // ��� ������ � �������� system()
#include <sstream>
#include <string>
#include <cstring>
#include <Windows.h>

using namespace std;


// ��������� ��������� ���� ���� ��������� ������
struct Node {
	int key = NULL; // ��������
	Node * left = NULL; // ��������� �� ������ �������
	Node * right = NULL; // ��������� �� ������ �������
	int height = NULL; // ������ ���� (���������� � ����� �� ���� �� �������� ���������� �������)
};

Node *tmpN = NULL;
int tmpL = 10000;
int tmpS = 10000;

// ��������� �������
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


// �������� ���������
int main(){

	setlocale(LC_ALL, "Russian");

	Node * root = NULL; // �������������� ��������� �� �������� ����

	// 1. ������ �������� �� ������������:
	char *stroka = new char[255];
	cout << "������� ������������������ ������������� ����� ����� ����� ������ ��� �������: " << endl;
	cin.getline(stroka, 255); // ������ ������


	// 2. �������� �� ������ � ����������� �� ��� ������ � ���� �����, � ����� ������ � ������:
	string substroka = "";
	for (int i = 0; i < strlen(stroka) + 1; i++) {
		if (stroka[i] >= '0' & stroka[i] <= '9') {
			substroka += stroka[i];
		}
		else { // ����� ������������������ ���� ���������, �������� ��������� �� ��
			if (substroka.size() > 0) {
				// ����������� � ����:
				int n;
				istringstream ist(substroka);
				ist >> n;
				// �������� ���������
				substroka = "";
				//cout << n << endl;

				// � ������� ����� � ������:
				addToList(root, n);
				balancedDepthWeightHeight(root, 0, 0); // � ��������� ���������� � �������
			}
		}
	}


	// 3) �������� �������� ������:
	cout << "�������� ������ (������ ����� �����): " << endl;
	printFrontOrderLeftTree(root);
	cout << endl;


	// 4) ���� ����, ����� ������� �������� ������� ����: � ������� ������ ��������� ������� �� ��������
	Node * root2 = findNodeBetween_MinLenWay(root);
	cout << "����, ����� ������� �������� ������� ����: " << root2->key << endl;

	// 5) ������� ������ ��������� ���
	root = rightRemoveKey(root, root2->key);


	// 6) �������� ����� ������ (����� ��������):
	cout << "����� ������ (������ ����� �����): " << endl;
	printFrontOrderLeftTree(root); // ������� �� ������� ������ ����� ������� ���� ������
	cout << endl;





	delete root;

	system("pause"); // ������� �������� ������
	system("cls");

    return 0;
}



// ����� ���������� � ������ ������ ����
void addToList(Node *&node, int value) {
	if (node == NULL) {
		// ������� ����
		node = new Node;
		// ������ ��� ��������
		node->key = value;
		//node->height = 0;
	}
	else if (value < (node->key)) {   // �����, ���� �� �������� �� �����, ���������, ���� ����:
		addToList(node->left, value);
		balancedDepthWeightHeight(node, 0, 0);
	}
	else if (value >(node->key)) {
		addToList(node->right, value);
	}
	else {
		return; // �����, ���� ���������, ������ �������
	}
	//
}


// 5) ��������������� ������� ����������� ������ ���� ����� ������ (��� ���������� / �������� ����)
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



// 3) ��������������� ������� ����������� � ��������� ������ �������
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


// 17) �������� ������� ������ ����, ����� ������� �������� ���� ����������� �����
Node* findNodeBetween_MinLenWay(Node *&v) {
	tmpN = v;   // ���������� � ���������� ���������� ��������� �� NIL
	tmpL = 10000; // ������� ����� ������������� ���� ������ 0
	tmpS = 10000; // ���������� � ���������� ���������� ����� ���� ������, ����� ��� ����� �����  �������

	findNode_MinLenWay(v);  // � ��������� ����� ���� � ������� �����������

	return tmpN;
}

// 18) ��������������� ��������� ������ ������ � ������ ����, ����� ������� �������� ���� ����������� �����
void findNode_MinLenWay(Node *&v) {
	int len = minLenWay(v);
	if ((v != NULL) && (len > 1)) { 
		if (len < tmpL) { // ���� ��� ������ ��� ���������, ��
			tmpN = v;
			tmpL = len;
			tmpS = sumAllKey_MinLenWay(v);
		}

		if (len == tmpL) { // ���� �� ��� ����� ��� ���������, �� ����� ���������, � ������� ����� ���� ������ ������
			if (sumAllKey_MinLenWay(v) < tmpS) { // � ���� � ����� ����� ���� ������, ��� � ���������� ���������
				tmpN = v;
				tmpL = len;
				tmpS = sumAllKey_MinLenWay(v);
			}
		}
		findNode_MinLenWay(v->left); // ���� ���� �����
		findNode_MinLenWay(v->right); // ���� ���� ������
	}
}



// 13) �������� ������� ����������� ����������� ����� ����, ����������� ����� �������� ����
int minLenWay(Node *&v) {
	int len = 0;
	if (v != NULL) { // ���� �� ������� ����, ��
		if (v->left != NULL) {
			len = len + 1 + minLenWay(v->left);  // ����������� �� ����� �� ������ ����� (+1 - �.�. ��� ���� �� ��������)
		}
		if (v->right != NULL) {
			len = len + 1 + minLenWay(v->right); // ����������� �� ����� �� ������� �����
		}
	}
	return len;
}

// 15) �������� ������� (�� ����� ������) ���������� ����� ���� ��������� ���� ����������� �����, ���������� ����� �������� ����
int sumAllKey_MinLenWay(Node *&v) {
	int sum = 0;
	if (v != NULL) {
		sum = v->key + sumAllKey(v->left) + sumAllKey(v->right);
	}
	return sum;
}

// 16) ��������������� ������� (�� ����� �����) ���������� ����� ���� ��������� ���� ����������� �����, ���������� ����� �������� ����
int sumAllKey(Node *&v) {
	int sum = 0;
	if (v != NULL) { // ���� �� ������� ����, ��
		if ((v->left != NULL) && (v->right != NULL)) {
			// � ���� � �� �����, ������� ������, ���, ���� �����, �� � ����� - ��� ���� ������!:
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

// 9) �������� ������� ������� �������� �������� �� ��� �����
Node* rightRemoveKey(Node *&p, int k) { // �������� ����� k �� ������ p
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
			else { // ����� ����, �.�. k = p -> key
				q = p->left; // ��������� ����� ���������   // 10
				r = p->right; // ��������� ������ ���������  // 13

				if (r == NULL) { // ���� ������� ��������� ���, ������ ��������� �� ����� ������� ���� �����
					p = q;
				}
				else {
					min = findMinNode(r); // ����� ���� ����������� ������� � ������ ��������� � ���������� ��� 
					min->right = removeMinNode(r); // ��������� � ������ ��������� 12 �������� ������� 13 � ��� ��� �������
					min->left = q;
					p = min;
					return p;
				}
			}
		}
		return p;
	}
}


// 6) ��������������� ������� ������ ���� � ����������� ������ � ������ p
Node* findMinNode(Node *&p) {
	if (p->left != NULL) {
		return findMinNode(p->left);
	}
	else {
		return p;
	}
}



// 7) C�������� ������� ��� �������� ������������ �������� �� ��������� ������
Node* removeMinNode(Node *&p) {
	if (p->left == NULL) {
		return p->right;
	}
	else {
		p->left = removeMinNode(p->left);
		return p;
	}
}



// ����� ������� ������ ������ ������ � ������� ������ � �������
void printFrontOrderLeftTree(Node *&node) {
	if (node != NULL) {
		cout << (node->key) << "  ";
		// cout << "������ " << (node->height) << "  ";
		printFrontOrderLeftTree(node->left);
		printFrontOrderLeftTree(node->right);
	}
}
