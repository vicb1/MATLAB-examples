[U,X] = qr(randn(50));
[V,X] = qr(randn(50));
S = diag(sort(rand(50,1),'descend'));
A = U*S*V;
[U2,S2,V2] = svd(A);

for j=1:50,
if U2(:,j)'*U(:,j) < 0, % The signs are different for the jth column.
U2(:,j) = -U2(:,j); V2(:,j) = -V2(:,j); % Change them to match.
end;
end;

diffU = norm(U2-U)
diffV = norm(V2-V)
diffS = norm(S2-S)/norm(S)
diffA = norm(A - U2*S2*V2')/norm(A)
condition_number_of_A = cond(A)