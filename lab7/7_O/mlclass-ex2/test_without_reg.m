
clear; close all; clc

data = load('ex2data2.txt');
X_orig = data(:, [1, 2]); y = data(:, 3);

X = mapFeature(X_orig(:,1), X_orig(:,2));

initial_theta = zeros(size(X, 2), 1);

lambda = 0; 

fprintf('Тестирование БЕЗ регуляризации (lambda = 0):\n');
fprintf('============================================\n\n');

[cost, grad] = costFunctionReg(initial_theta, X, y, lambda);
fprintf('Initial cost: %f\n', cost);
fprintf('Initial gradient norm: %f\n', norm(grad));
fprintf('First 5 gradient elements: ');
fprintf('%f ', grad(1:min(5, length(grad))));
fprintf('\n\n');

options = optimset('GradObj', 'on', 'MaxIter', 400);
[theta, J] = fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

[~, grad_final] = costFunctionReg(theta, X, y, lambda);

p = predict(theta, X);
accuracy = mean(double(p == y)) * 100;

fprintf('Final cost: %f\n', J);
fprintf('Final gradient norm: %f\n', norm(grad_final));
fprintf('Train Accuracy: %.2f%%\n', accuracy);

plotDecisionBoundary(theta, X, y);
hold on;
title(sprintf('БЕЗ регуляризации (lambda = 0), Accuracy = %.2f%%', accuracy));
xlabel('Microchip Test 1');
ylabel('Microchip Test 2');
legend('y = 1', 'y = 0', 'Decision boundary');
hold off;

