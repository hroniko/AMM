/**
 * Created by Hroniko on 11.09.2016.
 */
import java.util.Scanner;

public class MySort {
    public static void main(String[] args) {
        // Считываем параметры для генерации массива:
        System.out.println("Задайте число элементов и диапазон (size, start, end, например, 10 0 5):");
        Scanner sc = new Scanner(System.in);
        int maxSize  = sc.nextInt(); //System.out.println(maxSize);
        int start = sc.nextInt(); //System.out.println(start);
        int finish = sc.nextInt(); //System.out.println(finish);

        /*ArraySort arr = new ArraySort(maxSize);
        arr.add(77);
        arr.add(99);
        arr.add(44);
        arr.add(55);
        arr.add(22);
        arr.add(88);
        arr.add(11);
        arr.add(00);
        arr.add(66);
        arr.add(33); */

        ArraySort arr = new ArraySort(maxSize, start, finish);
        ArraySort arr1 = new ArraySort(arr); // Делаем копию
        ArraySort arr2 = new ArraySort(arr); // Делаем копию
        ArraySort arr3 = new ArraySort(arr); // Делаем копию
        ArraySort arr4 = new ArraySort(arr); // Делаем копию
        ArraySort arr5 = new ArraySort(arr); // Делаем копию
        ArraySort arr6 = new ArraySort(arr); // Делаем копию
        ArraySort arr7 = new ArraySort(arr); // Делаем копию
        ArraySort arr8 = new ArraySort(arr); // Делаем копию
        ArraySort arr9 = new ArraySort(arr); // Делаем копию
        ArraySort arr10 = new ArraySort(arr); // Делаем копию


        //arr.display();

         long timeout;

        timeout= System.currentTimeMillis();
        arr1.insertionSort(); //sortDirectInclusion();
        timeout = System.currentTimeMillis() - timeout;
        //arr1.display();
        System.out.println("Длительность сортировки прямыми вставками: " + timeout + " мс");

        timeout= System.currentTimeMillis();
        arr2.insertionSortBisection(); //sortDirectInclusion();
        timeout = System.currentTimeMillis() - timeout;
        //arr2.display();
        System.out.println("Длительность сортировки прямыми вставками с бисекцией: " + timeout + " мс");

        timeout= System.currentTimeMillis();
        arr3.quickSort(); //sortDirectInclusion();
        timeout = System.currentTimeMillis() - timeout;
        //arr3.display();
        System.out.println("Длительность быстрой сортировки с рекурсией: " + timeout + " мс");

        timeout= System.currentTimeMillis();
        arr4.quickSortNonRecursive(); //sortDirectInclusion();
        timeout = System.currentTimeMillis() - timeout;
        //arr4.display();
        System.out.println("Длительность быстрой сортировки без рекурсии: " + timeout + " мс");

        timeout= System.currentTimeMillis();
        arr5.selectionSort(); //sortDirectInclusion();
        timeout = System.currentTimeMillis() - timeout;
        //arr5.display();
        System.out.println("Длительность сортировки прямым выбором: " + timeout + " мс");

        timeout= System.currentTimeMillis();
        arr6.bubbleSort(); //sortDirectInclusion();
        timeout = System.currentTimeMillis() - timeout;
        //arr6.display();
        System.out.println("Длительность сортировки пузырьком: " + timeout + " мс");

        timeout= System.currentTimeMillis();
        arr7.shakerSort(); //sortDirectInclusion();
        timeout = System.currentTimeMillis() - timeout;
        //arr7.display();
        System.out.println("Длительность шейкерной сортировки: " + timeout + " мс");

        timeout= System.currentTimeMillis();
        arr8.shellSort(); // Зарускаем сортировку Шелла
        timeout = System.currentTimeMillis() - timeout;
        //arr8.display();
        System.out.println("Длительность сортировки Шелла: " + timeout + " мс");
    }

}
