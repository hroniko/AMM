N = [25000;50000;100000;200000;400000;800000;1600000]; % Количество эл-в
T1 = [60;252;1137;4266;16971;81151;324984]; % Длительность сортировки прямыми вставками
T2 = [60;264;987;4130;16289;72132;336521]; % Длительность сортировки прямыми вставками с бисекцией
T3 = [1;4;8;15;31;71;129]; % Длительность быстрой сортировки с рекурсией
T4 = [0;1;1;1;3;3;9]; % Длительность быстрой сортировки без рекурсии
T5 = [206;862;3159;12886;51298;223241;882464]; % Длительность сортировки прямым выбором
T6 = [849;3582;14959;59691;239322;1089061;4022621]; % Длительность сортировки пузырьком
T7 = [624;2581;10289;40704;163079;701663;2730486]; % Длительность шейкерной сортировки
T8 = [18;79;335;1540;6882;32850;322625]; % Длительность сортировки Шелла

% 1)
set(0,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman'); % Настраиваем шрифты
set(0,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman'); 
figure; % figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); % Создаем холст
plot(N, T1, 'blue'); % График длительности сортировки прямыми вставками
title('Сортировка прямыми вставками'); % Название
xlabel('N, элементов'); ylabel('T, мс'); % Подписи на осях
grid on; % Включаем сетку

% 2)
set(0,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman'); 
figure;
plot(N, T2, 'blue');
title('Сортировка прямыми вставками с бисекцией');
xlabel('N, элементов'); ylabel('T, мс');
grid on;

% 3)
set(0,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman'); 
figure;
plot(N, T3, 'blue');
title('Быстрая сортировка с рекурсией');
xlabel('N, элементов'); ylabel('T, мс');
grid on;

% 4)
set(0,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman'); 
figure;
plot(N, T4, 'blue');
title('Быстрая сортировка без рекурсии');
xlabel('N, элементов'); ylabel('T, мс');
grid on;

% 5)
set(0,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman'); 
figure;
plot(N, T5, 'blue');
title('Сортировка прямым выбором');
xlabel('N, элементов'); ylabel('T, мс');
grid on;

% 6)
set(0,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman'); 
figure;
plot(N, T6, 'blue');
title('Сортировка пузырьком');
xlabel('N, элементов'); ylabel('T, мс');
grid on;

% 7)
set(0,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman'); 
figure;
plot(N, T7, 'blue');
title('Шейкерная сортировка');
xlabel('N, элементов'); ylabel('T, мс');
grid on;

% 8)
set(0,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman'); 
figure;
plot(N, T8, 'blue');
title('Сортировка Шелла');
xlabel('N, элементов'); ylabel('T, мс');
grid on;



% А потом можно вызвать cftool и аппроксимировать каждый график

% Подготавливаем данны для вывода графиков
x = 0:10000:1600000;
a = 8.62e-08; b = 2.027; f1 = a.*x.^b; % 1 insertionSort
a = 6.197e-09; b = 2.214; f2 = a.*x.^b; % 2 insertionSortBisection
a = 0.0001092;  b = 0.9796;  f3 = a.*x.^b; % 3 quickSort
a = 4.442e-06; b = 1.014; f4 = a.*x.^b; % 4 quickSortNonRecursive
a = 3.556e-07; b = 1.998; f5 = a.*x.^b; % 5 selectionSort
a = 4.902e-06; b = 1.92; f6 = a.*x.^b; % 6 bubbleSort
a = 1.491e-06; b = 1.977; f7 = a.*x.^b; % 7 shakerSort
a = 1.829e-15; b = 3.263; f8 = a.*x.^b; % 8 shellSort

% Строим графики
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman'); % Настраиваем шрифты
set(0,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); % Создаем холст
hold on;
plot(x, f1, 'LineWidth',3);
plot(x, f2, 'LineWidth',3);
plot(x, f3, 'LineWidth',3);
plot(x, f4, 'LineWidth',3);
plot(x, f5, 'LineWidth',3);
plot(x, f6, 'LineWidth',3);
plot(x, f7, 'LineWidth',3);
plot(x, f8, 'LineWidth',3);
title('Сравнение длительности сортировок (C++)'); % Название
legend('1) insertionSort','2) insertionSortBisection','3) quickSort','4) quickSortNonRecursive','5) selectionSort','6) bubbleSort', '7) shakerSort', '8) shellSort', 4);
% legend('1) quickSort','2) quickSortNonRecursive');
xlabel('N, элементов'); ylabel('T, мс'); % Подписи на осях
grid on; % Включаем сетку


% Строим графики 2
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman'); % Настраиваем шрифты
set(0,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); % Создаем холст
hold on;
% plot(x, f1, 'LineWidth',3);
% plot(x, f2, 'LineWidth',3);
plot(x, f3, 'LineWidth',3);
plot(x, f4, 'LineWidth',3);
% plot(x, f5, 'LineWidth',3);
% plot(x, f6, 'LineWidth',3);
% plot(x, f7, 'LineWidth',3);
% plot(x, f8, 'LineWidth',3);
title('Сравнение длительности сортировок (C++)'); % Название
% legend('1) insertionSort','2) insertionSortBisection','3) quickSort','4) quickSortNonRecursive','5) selectionSort','6) bubbleSort', '7) shakerSort', '8) shellSort', 4);
legend('1) quickSort','2) quickSortNonRecursive');
xlabel('N, элементов'); ylabel('T, мс'); % Подписи на осях
grid on; % Включаем сетку