
clear; close all; clc

data = load('ex2data2.txt');
X_orig = data(:, [1, 2]); y = data(:, 3);

degree_values = [1, 2, 3, 4, 5, 6];

fprintf('Тестирование разных degree:\n');
fprintf('===========================\n\n');

lambda = 1; 

for degree = degree_values
    X = mapFeatureDegree(X_orig(:,1), X_orig(:,2), degree);
    
    initial_theta = zeros(size(X, 2), 1);
    
    [cost, grad] = costFunctionReg(initial_theta, X, y, lambda);
    
    num_features = size(X, 2);
    fprintf('\ndegree = %d (Features = %2d):\n', degree, num_features);
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
    plotDecisionBoundaryDegree(theta, X, y, degree, X_orig);
    hold on;
    title(sprintf('degree = %d, lambda = %g, Accuracy = %.2f%%', degree, lambda, accuracy));
    xlabel('Microchip Test 1');
    ylabel('Microchip Test 2');
    legend('y = 1', 'y = 0', 'Decision boundary');
    hold off;
    pause;
end

