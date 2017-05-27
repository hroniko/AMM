// Z3.cpp: ���������� ����� ����� ��� ����������� ����������.
//
#include "stdafx.h"
#include <iostream>
#include <cstdlib> // ��� ������ � �������� system()
#include <sstream>
#include <string>
#include <cstring>

using namespace std;



// ��������� ��������� ���� ���� ������������ ������
struct Node {
    int info = 0; // ��������
    Node * next = NULL; // ��������� �� ��������� ����
};

static void printList(Node * root){
    // cout << "������ ������ ����� ������� �� �����: " << endl;
    while (root-> next != NULL){
            cout << root -> info << "  ";
            root = root -> next;
    }
    cout << endl;
}


int main()
{
    setlocale(LC_ALL, "Russian");
    // �������������� ������:


    // � �������� ������ � ������� � ������������:

    while(true){

        Node * root = new Node; // �������������� ��������� �� �������� ����
        Node * current_root = root;

        // 1. ������ �������� �� ������������:

        char *stroka = new char[255]; // �� ����� ���������� ������ (� �������) ��� ������
        cout << "������� ������������������ ������������� ����� ����� ����� ������ ��� �������: " << endl;
        cin.getline(stroka, 255); // ������ ������



        // 2. �������� �� ������ � ����������� �� ��� ������ � ���� �����, � ����� ������ � �����:
        int list_count = 0;
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
                    // cout << n << endl;

                    // � ������� ����� � ������:
                    if (list_count == 0){
                        current_root -> info = n;
                        current_root -> next = new Node;
                    }
                    else {
                        // ������� ����� ���� � �������� ������� �������� ����:
                        current_root = current_root -> next;
                        // � ��������� ��������:
                        current_root -> info = n;
                        current_root -> next = new Node;
                        // ������������ ��������� �� ����:

                    }
                    list_count ++;
                }
            }
        }


        // 3) �������� �������� ������:
        cout << "�������� ������: " << endl;
        printList(root);

        //cout << root ->info << endl;
        //cout << root ->next ->info  << endl;
        //cout << list_count << endl;


        // 4) ������� � ������� ������ �������, ������� ����� 4

        // ������� ��������� ������:
        if(root -> info > 4){
            root = root -> next;
        }
        else{
            // ����� ��������� ��� ��������� ����

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

        // 5) �������� ������ ����� ��������:
        cout << "������ ����� �������� ������� �������������� �������� ������ 4: " << endl;
        printList(root);


        // 6) ������� � ��������� �������
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
        // � ��� ��������� ������:
        if(root -> info == 15){
            Node * tmp = new Node;
            tmp -> info = 10;
            tmp -> next = root;
            root = tmp;
        }


        // 7) �������� ������ ����� �������:
        cout << "������ ����� ������� ������� ����� ���������� ������� 15: " << endl;
        printList(root);

        cout << endl;


        delete root;
        delete current_root;
        //return 0;

        system("pause"); // ������� �������� ������
        system("cls");
    }

}

