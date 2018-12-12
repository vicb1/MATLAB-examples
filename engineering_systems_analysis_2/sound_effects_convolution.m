clear all; close all; clc
% Input filters:
[closet,FS_clo] = audioread('FilterCloset.wav');
[echo,FS_echo] = audioread('FilterEcho.wav');
[hall,FS_hall] = audioread('FilterHall.wav');
[pool,FS_pool] = audioread('FilterPool.wav');

%[data,FS] = audioread('sound1.wav');
[data,FS] = audioread('sound2.wav');
% [data,FS] = audioread('sound3.wav');
% Closet filter:
data_closet = conv(data,closet(:,1),'full');
closet1 = 0.1*data_closet;
closet1(1:length(data)) = 0.9*data + closet1(1:length(data));
closet1 = closet1/(max(closet1));
% Compare original to filterd version:
sound(data,FS)
pause
sound(closet1,FS)
% Echo filter:
data_echo = conv(data,echo(:,1),'full');
echo1 = 0.1*data_echo;
echo1(1:length(data)) = 0.9*data + echo1(1:length(data));
echo1 = echo1/(max(echo1));
% Compare original to filterd version:
sound(data,FS)
pause
sound(echo1,FS)
% Hall filter:
data_hall = conv(data,hall(:,1),'full');
hall1 = 0.05*data_hall;
hall1(1:length(data)) = 0.95*data + hall1(1:length(data));
hall1 = hall1/(max(hall1));
% Compare original to filtered version
sound(data,FS)
pause
sound(hall1,FS)
Pool filter:
data_pool = conv(data,pool(:,1),'full');
pool1 = 0.1*data_pool;
pool1(1:length(data)) = 0.9*data + pool1(1:length(data));
pool1 = pool1/(max(pool1));
% Compare original to filtered version
sound(data,FS)
pause
sound(pool1,FS)