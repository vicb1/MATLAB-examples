clear all, close all, clc

dx = 0.005;
L = 1;
x = dx:dx:L;

f = ones(size(x));
f(1:length(f)/2) = 0*f(1:length(f)/2);
%
f = sin(x);
%
% f = (x-pi).^2;
%
% f1 = (1:1:25)/25;
% f2 = (25:-1:1)/25;
% f3 = -1*f1;
% f4 = -1*f2;
% f = [f1 f2 f3 f4 f1 f2 f3 f4];

fFS = zeros(size(x));

A0 = (2/L)*sum(f.*ones(size(x)))*dx;
for m=1:100
    fFS = A0/2;


    for k=1:m
        Ak = (2/L)*sum(f.*cos(2*pi*k*x/L))*dx;
        Bk = (2/L)*sum(f.*sin(2*pi*k*x/L))*dx;
        fFS = fFS + Ak*cos(2*k*pi*x/L) + Bk*sin(2*k*pi*x/L);
    end
    
    plot(x,f,'k')
    hold on
    plot(x,fFS,'r--')
    
    pause(0.1)
end