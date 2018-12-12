clear all; close all; clc
base_time = zeros(1,1000);
matrix_size = 100:300;
time_FFT = zeros(size(matrix_size));
N_FFT = zeros(size(matrix_size));
i = 1;
for k = 1:(size(matrix_size,2))
    N = 100 + (k-1);
    data = rand(1,N); 
    n = 1; 
    while n <= 1000
        tic
        FFT = fft(data);
        base_time(n) = toc;
        n = n+1;
    end
    time_avg_FFT = mean(base_time);
    time_FFT(k) = time_avg_FFT;
    N_FFT(k) = N;
    if isprime(N) == 1
        Prime_time(i) = time_avg_FFT;
        Prime_N_vector(i) = N;
        i = i + 1;
    end
end
figure
plot(N_FFT,time_FFT,'k')
xlabel('N');ylabel('computation time, seconds')
title('FFT computation time, prime N values are circled');
hold on
plot(Prime_N_vector,Prime_time,'or')
legend('FFT','prime values')