/*
 * Created by SharpDevelop.
 * User: Hroniko
 * Date: 12.09.2016
 * Time: 15:00
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Diagnostics;

namespace MySort
{
	class Program
	{
		public static void Main(string[] args)
		{
			Console.WriteLine("Введите число элементов, начало и конец диапазона через пробел:");
			
			string[] stroka = Console.ReadLine().Split(' ');
			
			int size = int.Parse(stroka[0]);
			int start = int.Parse(stroka[1]);
			int finish = int.Parse(stroka[2]);
				
			//int maxSize = 100;
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
	        ArraySort arr = new ArraySort(size, start, finish);
	        ArraySort arr1; // Ссылка на массив, будет храниться копия исходного сформированного массива
	
	        // arr.display();
	        
			Stopwatch stopwatch; // Объект стопвотча, будем считать время сортировки
			
			arr1 = new ArraySort(arr); // Делаем копию сходного массива для текущей сортировки
			stopwatch = new Stopwatch();
	        stopwatch.Start();
	        arr1.insertionSort(); // Сортировка вставками
	        stopwatch.Stop();
	        Console.WriteLine("Длительность сортировки прямыми вставками: " + (stopwatch.ElapsedMilliseconds).ToString() + " мс");
	        // arr1.display();
	
			arr1 = new ArraySort(arr);
			stopwatch = new Stopwatch();
	        stopwatch.Start();
	        arr1.insertionSortBisection(); // Сортировка вставками
	        stopwatch.Stop();
	        Console.WriteLine("Длительность сортировки прямыми вставками с бисекцией: " + (stopwatch.ElapsedMilliseconds).ToString() + " мс");
	        // arr1.display();
			
	        arr1 = new ArraySort(arr);
	        stopwatch = new Stopwatch();
	        stopwatch.Start();
	        arr1.quickSort(); // Быстрая сортировка рекурсией
	        stopwatch.Stop();
	        Console.WriteLine("Длительность быстрой сортировки с рекурсией: " + (stopwatch.ElapsedMilliseconds).ToString() + " мс");
	        // arr1.display();
			
	        arr1 = new ArraySort(arr);
	        stopwatch = new Stopwatch();
	        stopwatch.Start();
	        arr1.quickSortNonRecursive(); // Быстрая сортировка рекурсией
	        stopwatch.Stop();
	        Console.WriteLine("Длительность быстрой сортировки без рекурсии: " + (stopwatch.ElapsedMilliseconds).ToString() + " мс");
	        // arr1.display();
	        
	        arr1 = new ArraySort(arr);
	        stopwatch = new Stopwatch();
	        stopwatch.Start();
	        arr1.selectionSort(); // Сортировка прямым выбором
	        stopwatch.Stop();
	        Console.WriteLine("Длительность сортировки прямым выбором: " + (stopwatch.ElapsedMilliseconds).ToString() + " мс");
	        // arr1.display();
	        
	        arr1 = new ArraySort(arr);
	        stopwatch = new Stopwatch();
	        stopwatch.Start();
	        arr1.bubbleSort(); // Сортировка прямого обмена (Пузырьковая сортировка)
	        stopwatch.Stop();
	        Console.WriteLine("Длительность сортировки пузырьком: " + (stopwatch.ElapsedMilliseconds).ToString() + " мс");
	        // arr1.display();
	        
	        arr1 = new ArraySort(arr);
	        stopwatch = new Stopwatch();
	        stopwatch.Start();
	        arr1.shakerSort(); // Шейкерная сортировка (хождение зигзагом с сужением границ, модификация пузырьковой сортировки)
	        stopwatch.Stop();
	        Console.WriteLine("Длительность шейкерной сортировки: " + (stopwatch.ElapsedMilliseconds).ToString() + " мс");
	        // arr1.display();
	        
	        arr1 = new ArraySort(arr);
	        stopwatch = new Stopwatch();
	        stopwatch.Start();
	        arr1.shellSort(); // Сортировки Шелла (несколько последовательных сортировок с разной дальностью):
	        stopwatch.Stop();
	        Console.WriteLine("Длительность сортировки Шелла: " + (stopwatch.ElapsedMilliseconds).ToString() + " мс");
	        // arr1.display();
	        
	        Console.Write("Press any key to continue . . . ");
			Console.ReadKey(true);
		}
	}
}