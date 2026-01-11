% Логистическая регрессия без регуляризации
clear; close all; clc

% загрузка данных
data = load('ex2data1.txt');
X = data(:, [1, 2]); y = data(:, 3);

% визуализация данных
plotData(X, y);
hold on;
xlabel('Exam 1 score')
ylabel('Exam 2 score')
legend('Admitted', 'Not admitted')
hold off;
pause;

% добавляем столбец единиц
[m, n] = size(X);
X = [ones(m, 1) X];

% начальные параметры
initial_theta = zeros(n + 1, 1);

% вычисляем начальную стоимость и градиент
[cost, grad] = costFunction(initial_theta, X, y);
fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Gradient at initial theta (zeros):\n');
fprintf(' %f \n', grad);
pause;

% оптимизация с помощью fminunc
options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta, cost] = fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('theta:\n');
fprintf(' %f \n', theta);

% граница решения
plotDecisionBoundary(theta, X, y);
hold on;
xlabel('Exam 1 score')
ylabel('Exam 2 score')
legend('Admitted', 'Not admitted')
hold off;
pause;

% предсказание для студента с баллами 45 и 85
prob = sigmoid([1 45 85] * theta);
fprintf('For a student with scores 45 and 85, admission probability: %f\n', prob);

% точность на обучающей выборке
p = predict(theta, X);
fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
