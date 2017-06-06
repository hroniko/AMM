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
	int l_height = NULL; // �������� ������ ����� - ���������� �� ���������� ���� ����� (���������� � �����)
	int r_height = NULL; // �������� ������ ����� - ���������� �� ���������� ���� ����� (���������� � �����)
	int l_sum = NULL; // ����� ������ ����� �� ������������ ���� �����
	int r_sum = NULL; // ����� ������ ����� �� ������������ ���� ������
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
int balancedRLHeight(Node *&v);
int balancedSum(Node *&v);
void printMinWay(Node *&node);
void printMinWay2(Node *&node);
Node* findMediane(Node *&p, int len);
Node* findMediane2(Node *&p, int len);
void printTree(Node *&node, int h);

// �������� ���������
int main() {

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

	balancedRLHeight(root); // � ��������� ���������� � ������� 
	balancedSum(root); // � ��������� ���������� � ������


	// 3) �������� �������� ������:
	cout << "�������� ������ (������ ����� �����): " << endl;
	printFrontOrderLeftTree(root); // ������� �� ������� ������ ����� ������� ���� ������
	cout << endl;
	cout << endl;
	// � �������� ������
	printTree(root, 0);
	cout << endl;


	// 4) ���� ����, ����� ������� �������� ������� ����: � ������� ������ ��������� ������� �� ��������
	Node * root2 = findNodeBetween_MinLenWay(root);
	cout << "����, ����� ������� �������� ������� ����: " << root2->key << endl;

	// 5) �������� ����������� ����:
	cout << "����������� ����: " << endl;
	printMinWay(root2);
	cout << endl;
/*
	// 6) ���������, ����� �� ������� ������� �� ���� (�����, ���� ������ �������� ����������, � ���� ������ ���� �������)
	int len = root2->l_height + root2->r_height; // ���������� ����� ����
	cout << "����� ������������ ����: " << len << " ��� (" << len + 1 << " ������)" << endl;
	if ((len + 1) % 2 == 0) {
		cout << "������ ���������� ������, ������� ���, ������� ������" << endl;
	}
	else {
		// ����� ���� � ������� �������		
		root2 = findMediane(root2, len);
		cout << "������� ������� " << root2->key << " ������ ���������" << endl;

		// 7) ������� ������ ���������
		root = rightRemoveKey(root, root2->key);
		balancedDepthWeightHeight(root, 0, 0); // � ��������� ���������� � �������
		balancedRLHeight(root); // � ��������� ���������� � ������� 
		balancedSum(root); // � ��������� ���������� � ������


		// 8) �������� ����� ������ (����� ��������):
		cout << "����� ������ (������ ����� �����): " << endl;
		printFrontOrderLeftTree(root); // ������� �� ������� ������ ����� ������� ���� ������
		cout << endl;
		cout << endl;
		// � ����� ������
		printTree(root, 0);
		cout << endl;
	}

*/
	cout << "������� ������� �������� ������� ���� " << root2->key << " ������ ���������" << endl;

	// 7) ������� ������ ���������
	root = rightRemoveKey(root, root2->key);
	balancedDepthWeightHeight(root, 0, 0); // � ��������� ���������� � �������
	balancedRLHeight(root); // � ��������� ���������� � ������� 
	balancedSum(root); // � ��������� ���������� � ������


	// 8) �������� ����� ������ (����� ��������):
	cout << "����� ������ (������ ����� �����): " << endl;
	printFrontOrderLeftTree(root); // ������� �� ������� ������ ����� ������� ���� ������
	cout << endl;
	cout << endl;
	// � ����� ������
	printTree(root, 0);
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
	if (v->left != NULL) {
		balancedDepthWeightHeight(v->left, d + 1, w - 1);
	}
	if (v->right != NULL) {
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

// !!! �������� ������� ��������� ����������� ���������� �� ������� ����� � ������ �� ����
int balancedRLHeight(Node *&v) {
	if (v == NULL) return 0; // ���� ���� ���, ���������� ����
							 // ����� ������� ����� � ������:
	v->l_height = balancedRLHeight(v->left);
	v->r_height = balancedRLHeight(v->right);

	if (v->l_height == 0 && v->r_height != 0) { // �� ������, ���� ���� �� ������ �������, � ������ ����, ���������� ������ ����, ������� ����, � �� ��������
		return v->r_height + 1;
	}

	if (v->l_height != 0 && v->r_height == 0) { // �� ������, ���� ���� �� ������ �������, � ������ ����, ���������� ������ ����, ������� ����, � �� ��������
		return v->l_height + 1;
	}

	// � �������� ��������, ����� ���� ��� �������, ���� ��� ���������
	if (v->l_height <= v->r_height) {
		return v->l_height + 1;
	}
	else {
		return v->r_height + 1;
	}
}

// !!! �������� ������� ��������� ���� ������ ����� ����������� �����, ���������� ����� ������ �������
int balancedSum(Node *&v) {
	if (v == NULL) return 0; // ���� ���� ���, ���������� ����
							 // ����� ������� ����� � ������:
	int l_sum = balancedSum(v->left);
	int r_sum = balancedSum(v->right);

	if (v->l_height == 0 && v->r_height == 0) { // �� ������, ���� ��� ����� �������
		v->l_sum = 0;
		v->r_sum = 0;
		return v->key;
	}

	if (v->l_height == 0 && v->r_height != 0) { // �� ������, ���� ���� �� ������ �������, � ������ ����, ���������� ����� ������ ����, ������� ����, � �� ��������
		v->l_sum = 0;
		v->r_sum = r_sum;
		return v->l_sum + v->r_sum + v->key;
	}

	if (v->l_height != 0 && v->r_height == 0) { // �� ������, ���� ���� �� ������ �������, � ������ ����, ���������� ����� ������ ����, ������� ����, � �� ��������
		v->l_sum = l_sum;
		v->r_sum = 0;
		return v->l_sum + v->r_sum + v->key;
	}

	// � �������� ��������, ����� ��� ���������
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


// 17) �������� ������� ������ ����, ����� ������� �������� ���� ����������� �����
Node* findNodeBetween_MinLenWay(Node *&v) {
	tmpN = v;   // ���������� � ���������� ���������� ��������� �� NULL
	tmpL = 10000; // ������� ����� ������������� ���� ������ 10000
	tmpS = 10000; // ���������� � ���������� ���������� ����� ���� ������, ����� ��� ����� �����  �������

	findNode_MinLenWay(v);  // � ��������� ����� ���� � ������� �����������

	return tmpN;
}

// 18) ��������������� ��������� ������ ������ � ������ ����, ����� ������� �������� ���� ����������� �����
void findNode_MinLenWay(Node *&v) {
	if (v == NULL) return; // ���� ������ ����, �������
						   // ����� ����������
						   // ��������� ������ �� ����, ������ ��� ��������
	if (v->l_height > 0 && v->r_height > 0) { // � ������ ��, � ������� ���� ���� ����� � ������
		int len = v->l_height + v->r_height + 1; // ������������ ����� ���� � �����
		int sum = v->l_sum + v->r_sum + v->key; // ������������ ����� �������� ������

		if (len < tmpL) { // ���� ����� ���� ������ ��� ���������, ��
			tmpN = v; // ���������� ������� �������
			tmpL = len; // ��������� ���������� � ����������� ����� ����
			tmpS = sum; // ��������� ���������� � ����� �������� ������
		}

		if (len == tmpL) { // ���� �� ��� ����� ��� ���������, �� ����� ���������, � ������� �� ��� ����� �������� ������ ������
			if (sum < tmpS) { // � ���� � ����� ����� ������ ������, ��� � ���������� �������
				tmpN = v;
				tmpL = len;
				tmpS = sum;
			}
		}
		findNode_MinLenWay(v->left); // ���� ���� �����
		findNode_MinLenWay(v->right); // ���� ���� ������

	}

}


/*
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
*/


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
		// cout << "\n" << (node->key) << "  ";
		// cout << "������ " << (node->height) << "  ";
		// cout << "������ L " << (node->l_height) << "  ";
		// cout << "������ R " << (node->r_height) << "  ";
		// cout << "����� L " << (node->l_sum) << "  ";
		// cout << "����� R " << (node->r_sum) << "  ";
		printFrontOrderLeftTree(node->left);
		printFrontOrderLeftTree(node->right);
	}
}

// ����� ������� ������ ������ ������ � ������� �������� ������ � ������� (����� �������� ������������ ����)
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



// !!! ����� ������ �������
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

// ������� ������ ������ �� �����
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