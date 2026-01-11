function J = computeCost(X, y, theta)
% Функция стоимости J = (1/2m) * sum((h(x) - y)^2)

m = length(y);
h = X * theta;
J = (1 / (2 * m)) * sum((h - y) .^ 2);

end
