% Логистическая регрессия с регуляризацией
clear; close all; clc

% загрузка данных
data = load('ex2data2.txt');
X = data(:, [1, 2]); y = data(:, 3);

% визуализация данных
plotData(X, y);
hold on;
xlabel('Microchip Test 1')
ylabel('Microchip Test 2')
legend('y = 1', 'y = 0')
hold off;

% полиномиальные признаки
X = mapFeature(X(:,1), X(:,2));

% начальные параметры
initial_theta = zeros(size(X, 2), 1);

% параметр регуляризации
lambda = 1;

% начальная стоимость
[cost, grad] = costFunctionReg(initial_theta, X, y, lambda);
fprintf('Cost at initial theta (zeros): %f\n', cost);

% оптимизация
options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta, J, exit_flag] = fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

% граница решения
plotDecisionBoundary(theta, X, y);
hold on;
title(sprintf('lambda = %g', lambda))
xlabel('Microchip Test 1')
ylabel('Microchip Test 2')
legend('y = 1', 'y = 0', 'Decision boundary')
hold off;

% точность
p = predict(theta, X);
fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
