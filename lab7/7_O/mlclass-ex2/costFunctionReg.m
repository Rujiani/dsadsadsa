function [J, grad] = costFunctionReg(theta, X, y, lambda)
m = length(y);

% гипотеза
h = sigmoid(X * theta);

% функция стоимости с регуляризацией (theta(1) не регуляризируем)
J = -(1/m) * (y' * log(h) + (1 - y)' * log(1 - h)) + (lambda/(2*m)) * (theta(2:end)' * theta(2:end));

% градиент с регуляризацией
grad = (1/m) * (X' * (h - y));
grad(2:end) = grad(2:end) + (lambda/m) * theta(2:end);
end
