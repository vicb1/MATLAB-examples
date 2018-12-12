imagedemo % Generate original picture.
print -depsc original.eps % Print it to a file.
[U,Sigma,V] = svd(X); % Compute the SVD of X.
Vp = V'; % Store V'.
X1 = U(:,1)*Sigma(1,1)*Vp(1,:); % Rank 1 approximation to X.
X10 = U(:,1:10)*Sigma(1:10,1:10)*Vp(1:10,:); % Rank 10 approximation to X.
X50 = U(:,1:50)*Sigma(1:50,1:50)*Vp(1:50,:); % Rank 50 approximation to X.
X100 = U(:,1:100)*Sigma(1:100,1:100)*Vp(1:100,:); % Rank 100 approximation to X.
figure(2) % Go to a new figure box.
subplot(2,2,1) % Put 4 plots on one page.
imagesc(X1); colormap(map); axis off % Image from rank 1 approximation.
title('Rank 1')
subplot(2,2,2)
imagesc(X10); colormap(map); axis off % Image from rank 10 approximation.
title('Rank 10')
subplot(2,2,3)
imagesc(X50); colormap(map); axis off % Image from rank 50 approximation.
title('Rank 50')
subplot(2,2,4)
imagesc(X100); colormap(map); axis off % Image from rank 100 approximation.
title('Rank 100')
print -depsc approximations.eps