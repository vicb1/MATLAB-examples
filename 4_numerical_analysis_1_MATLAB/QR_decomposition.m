m = 50; n = 12; % 50 points, poly of degree 11
t = linspace(0,1,50); % equally spaced points between 0 and 1
A = vander(t); A = fliplr(A); % Vandermonde matrix
A = A(:,1:n); % Take only the first n columns
b = cos(4*t'); % Right-hand side vector
x_normal = (A'*A)\(A'*b); % Solve using normal equations.
[Q,R] = qr(A,0); % Reduced QR decomposition.
x_qr = R\(Q'*b);
x_backslash = A\b; % Solve using backslash.
[U,Sigma,V] = svd(A,0); % Reduced SVD.
Vpx = Sigma\(U'*b); % V'*x
x_svd = V*Vpx;
format long e % Print results.
[x_normal, x_qr]
[x_backslash, x_svd]