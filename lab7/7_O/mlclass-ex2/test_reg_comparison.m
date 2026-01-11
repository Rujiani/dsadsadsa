clear; close all; clc

data = load('ex2data2.txt');
X_orig = data(:, [1, 2]); y = data(:, 3);

X = mapFeature(X_orig(:,1), X_orig(:,2));
initial_theta = zeros(size(X, 2), 1);

fprintf('Сравнение: БЕЗ регуляризации vs С регуляризацией\n');
fprintf('================================================\n\n');

% ТЕСТ 1: БЕЗ регуляризации (lambda = 0)
lambda = 0;

fprintf('1. БЕЗ регуляризации (lambda = 0):\n');
fprintf('-----------------------------------\n');

[cost, grad] = costFunctionReg(initial_theta, X, y, lambda);
fprintf('  Initial cost: %f\n', cost);
fprintf('  Initial gradient norm: %f\n', norm(grad));
fprintf('  First 5 gradient elements: ');
fprintf('%f ', grad(1:min(5, length(grad))));
fprintf('\n');

options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta_no_reg, J_no_reg] = fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

[~, grad_final_no_reg] = costFunctionReg(theta_no_reg, X, y, lambda);

p_no_reg = predict(theta_no_reg, X);
accuracy_no_reg = mean(double(p_no_reg == y)) * 100;

fprintf('  Final cost: %f\n', J_no_reg);
fprintf('  Final gradient norm: %f\n', norm(grad_final_no_reg));
fprintf('  Train Accuracy: %.2f%%\n\n', accuracy_no_reg);

% ТЕСТ 2: С регуляризацией (lambda = 1)
lambda = 1;

fprintf('2. С регуляризацией (lambda = 1):\n');
fprintf('---------------------------------\n');

[cost, grad] = costFunctionReg(initial_theta, X, y, lambda);
fprintf('  Initial cost: %f\n', cost);
fprintf('  Initial gradient norm: %f\n', norm(grad));
fprintf('  First 5 gradient elements: ');
fprintf('%f ', grad(1:min(5, length(grad))));
fprintf('\n');

options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta_reg, J_reg] = fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

[~, grad_final_reg] = costFunctionReg(theta_reg, X, y, lambda);

p_reg = predict(theta_reg, X);
accuracy_reg = mean(double(p_reg == y)) * 100;

fprintf('  Final cost: %f\n', J_reg);
fprintf('  Final gradient norm: %f\n', norm(grad_final_reg));
fprintf('  Train Accuracy: %.2f%%\n\n', accuracy_reg);

% Сравнение
fprintf('СРАВНЕНИЕ:\n');
fprintf('----------\n');
fprintf('  Без регуляризации:  Accuracy = %.2f%%,  Cost = %f\n', accuracy_no_reg, J_no_reg);
fprintf('  С регуляризацией:  Accuracy = %.2f%%,  Cost = %f\n', accuracy_reg, J_reg);
fprintf('\n');
fprintf('  Разница в точности: %.2f%%\n', accuracy_no_reg - accuracy_reg);
fprintf('  Разница в стоимости: %f\n', J_no_reg - J_reg);

% Графики
fprintf('\nНажмите Enter для показа первого графика (БЕЗ регуляризации)...\n');
pause;

figure;
plotDecisionBoundary(theta_no_reg, X, y);
hold on;
title(sprintf('БЕЗ регуляризации (lambda = 0)\nAccuracy = %.2f%%', accuracy_no_reg));
xlabel('Microchip Test 1');
ylabel('Microchip Test 2');
legend('y = 1', 'y = 0', 'Decision boundary');
hold off;

fprintf('Первый график показан. Нажмите Enter для показа второго графика (С регуляризацией)...\n');
pause;

figure;
plotDecisionBoundary(theta_reg, X, y);
hold on;
title(sprintf('С регуляризацией (lambda = 1)\nAccuracy = %.2f%%', accuracy_reg));
xlabel('Microchip Test 1');
ylabel('Microchip Test 2');
legend('y = 1', 'y = 0', 'Decision boundary');
hold off;

fprintf('Второй график показан. Нажмите Enter для завершения...\n');
pause;

