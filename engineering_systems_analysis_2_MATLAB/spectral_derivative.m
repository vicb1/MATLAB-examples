clear all, close all, clc

N = 101;
L = 8*pi;
dx = L/(N-1);
x = -L/2:dx:L/2-dx;
f = cos(x).*exp(-x.^2/25);
df = -(sin(x).*exp(-x.^2/25) + (2/25)*x.*cos(x).*exp(-x.^2/25));
Nx = max(size(f));
plot(x,df,'k','LineWidth',1.5)
hold on

%% Approximate derivative using finite Difference...
for k=1:length(df)-1
    dfFD(k) = (f(k+1)-f(k))/dx;
end
dfFD(end+1) = dfFD(end);
plot(x,dfFD,'b--')

%% Derivative using FFT (spectral derivative)
fhat = fft(f);
k = (2*pi/L)*[-Nx/2:Nx/2-1];
k = fftshift(k);  % important because fft has weird ordering
dfhat = i*k.*fhat;
dfspec = real(ifft(dfhat));
plot(x,dfspec,'r--')
xlabel('Spatial variable, x')
ylabel('Derivative of Function')
%% Plotting commands
axis([-L/2 L/2 -1 1])
legend('True Derivative','Finite Difference','FFT Derivative')