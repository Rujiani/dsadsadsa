function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%

% Add bias unit (column of ones) to input layer
X = [ones(m, 1) X];

% Layer 1 -> Layer 2 (Hidden Layer)
% X is m x 401, Theta1 is 25 x 401
% z2 = X * Theta1' gives m x 25 (each row is z for one example)
z2 = X * Theta1';
a2 = sigmoid(z2);

% Add bias unit to hidden layer
a2 = [ones(m, 1) a2];

% Layer 2 -> Layer 3 (Output Layer)
% a2 is m x 26, Theta2 is 10 x 26
% z3 = a2 * Theta2' gives m x 10 (each row contains output for each class)
z3 = a2 * Theta2';
a3 = sigmoid(z3);

% Find the class with the highest probability for each example
% max(..., [], 2) finds max along rows
% The second output is the index, which corresponds to the predicted class
[~, p] = max(a3, [], 2);





% =========================================================================


end
