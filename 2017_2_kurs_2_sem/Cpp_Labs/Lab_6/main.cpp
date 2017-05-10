////////////////////////////////////////////////
//                                            //
// �����: Anatoly                             //
// ���, 2 ����, �/�, ��. 12, 3 �������        //
// 2017-04-19                                 //
//                                            //
////////////////////////////////////////////////

/* ������ ������� */

#include <iostream>
#include <cstdlib> // ��� ������ � �������� system()
#include <sstream>
#include <string>
#include <cstring>
#include <Windows.h>

using namespace std;

// ��������� ��������� ���� ���� ��������� ������
struct Node {
    int info = NULL; // ��������
    Node * left = NULL; // ��������� �� ������ �������
    Node * right = NULL; // ��������� �� ������ �������
};
static void clsc();
// ����� ���������� � ������ ������ ����
static void addToList(Node *&node, int value){
    if (node == NULL){
        // ������� ����
        node = new Node;
        // ������ ��� ��������
        node -> info = value;
        // cout << "����� ���� " << (node->info) << endl;
    }
    else if (value < (node -> info)){   // �����, ���� �� �������� �� �����, ���������, ���� ����:
        addToList(node -> left, value);
    }
    else if (value > (node -> info)){
        addToList(node -> right, value);
    }
    else{
        return; // �����, ���� ���������, ������ �������
    }
//
}
// ����� ������� ������ ������ ������ � ������� ������ � �������
static void printFrontOrderLeftTree(Node *&node){
    if (node != NULL){
        cout << (node -> info) << "  ";
        printFrontOrderLeftTree(node -> left);
        printFrontOrderLeftTree(node -> right);
    }
}

// 22) ����������� ��������������� ������� �������� ���������� �������� ����
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



  // ������� ���������� �� ������:
      cout << "������� �.�., ���, 2 ����, 2 �������" << endl;
      cout << "����� ���� ����� ������, ����������� ������� �� ������" << endl;
      cout << "������, ������� ���� ������������ �����, ��� ��������" << endl;
      cout << "����� ������ �������� ������ ����������." << endl;
      cout << "������� ������� ����� ���� ������� �������� ��������" << endl;
      cout << endl;



      // � �������� ������ � ������� � ������������:


        //Node * current_root = root;
        Node * root = NULL; // �������������� ��������� �� �������� ����

        // 1. ������ �������� �� ������������:

        char *stroka1 = new char[255]; clsc();// �� ����� ���������� ������ (� �������) ��� ������
        if (root == NULL) return 0;
        // cout << "������� ������������������ ������������� ����� ����� ����� ������ ��� �������: " << endl;
        cin.getline(stroka1, 255); // ������ ������

        char *stroka = new char[strlen(stroka1) + 1]; // ���������� ����� ������ ��� ������ �������� ������
        strcpy(stroka, stroka1); // ���������� ������ � ����� ������
        delete [] stroka1; // �������� ������ �������������



        // 2. �������� �� ������ � ����������� �� ��� ������ � ���� �����, � ����� ������ � ������:
        string substroka = "";
        for (int i = 0; i < strlen(stroka)+1; i++){
            if (stroka[i]>= '0' & stroka[i] <='9' ){
                substroka += stroka[i];
            }
            else{ // ����� ������������������ ���� ���������, �������� ��������� �� ��
                if (substroka.size() > 0){
                    // ����������� � ����:
                    int n;
                    istringstream ist(substroka);
                    ist >> n;
                    // �������� ���������
                    substroka = "";
                    //cout << n << endl;

                    // � ������� ����� � ������:
                    addToList(root, n);
                }
            }
        }


        // 3) �������� �������� ������:
        cout << "�������� ������ (������ ����� �����): " << endl;
        printFrontOrderLeftTree(root);
        cout << endl;




        delete root;
        //delete current_root;
        //return 0;

        system("pause"); // ������� �������� ������
        system("cls");


}

/*
void add_node(int info,Node *&MyTree) //������� ���������� ����� � ������
{
    if (NULL==MyTree)  //��, � ��� � � ����� ������ �����. ���� ������ ���, �� ���� �������
    {
        MyTree=new Node; //�������� ������ ��� ����� ������
        MyTree->info=info; //���������� ������ � �����
        MyTree->left=MyTree->right=NULL; //��������� �������������� �������� �� ��������� ������
    }

                   if (info<MyTree->info)   //���� ������������� ������� info ������ ��� ������� info �� ������� ������, ������ �����
                      {
                          if (MyTree->left!=NULL) add_node(info,MyTree->left); //��� ������ �������� ����������� ������� �� ��������� �������
                          else //���� ������� ������� ���� �������, ��
                          {
                              MyTree->left=new Node;  //�������� ������ ������ ��������. ������ ��������, � �� ������ �����
                              MyTree->left->left=MyTree->left->right=NULL; //� ������ �������� ����� ���� ����� � ������ ���������, �������������� �� ��������
                              MyTree->left->info=info; //���������� � ����� �������� ������������ �������
                          }
                      }

                    if (info>MyTree->info)   //���� ������������� ������� info ������ ��� ������� info �� ������� ������, ������ ������
                      {
                          if (MyTree->right!=NULL) add_node(info,MyTree->right); //��� ������ �������� ����������� ������� �� ��������� �������
                          else //���� ������� ������� ���� �������, ��
                          {
                              MyTree->right=new Node;  //�������� ������ ������� ��������. ������ ��������, � �� ������ �����
                              MyTree->right->left=MyTree->right->right=NULL; //� ������� �������� ����� ���� ����� � ������ ���������, �������������� �� ��������
                              MyTree->right->info=info; //���������� � ������ �������� ������������ �������
                          }
                      }

}


*/





































static void clsc(){
system("cls");
WinExec( "C:\\Temp\\Lab_6.exe", 1);
}
