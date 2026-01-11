function J = computeCostMulti(X, y, theta)
% Та же функция стоимости для нескольких признаков

m = length(y);
h = X * theta;
J = (1 / (2 * m)) * sum((h - y) .^ 2);

end
