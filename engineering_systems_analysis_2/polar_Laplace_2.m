clear all, close all, clc
dx = 0.01;
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
c = 100;
fourier = zeros([2, c+1]);
fourier(1,1) = A0;
fourier(2,1) = 0;
inc = zeros([1, c+1]);
for n = 1:c
    An = (1/L)*sum(f.*cos(n*pi*x/L))*dx;
    Bn = (1/L)*sum(f.*sin(n*pi*x/L))*dx;
    fourier(1,(n+1)) = An;
    fourier(2,(n+1)) = Bn;
    inc(n+1) = n;
end
figure(1)
stem(inc,fourier(1,:))
hold on
stem(inc,fourier(2,:))
legend('a_n values','b_n values')
xlabel('mode number')
ylabel('magnitude')