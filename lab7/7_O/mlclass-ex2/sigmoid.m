function g = sigmoid(z)
% сигмоида: g(z) = 1 / (1 + e^(-z))
g = 1 ./ (1 + exp(-z));
end
