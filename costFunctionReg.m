function [J, grad] = costFunctionReg(theta, X, y, lambda)

    m = length(y); % number of training examples

    J = 0;
    grad = zeros(size(theta));
    
    sig = sigmoid(X * theta);   % hypothesis logistic regression
    reg_term = sum(theta(2:end) .^ 2) * lambda / (2 * m);
    
    J = mean((-y .* log(sig)) - ((1 - y) .* log(1 - sig))) + reg_term;
    
    theta_reg = theta;
    theta_reg(1) = 0;

    grad = (X' * (sig - y) ./ m) + theta_reg * lambda / m;

end
