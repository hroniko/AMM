N = [25000;50000;100000;200000;400000;800000;1600000]; % Количество эл-в
T1 = [62;250;1046;4218;17172;80594;323906]; % Длительность сортировки прямыми вставками
T2 = [63;235;969;3954;16062;67485;314172]; % Длительность сортировки прямыми вставками с бисекцией
T3 = [0;0;0;15;32;62;141]; % Длительность быстрой сортировки с рекурсией
T4 = [0;0;0;0;0;16;62]; % Длительность быстрой сортировки без рекурсии
T5 = [594;2360;9469;38469;154203;625015;2504328]; % Длительность сортировки прямым выбором
T6 = [937;3750;14953;60250;242172;991860;4078844]; % Длительность сортировки пузырьком
T7 = [641;2578;10422;41687;168234;679578;2969610]; % Длительность шейкерной сортировки
T8 = [15;78;344;1594;6703;50640;232609]; % Длительность сортировки Шелла

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
a = 8.307e-08; b = 2.029; f1 = a.*x.^b; % 1 insertionSort
a = 6.626e-09; b = 2.204; f2 = a.*x.^b; % 2 insertionSortBisection
a = 1.04e-05;  b = 1.15;  f3 = a.*x.^b; % 3 quickSort
a = 4.604e-12; b = 2.116; f4 = a.*x.^b; % 4 quickSortNonRecursive
a = 9.201e-07; b = 2.004; f5 = a.*x.^b; % 5 selectionSort
a = 9.127e-07; b = 2.039; f6 = a.*x.^b; % 6 bubbleSort
a = 2.231e-07; b = 2.115; f7 = a.*x.^b; % 7 shakerSort
a = 2.661e-09; b = 2.247; f8 = a.*x.^b; % 8 shellSort

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
title('Сравнение длительности сортировок (Delphi 7)'); % Название
legend('1) insertionSort','2) insertionSortBisection','3) quickSort','4) quickSortNonRecursive','5) selectionSort','6) bubbleSort', '7) shakerSort', '8) shellSort', 4);
% legend('1) quickSort','2) quickSortNonRecursive');
xlabel('N, элементов'); ylabel('T, мс'); % Подписи на осях
grid on; % Включаем сетку