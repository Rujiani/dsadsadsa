function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
% Градиентный спуск для обучения theta

m = length(y);
J_history = zeros(num_iters, 1);

for iter = 1:num_iters
    h = X * theta;
    theta = theta - (alpha / m) * (X' * (h - y));
    J_history(iter) = computeCost(X, y, theta);
end

end
