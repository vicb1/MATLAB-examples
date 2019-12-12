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
fourier = zeros(size(x));
fourier(:) = Ao;
n = 10;
for c = 1:n
An = (1/R)*sum(f.*cos(c*pi*x/R))*dx;
Bn = (1/R)*sum(f.*sin(c*pi*x/R))*dx;
fourier = fourier + (An).*cos(c*pi.*x./R) + (Bn).*sin(c*pi.*x./R);
end
figure
plot(x,f,'k')
hold on
plot(x,fourier,'r--')
legend('true square wave','fourier representation')
xlabel('x')
ylabel('f(x)')