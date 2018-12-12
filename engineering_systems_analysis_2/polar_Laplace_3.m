clear all, close all, clc
dx = 0.001;
L = 2;
x = (-L):dx:L;
f = zeros(size(x));
for i = 0:(2*L/dx)
    x_check = -2 + i*dx;
    if x_check<(-1)
        f(i+1) = 0;
    elseif x_check<(0)
        f(i+1) = 1+x(i+1);
    elseif x_check<(1)
        f(i+1) = 1-x(i+1);    
    else
        f(i+1) = 0;
    end
end
A0 = 1/(2*L);
approx = ones(size(x));
approx = approx*A0;
m = 2;
for n = 1:m
    An = (1/L)*sum(f.*cos(n*pi*x/L))*dx;
    Bn = (1/L)*sum(f.*sin(n*pi*x/L))*dx;
    approx = approx + (An).*cos(n*pi.*x./L) + (Bn).*sin(n*pi.*x./L);
end
figure(1)
plot(x,f,'k')
hold on
plot(x,approx,'r--')
legend('true triangle wave','fourier representation')
xlabel('x')
ylabel('f(x)')