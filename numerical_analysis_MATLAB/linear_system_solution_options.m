% Generate matrices with various condition numbers
% and solve a linear system using
% (1) Gaussian elimination with partial pivoting (A\b),
% (2) A inverse (inv(A)), and
% (3) Cramer's rule (using det(A))
%
% For each method, compute relative error ||x-xtrue||/||xtrue||
% and relative residual ||b-Ax||/(||A|| ||x||)
n = 20; % Problem size
for i=0:4:16,
condno = 10^i;
A = matgen(n, condno); % Matrix with cond no 10^i
xtrue = randn(n,1); % Set random true solution
b = A*xtrue; % Set right-hand side
x_ge = A\b; % Solution using GE
x_inv = inv(A)*b; % Solution using A inverse
detA = det(A); % Solve using Cramer's rule
for j=1:n,
Aj = A;
Aj(:,j) = b;
x_cramer(j,1) = det(Aj)/detA;
end;
% Compute relative errors.
xtrue_norm = norm(xtrue);
relerr_ge = norm(xtrue-x_ge)/xtrue_norm;
relerr_inv = norm(xtrue-x_inv)/xtrue_norm;
relerr_cramer = norm(xtrue-x_cramer)/xtrue_norm;
% Compute relative residuals.
3
A_norm = norm(A);
relres_ge = norm(b - A*x_ge)/(A_norm*norm(x_ge));
relres_inv = norm(b - A*x_inv)/(A_norm*norm(x_inv));
relres_cramer = norm(b - A*x_cramer)/(A_norm*norm(x_cramer));
% Print results.
fprintf('Condition number: %e \n',condno)
fprintf(' Rel err and res for GE : %e %e \n',relerr_ge, relres_ge)
fprintf(' Rel err and res for inv(A) : %e %e \n',relerr_inv, relres_inv)
fprintf(' Rel err and res for Cramer : %e %e \n',relerr_cramer, relres_cramer)
fprintf('\n')
end;
function A = matgen(n, condno)
% Generate an n by n random matrix with 2-norm condition number condno.
% First generate two random orthogonal matrices U and V.
[U,R] = qr(randn(n,n));
[V,R] = qr(randn(n,n));
% Now generate the diagonal matrix of singular values ranging from
% 1 to 1/condno.
Sigma = zeros(n,n);
for i=1:n, Sigma(i,i) = condno^(-(i-1)/(n-1)); end;
% Now form A.
A = U*Sigma*V';
end