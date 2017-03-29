////////////////////////////////////////////////
// ��������� ���������� / ������������ ������ //
// �� ��������� ������� ����������            //
//                                            //
// �����: Anatoly                             //
// ���, 2 ����, �/�, ��. 12, 3 �������        //
// 2017-03-22                                 //
////////////////////////////////////////////////

/* ��������� ������� */

#include <iostream>
#include <cstdlib> // ��� ������ � �������� system()

using namespace std;



// ��������� ��������� ���� "��������"
struct Room {
    int full_area; // ����� �������, �2
    int life_area; // ����� �������
    int kitchen_area; // ������� �����

    bool sanuzel; // ������� ������� true - ��, false - ���
    bool san_type; // ��� ��������������, true - �����������, false - ���

    bool lodgia; // ������� ������ true - ��, false - ���
    bool is_panel; // ��������� true ��� ��������� false ���

    int floor_count; // ���������� ������ � ����
    int floor_current; // ������� ����

    string region; // �����, ��� ����������� ��������
    string address; // �����, ��� ����������� ��������
    string name; // ����������� ��������

    double price; // ���� �� ��������, ���

} room1, room2, room3, room4, room5;

static void printRoom(Room room){
    string sn = ( room.sanuzel ? "����": "���" );
    string xk = ( room.san_type ? "�����������": "����������" );
    string lg = ( room.lodgia ? "����": "���" );
    string mt = ( room.is_panel ? "������������ ������": "���������� ������" );
    // ������ ���������� � ��������
    cout << "������� ���������� � ��������: " << room.name << endl;
    cout << "  +  ����� �������, �2: " << room.full_area << endl;
    cout << "  +  ����� �������, �2: " << room.life_area << endl;
    cout << "  +  ������� �����, �2: " << room.kitchen_area << endl;
    cout << "  +  �������:           " << sn << endl;
    cout << "  +  �-�� �������:      " << xk << endl;
    cout << "  +  ������:            " << lg << endl;
    cout << "  +  �������� ����:     " << mt << endl;
    cout << "  +  ������ � ����:     " << room.floor_count << endl;
    cout << "  +  ���� ��������:     " << room.floor_current << endl;
    cout << "  +  �����:             " << room.region << endl;
    cout << "  +  �����:             " << room.address << endl;
    cout << "  +  ����, ���. ���:    " << room.price << endl;
    cout << endl;

}

static void findRoom(Room * room, size_t n, double max_price, int min_area, int max_area){
    cout << "����� �������� � �����������: ������������ ���� " << max_price << " ���. ���.; ����� ������� � ��������� �� " << min_area << " �� " << max_area << " �2" << endl;
    cout << endl;
    int good_count = 0;
    for(size_t i = 0; i < n; i++){
        if ( ((*room).price <= max_price) & ((*room).life_area >= min_area) & ((*room).life_area <= max_area) ){
            good_count ++;
            printRoom(*room);
        }
        room++;
    }
    if (good_count < 1){
        cout << "� ���������, ������� � ������ ����������� �� �������. �������� ��������� � ��������� ������" << endl;
    }

}

int main()
{
    setlocale(LC_ALL, "Russian");
    // �������������� ������:

    room1.full_area = 60;
    room1.life_area = 35;
    room1.kitchen_area = 10;
    room1.sanuzel = true;
    room1.san_type = true;
    room1.lodgia = true;
    room1.is_panel = false;
    room1.floor_count = 8;
    room1.floor_current = 3;
    room1.region = "Voronezh";
    room1.address = "address1";
    room1.name = "�������� � 1";
    room1.price = 1.950;

    room2.full_area = 40;
    room2.life_area = 25;
    room2.kitchen_area = 6;
    room2.sanuzel = true;
    room2.san_type = true;
    room2.lodgia = false;
    room2.is_panel = true;
    room2.floor_count = 5;
    room2.floor_current = 5;
    room2.region = "Voronezh";
    room2.address = "address2";
    room2.name = "�������� � 2";
    room2.price = 1.390;

    room3.full_area = 56;
    room3.life_area = 32;
    room3.kitchen_area = 9;
    room3.sanuzel = true;
    room3.san_type = false;
    room3.lodgia = true;
    room3.is_panel = false;
    room3.floor_count = 12;
    room3.floor_current = 7;
    room3.region = "Voronezh";
    room3.address = "address3";
    room3.name = "�������� � 3";
    room3.price = 2.100;

    room4.full_area = 64;
    room4.life_area = 50;
    room4.kitchen_area = 12;
    room4.sanuzel = true;
    room4.san_type = false;
    room4.lodgia = true;
    room4.is_panel = true;
    room4.floor_count = 16;
    room4.floor_current = 4;
    room4.region = "Voronezh";
    room4.address = "address4";
    room4.name = "�������� � 4";
    room4.price = 2.750;

    room5.full_area = 30;
    room5.life_area = 22;
    room5.kitchen_area = 6;
    room5.sanuzel = true;
    room5.san_type = true;
    room5.lodgia = false;
    room5.is_panel = true;
    room5.floor_count = 8;
    room5.floor_current = 7;
    room5.region = "Voronezh";
    room5.address = "address5";
    room5.name = "�������� � 5";
    room5.price = 1.650;

    // ��������� ����������� ������:
    //Room rooms[5] = {room1, room2, room3, room4, room5};
    Room * rm = new Room[5];
    *rm     = room1;
    *(rm+1) = room2;
    *(rm+2) = room3;
    *(rm+3) = room4;
    *(rm+4) = room5;

    while(true){
        // 1. ������ �������� �� ������������:
        double max_price;
        int min_area, max_area;
        cout << "������� ����������� ���������� ���� ��������, ���. ���: ";
        cin >> max_price ;
        cout << endl;

        cout << "������� ����� ������ ����������� � ������������ ����� �������, �2: ";
        cin >> min_area >> max_area ;
        cout << endl;

        // printRoom(room1);
        findRoom(rm, 5, max_price, min_area, max_area);
        system("pause"); // ������� �������� ������
        system("cls");
    }

    delete[] rm;
    return 0;
}
