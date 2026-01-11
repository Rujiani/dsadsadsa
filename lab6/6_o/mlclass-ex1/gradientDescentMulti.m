function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)
% Градиентный спуск для нескольких признаков

m = length(y);
J_history = zeros(num_iters, 1);

for iter = 1:num_iters
    h = X * theta;
    theta = theta - (alpha / m) * (X' * (h - y));
    J_history(iter) = computeCostMulti(X, y, theta);
end

end
