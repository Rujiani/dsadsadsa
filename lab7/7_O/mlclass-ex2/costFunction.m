function [J, grad] = costFunction(theta, X, y)
m = length(y);

% гипотеза
h = sigmoid(X * theta);

% функция стоимости
J = -(1/m) * (y' * log(h) + (1 - y)' * log(1 - h));

% градиент
grad = (1/m) * (X' * (h - y));
end
