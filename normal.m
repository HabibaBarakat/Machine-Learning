function N = normal(X, y)
N = inv(X' * X) * X' * y;
end