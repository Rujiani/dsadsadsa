%% Эксперимент: Определение оптимального количества нейронов в скрытом слое
% Этот скрипт тестирует различные размеры скрытого слоя и находит оптимальное значение

clear ; close all; clc

% Suppress MATLAB compatibility warnings
warning('off', 'Octave:matlab-incompatible');

%% Параметры эксперимента
input_layer_size  = 400;  % 20x20 Input Images of Digits
num_labels = 10;          % 10 labels, from 1 to 10

% Различные размеры скрытого слоя для тестирования
hidden_layer_sizes = [5, 10, 15, 20, 25, 30, 40, 50];

% Параметры обучения
lambda = 1;              % Параметр регуляризации
max_iter = 25;           % Количество итераций обучения

%% Загрузка данных
fprintf('Загрузка данных...\n');
load('ex4data1.mat');
m = size(X, 1);

% Разделение данных на обучающую (80%) и валидационную (20%) выборки
fprintf('Разделение данных на обучающую и валидационную выборки...\n');
rand_indices = randperm(m);
train_size = round(0.8 * m);

X_train = X(rand_indices(1:train_size), :);
y_train = y(rand_indices(1:train_size), :);

X_val = X(rand_indices(train_size+1:end), :);
y_val = y(rand_indices(train_size+1:end), :);

fprintf('Обучающая выборка: %d примеров\n', size(X_train, 1));
fprintf('Валидационная выборка: %d примеров\n', size(X_val, 1));

%% Инициализация результатов
results = [];
train_accuracies = [];
val_accuracies = [];

fprintf('\n========================================\n');
fprintf('Начало экспериментов с различными размерами скрытого слоя\n');
fprintf('========================================\n\n');

%% Эксперименты с различными размерами скрытого слоя
for i = 1:length(hidden_layer_sizes)
    hidden_layer_size = hidden_layer_sizes(i);
    
    fprintf('\n--- Эксперимент %d/%d: Скрытый слой = %d нейронов ---\n', ...
            i, length(hidden_layer_sizes), hidden_layer_size);
    
    % Инициализация весов
    initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
    initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
    
    % Развертывание параметров
    initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
    
    % Создание функции стоимости
    costFunction = @(p) nnCostFunction(p, ...
                                       input_layer_size, ...
                                       hidden_layer_size, ...
                                       num_labels, X_train, y_train, lambda);
    
    % Обучение нейронной сети
    fprintf('Обучение сети...\n');
    options = optimset('MaxIter', max_iter);
    % Suppress warnings during training
    warning('off', 'Octave:matlab-incompatible');
    [nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
    warning('on', 'Octave:matlab-incompatible');
    
    % Восстановление матриц весов
    Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                     hidden_layer_size, (input_layer_size + 1));
    
    Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                     num_labels, (hidden_layer_size + 1));
    
    % Вычисление точности на обучающей выборке
    pred_train = predict(Theta1, Theta2, X_train);
    train_acc = mean(double(pred_train == y_train)) * 100;
    train_accuracies = [train_accuracies; train_acc];
    
    % Вычисление точности на валидационной выборке
    pred_val = predict(Theta1, Theta2, X_val);
    val_acc = mean(double(pred_val == y_val)) * 100;
    val_accuracies = [val_accuracies; val_acc];
    
    % Сохранение результатов
    results = [results; hidden_layer_size, train_acc, val_acc, cost(end)];
    
    fprintf('Точность на обучающей выборке: %.2f%%\n', train_acc);
    fprintf('Точность на валидационной выборке: %.2f%%\n', val_acc);
    fprintf('Финальная стоимость: %.6f\n', cost(end));
end

%% Вывод результатов
fprintf('\n\n========================================\n');
fprintf('РЕЗУЛЬТАТЫ ЭКСПЕРИМЕНТОВ\n');
fprintf('========================================\n');
fprintf('%-10s %-20s %-25s %-15s\n', 'Скрытый', 'Точность (обучение)', 'Точность (валидация)', 'Стоимость');
fprintf('%-10s %-20s %-25s %-15s\n', 'слой', '(%)', '(%)', '');
fprintf('--------------------------------------------------------\n');

for i = 1:size(results, 1)
    fprintf('%-10d %-20.2f %-25.2f %-15.6f\n', ...
            results(i, 1), results(i, 2), results(i, 3), results(i, 4));
end

%% Поиск оптимального размера скрытого слоя
[best_val_acc, best_idx] = max(val_accuracies);
best_hidden_size = hidden_layer_sizes(best_idx);

fprintf('\n========================================\n');
fprintf('ОПТИМАЛЬНЫЙ РАЗМЕР СКРЫТОГО СЛОЯ\n');
fprintf('========================================\n');
fprintf('Оптимальное количество нейронов: %d\n', best_hidden_size);
fprintf('Точность на валидационной выборке: %.2f%%\n', best_val_acc);
fprintf('Точность на обучающей выборке: %.2f%%\n', train_accuracies(best_idx));

%% Визуализация результатов
figure;
plot(hidden_layer_sizes, train_accuracies, '-o', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
plot(hidden_layer_sizes, val_accuracies, '-s', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Количество нейронов в скрытом слое');
ylabel('Точность (%)');
title('Зависимость точности от размера скрытого слоя');
legend('Обучающая выборка', 'Валидационная выборка', 'Location', 'best');
grid on;

% Отметка оптимального значения
hold on;
plot(best_hidden_size, best_val_acc, 'r*', 'MarkerSize', 15, 'LineWidth', 2);
text(best_hidden_size + 1, best_val_acc + 0.5, ...
     sprintf('Оптимум: %d нейронов', best_hidden_size), ...
     'FontSize', 10, 'Color', 'red');

fprintf('\nГрафик сохранен.\n');

%% Сохранение результатов в файл
fprintf('\nСохранение результатов в файл results_hidden_layer.txt...\n');
fid = fopen('results_hidden_layer.txt', 'w');
fprintf(fid, 'РЕЗУЛЬТАТЫ ЭКСПЕРИМЕНТОВ: ОПТИМАЛЬНЫЙ РАЗМЕР СКРЫТОГО СЛОЯ\n');
fprintf(fid, '===========================================================\n\n');
fprintf(fid, '%-10s %-20s %-25s %-15s\n', 'Скрытый', 'Точность (обучение)', 'Точность (валидация)', 'Стоимость');
fprintf(fid, '%-10s %-20s %-25s %-15s\n', 'слой', '(%%)', '(%%)', '');
fprintf(fid, '--------------------------------------------------------\n');

for i = 1:size(results, 1)
    fprintf(fid, '%-10d %-20.2f %-25.2f %-15.6f\n', ...
            results(i, 1), results(i, 2), results(i, 3), results(i, 4));
end

fprintf(fid, '\n========================================\n');
fprintf(fid, 'ОПТИМАЛЬНЫЙ РАЗМЕР СКРЫТОГО СЛОЯ\n');
fprintf(fid, '========================================\n');
fprintf(fid, 'Оптимальное количество нейронов: %d\n', best_hidden_size);
fprintf(fid, 'Точность на валидационной выборке: %.2f%%\n', best_val_acc);
fprintf(fid, 'Точность на обучающей выборке: %.2f%%\n', train_accuracies(best_idx));
fclose(fid);

fprintf('Результаты сохранены в results_hidden_layer.txt\n');

