function [theta] = normalEqn(X, y)
% Нормальное уравнение: theta = (X'*X)^(-1) * X' * y

theta = pinv(X' * X) * X' * y;

end
