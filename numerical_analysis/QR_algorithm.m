% QR algorithm
% Set matrix.
n = 10;
A = 2*eye(n,n);
for i=1:n-1, A(i,i+1)=-1; A(i+1,i)=-1; end;
4
% Iterate until matrix is close to diagonal.
Ak = A; k = 0;
subdiag(:,1) = diag(Ak,-1); % Keep track of size of subdiag
while norm(Ak-diag(diag(Ak)),'fro') > 1.e-6,
[Qk,Rk] = qr(Ak);
Ak = Rk*Qk;
k = k+1;
subdiag(:,k+1) = diag(Ak,-1);
end;
evals = diag(Ak), k % Print out approx evals
% and no. of iterations
% Print out ratios of subdiagonal entries over a few steps.
% Also print out eigenvalue ratios.
subdiag_ratios = abs(subdiag(:,k-5:k) ./ subdiag(:,k-6:k-1))
evals_sorted = sort(abs(diag(Ak)),'descend');
eval_ratios = evals_sorted(2:n) ./ evals_sorted(1:n-1)

% First run QR algorithm above
% Then run this code using inverse iteration
% to compute the eigenvector corresponding to
% the fifth eigenvalue.

s = Ak(5,5); % Fifth diagonal entry of final matrix from QR.
w = randn(n,1); % Random initial vector.
yk = w/norm(w);
k = 0;
resk = norm(A*yk - yk*s);
while resk > 1.e-6 % Iterate until resid <= 1.e-6
yktilde = (A - s*eye(n,n))\yk;
yk = yktilde/norm(yktilde);
k = k+1;
resk = norm(A*yk - yk*s);

end;
% Print results.
s, yk, k