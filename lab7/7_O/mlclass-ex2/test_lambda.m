clear; close all; clc

data = load('ex2data2.txt');
X = data(:, [1, 2]); y = data(:, 3);

X = mapFeature(X(:,1), X(:,2));
initial_theta = zeros(size(X, 2), 1);

lambda_values = [0, 0.01, 0.1, 1, 10, 100];

fprintf('Тестирование разных lambda:\n');
fprintf('===========================\n\n');

for lambda = lambda_values
    [cost, grad] = costFunctionReg(initial_theta, X, y, lambda);
    
    fprintf('\nlambda = %6.2f:\n', lambda);
    fprintf('  Initial cost: %f\n', cost);
    fprintf('  Initial gradient norm: %f\n', norm(grad));
    fprintf('  First 5 gradient elements: ');
    fprintf('%f ', grad(1:min(5, length(grad))));
    fprintf('\n');
    
    options = optimset('GradObj', 'on', 'MaxIter', 400);
    [theta, J] = fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);
    
    [~, grad_final] = costFunctionReg(theta, X, y, lambda);
    
    p = predict(theta, X);
    accuracy = mean(double(p == y)) * 100;
    
    fprintf('  Final cost: %f\n', J);
    fprintf('  Final gradient norm: %f\n', norm(grad_final));
    fprintf('  Accuracy: %6.2f%%\n', accuracy);
    
    figure;
    plotDecisionBoundary(theta, X, y);
    hold on;
    title(sprintf('lambda = %g, Accuracy = %.2f%%', lambda, accuracy));
    xlabel('Microchip Test 1');
    ylabel('Microchip Test 2');
    legend('y = 1', 'y = 0', 'Decision boundary');
    hold off;
    pause;
end

