function plotDecisionBoundaryDegree(theta, X, y, degree, X_orig)
%PLOTDECISIONBOUNDARYDEGREE Plots decision boundary with specified polynomial degree
%   plotDecisionBoundaryDegree(theta, X, y, degree, X_orig) plots data and decision boundary
%   using polynomial features of specified degree
%   X_orig - original 2D features for plotting

% Plot Data (use original 2D features)
if nargin < 5
    % If X_orig not provided, try to extract from X
    if size(X, 2) > 2
        X_orig = X(:, 2:3);
    else
        X_orig = X;
    end
end
plotData(X_orig, y);
hold on

if size(X, 2) <= 3
    % Only need 2 points to define a line, so choose two endpoints
    plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

    % Calculate the decision boundary line
    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));

    % Plot, and adjust axes for better viewing
    plot(plot_x, plot_y)
    
    % Legend, specific for the exercise
    legend('Admitted', 'Not admitted', 'Decision Boundary')
    axis([30, 100, 30, 100])
else
    % Here is the grid range
    u = linspace(-1, 1.5, 50);
    v = linspace(-1, 1.5, 50);

    z = zeros(length(u), length(v));
    % Evaluate z = theta*x over the grid using mapFeatureDegree
    for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = mapFeatureDegree(u(i), v(j), degree)*theta;
        end
    end
    z = z'; % important to transpose z before calling contour

    % Plot z = 0
    % Notice you need to specify the range [0, 0]
    contour(u, v, z, [0, 0], 'LineWidth', 2)
end
hold off

end

