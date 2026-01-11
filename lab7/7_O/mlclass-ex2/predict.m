function p = predict(theta, X)
% если sigmoid(X*theta) >= 0.5 то p = 1, иначе p = 0
p = sigmoid(X * theta) >= 0.5;
end
