////////////////////////////////////////////////
// Программа шифрования / дешифрования строки //
// по заданному шаблону шифрования            //
//                                            //
// Автор: Anatoly                             //
// ПММ, 2 курс, В/О, гр. 12, 3 вариант        //
// 2017-03-22                                 //
////////////////////////////////////////////////

/* Четвертое задание */

#include <iostream>
#include <cstdlib> // Для работы с функцией system()

using namespace std;



// Описываем структуру типа "квартира"
struct Room {
    int full_area; // Общая площадь, м2
    int life_area; // жилая площадь
    int kitchen_area; // площадь кухни

    bool sanuzel; // Наличие санузла true - да, false - нет
    bool san_type; // Его характеристики, true - совмещенный, false - нет

    bool lodgia; // Наличие лоджии true - да, false - нет
    bool is_panel; // Панельный true или кирпичный false дом

    int floor_count; // Количество этажей в доме
    int floor_current; // Текущий этаж

    string region; // Район, где расположена квартира
    string address; // Адрес, где расположена квартира
    string name; // обозначение квартиры

    double price; // Цена за квартиру, млн

} room1, room2, room3, room4, room5;

static void printRoom(Room room){
    string sn = ( room.sanuzel ? "есть": "нет" );
    string xk = ( room.san_type ? "совмещенный": "раздельный" );
    string lg = ( room.lodgia ? "есть": "нет" );
    string mt = ( room.is_panel ? "многослойные панели": "силикатный кирпич" );
    // печать информации о квартире
    cout << "Сводная информация о квартире: " << room.name << endl;
    cout << "  +  Общая площадь, м2: " << room.full_area << endl;
    cout << "  +  Жилая площадь, м2: " << room.life_area << endl;
    cout << "  +  Площадь кухни, м2: " << room.kitchen_area << endl;
    cout << "  +  Санузел:           " << sn << endl;
    cout << "  +  Х-ки санузла:      " << xk << endl;
    cout << "  +  Лоджия:            " << lg << endl;
    cout << "  +  Материал стен:     " << mt << endl;
    cout << "  +  Этажей в доме:     " << room.floor_count << endl;
    cout << "  +  Этаж квартиры:     " << room.floor_current << endl;
    cout << "  +  Район:             " << room.region << endl;
    cout << "  +  Адрес:             " << room.address << endl;
    cout << "  +  Цена, млн. руб:    " << room.price << endl;
    cout << endl;

}

static void findRoom(Room * room, size_t n, double max_price, int min_area, int max_area){
    cout << "Поиск квартиры с параметрами: максимальная цена " << max_price << " млн. руб.; жилая площадь в диапазоне от " << min_area << " до " << max_area << " м2" << endl;
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
        cout << "К сожалению, квартир с такими параметрами не найдено. Измените параметры и повторите запрос" << endl;
    }

}

int main()
{
    setlocale(LC_ALL, "Russian");
    // Подготавливаем данные:

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
    room1.name = "Квартира № 1";
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
    room2.name = "Квартира № 2";
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
    room3.name = "Квартира № 3";
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
    room4.name = "Квартира № 4";
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
    room5.name = "Квартира № 5";
    room5.price = 1.650;

    // Формируем статический массив:
    //Room rooms[5] = {room1, room2, room3, room4, room5};
    Room * rm = new Room[5];
    *rm     = room1;
    *(rm+1) = room2;
    *(rm+2) = room3;
    *(rm+3) = room4;
    *(rm+4) = room5;

    while(true){
        // 1. Читаем араметры от пользователя:
        double max_price;
        int min_area, max_area;
        cout << "Введите максимально допустимую цену квартиры, млн. руб: ";
        cin >> max_price ;
        cout << endl;

        cout << "Введите через пробел минимальную и максимальную жилую площадь, м2: ";
        cin >> min_area >> max_area ;
        cout << endl;

        // printRoom(room1);
        findRoom(rm, 5, max_price, min_area, max_area);
        system("pause"); // Команда задержки экрана
        system("cls");
    }

    delete[] rm;
    return 0;
}
