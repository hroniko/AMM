////////////////////////////////////////////////
//                                            //
// �����: Anatoly                             //
// ���, 2 ����, �/�, ��. 12, 3 �������        //
// 2017-04-04                                 //
//                                            //
////////////////////////////////////////////////

/* ����� ������� */

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

static int count7(Node * root){
    // cout << "������ ������ ����� ������� �� �����: " << endl;
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
    // �������������� ������:


    // � �������� ������ � ������� � ������������:

    while(true){

        Node * root = new Node; // �������������� ��������� �� �������� ����
        Node * current_root = root;

        // 1. ������ �������� �� ������������:

        char *stroka1 = new char[255]; // �� ����� ���������� ������ (� �������) ��� ������
        cout << "������� ������������������ ������������� ����� ����� ����� ������ ��� �������: " << endl;
        cin.getline(stroka1, 255); // ������ ������

        char *stroka = new char[strlen(stroka1) + 1]; // ���������� ����� ������ ��� ������ �������� ������
        strcpy(stroka, stroka1); // ���������� ������ � ����� ������
        delete [] stroka1; // �������� ������ �������������



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

        // 4) ������� � ��������� ����
        Node * current_root0 = root;
        while (current_root0 -> next != NULL){
                if((current_root0 -> next -> info > 1) & (current_root0 -> next -> info < 8)){
                        Node * tmp = new Node;
                        tmp -> info = 0;
                        (tmp -> next) = (current_root0 -> next);
                        current_root0 -> next = tmp;
                        //cout << "!" << endl; // ��-�� ��� ��������
                        current_root0 = tmp -> next;

                }
                else{
                    current_root0 = current_root0 -> next;
                }
        }
        // � ��� ��������� ������:
        if((root -> info > 1) & (root -> info < 8)){
            Node * tmp = new Node;
            tmp -> info = 0;
            tmp -> next = root;
            root = tmp;
        }


        // 5) �������� �������� ������:
        cout << "������ ����� ������� ����� ����� ������ �� ��������� �� 2 �� 7 ������������: " << endl;
        printList(root);

        // 6) ������� ����� ����� ������ 7:
        cout << "����� ����� ������ ����: " << count7(root) << endl;
        cout << endl;


        delete root;
        delete current_root;
        //return 0;

        system("pause"); // ������� �������� ������
        system("cls");
    }

}
