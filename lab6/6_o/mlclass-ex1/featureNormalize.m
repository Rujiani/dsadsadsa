function [X_norm, mu, sigma] = featureNormalize(X)
% Нормализация: x_norm = (x - mean) / std

mu = mean(X);
sigma = std(X);
X_norm = (X - mu) ./ sigma;

end
