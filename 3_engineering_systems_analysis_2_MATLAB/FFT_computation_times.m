clear all; close all; clc
%FTT
base_time = zeros(1,1000);
time_FFT = zeros(1,15);
N_vector_FFT = zeros(1,15);
for k = 2:16
    N = 2^k;
    data = rand(1,N);
    i = 1;
    while i <= 1000 
        tic
        FFT = fft(data);
        base_time(i) = toc;
        i = i+1;
    end
    time_avgFFT = mean(base_time);
    time_FFT(k-1) = time_avgFFT;
    N_vector_FFT(k-1) = N;
end
figure
loglog(N_vector_FFT,time_FFT,'.-k')
xlabel('N');ylabel('computation time, seconds')
title('FFT  computation time');
%DFT
base_time = zeros(1,1000);
time_DFT = zeros(1,10);
N_vector_DFT = zeros(1,10);
for k = 2:11
    N = 2^k;
    data = rand(N,1);
    w = exp(-1i*2*pi/N);
    DFT = zeros(N);
    coef_DFT = zeros(N,1);
    i = 1;
    for n = 1:N
        for j = 1:N
            DFT(n,j) = w^((n-1)*(j-1));
        end
    end
    while i <= 1000
        tic
        coef_DFT = DFT*data;
        base_time(i) = toc;
        i = i + 1;
    end
    time_avgDFT = mean(base_time);
    time_DFT(k-1) = time_avgDFT;
    N_vector_DFT(k-1) = N;
end
figure
loglog(N_vector_DFT,time_DFT,'.-k')
xlabel('N');ylabel('computation time, seconds')
title('DFT computation time');
figure
%FFT and DFT
loglog(N_vector_FFT,time_FFT,'.-k',...
N_vector_DFT,time_DFT,'.-r')
xlabel('N');ylabel('computation time, seconds')
title('FFT vs. DFT computation time');
legend('FFT','DFT')