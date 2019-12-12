% Modified FROM Spectral Methods in MATLAB by Trefethen
% p5.m  - repetition of p4.m via FFT
close all, clear all, clc
N = 50;
dx = 2*pi/N;
x = dx*(1:N);
f = max(0,1-abs(x-pi)/2);
fhat = fft(f);
k = [-N/2:N/2-1];
k = fftshift(k);  % important because fft has weird ordering
dfhat = i*k .* fhat;
df = real(ifft(dfhat));

subplot(2,1,1)
plot(x,f,'k')
title('Function')
subplot(2,1,2)
plot(x,df,'k')
title('Derivative of Function')
xlabel('Spatial variable, x')
