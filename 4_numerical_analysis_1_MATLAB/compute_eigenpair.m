% Power method for computing eigenvalue of largest magnitude
% and corresponding eigenvector
% Set matrix.
n = 10;
A = 2*eye(n,n);
for i=1:n-1, A(i,i+1)=-1; A(i+1,i)=-1; end;
% Set random initial vector.
w = randn(n,1);
yk = w/norm(w);
eval_approx = [];
% Do first step to see if yk is close to an eigenvector
yktilde = A*yk;
lambdak = yk'*yktilde;
eval_approx = [eval_approx; lambdak];
resk = norm(yktilde - lambdak*yk);
% Iterate until residual is small
while resk > 1.e-6,
yk = yktilde/norm(yktilde);
yktilde = A*yk;
lambdak = yk'*yktilde;

eval_approx = [eval_approx; lambdak];
resk = norm(yktilde - lambdak*yk);
end;
lambdak, yk % Print out eigenpair