clear all; close all; clc
dx = 0.01;
R = 2;
x = (-R):dx:R;
f = zeros(size(x));
for i = 0:(2*R/dx)
x_new = -2 + i*dx;
if abs(x_new)<=1
f(i+1) = 1;
else
f(i+1) = 0;
end
end
Ao = (1/(2*R))*sum(f.*ones(size(x)))*dx;
n = 100;
fourier = zeros([2 (n+1)]);
fourier(1,1) = Ao;
fourier(2,1) = 0;
inc = zeros([1 n+1]);
for c = 1:n
An = (1/R)*sum(f.*cos(c*pi*x/R))*dx;
Bn = (1/R)*sum(f.*sin(c*pi*x/R))*dx;
fourier(1,(c+1)) = An;
fourier(2,(c+1)) = Bn;
inc(c+1) = c;
end
figure
stem(inc,fourier(1,:))
hold on
stem(inc,fourier(2,:))
legend('a_n values','b_n values')
xlabel('mode number')
ylabel('magnitude')