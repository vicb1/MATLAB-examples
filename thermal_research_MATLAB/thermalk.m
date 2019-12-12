% Hot Wire Cell Data Analysis
clc;
close all;
clear all;
 
%addpath C:\MatlabWork\HotWireTests
%cd C:\MatlabWork\HotWireTests
 
% User Input of Data File Location
%rawfile=input('Enter File Location: \n', 's');

[FileName,PathName] = uigetfile({'*.*'},'File Selector','Select the data (more than one file)','MultiSelect','on');
addpath PathName

nFiles=numel(FileName);

for forX=1:nFiles
    
rawfile=FileName{forX};
disp(FileName{forX})
 
% Declaration of Constants
alpha= 0.00385;%specification from manufacturer (AM Systems)-- alpha value of platinum wire (ohm/ohm deg c)
L=0.0945;                    %length of wire (m)
R1=22.556;                    %R1 resistance (ohm)
R2=22.567;                    %R2 resistance (ohm)
RL=0.048;                     %Leg resistance (ohm)
Icc=80;                     %Constant Current Supply (mA)
gain=100;                      %gain, as set on the NI SCXI chassis

% User Input for Figure Plots
%figurefile=input('Enter Name and Descriptor of Test (no spaces or symbols): \n', 's');
 
% Declaration of Data from User File
rawfiledata = textread(rawfile);
RawBridgeVoltage=rawfiledata(:,1)./(-1.*gain);
FilteredBridgeVoltage=rawfiledata(:,2)./(-1.*gain);
RawSupplyVoltage=rawfiledata(:,3);
FilteredSupplyVoltage=rawfiledata(:,4);
 
% Declaration of User Designated Constants
R33=input('Enter Value for R3 (Trimmer) in Ohms:');              %bridge balancing resistance (ohms)
R3=R33-.021;
RWW=input('Enter Value for Hot Wire Resistance in Ohms:');       %hot wire resistance before test is run (ohms)
RW= RWW - .1745;
%Icc=input('Enter Value for Constant Current Supply(mA): ');     %power supply set point (mA)
 
% Data Manipulation and Calculations (Wire Resistance and Temperature)
    % Converting mA to A
Icc=Icc/1000;
    % Change in wire resistance
deltRwRaw=(RawBridgeVoltage.*(R1+R2+R3+RW+RL)+Icc*(R2*R3-R1*RW-R1*RL))./(Icc*R1-RawBridgeVoltage);
deltRwFiltered=(FilteredBridgeVoltage.*(R1+R2+R3+RW+RL)+Icc*(R2*R3-R1*RW-R1*RL))./(Icc*R1-FilteredBridgeVoltage);
    % Change in wire temperature
deltTwRaw=deltRwRaw./(RW.*alpha);
deltTwFiltered=deltRwFiltered./(RW.*alpha);
 
% Declaration of Time and ln(Time)
testtime=(0:0.001:1.499);          %Creating time data array
testtime=testtime';                %Placing time data in a column
lntime=log(testtime(:));           %Creating ln time data
 
%Creation of Data for Accepted Time Span (0.5-1s)
RawBridgeVoltageAccepted=RawBridgeVoltage(500:1000);
FilteredBridgeVoltageAccepted=FilteredBridgeVoltage(500:1000);
deltRwRawAccepted=deltRwRaw(500:1000);
deltRwFilteredAccepted=deltRwFiltered(500:1000);
deltTwRawAccepted=deltTwRaw(500:1000);
deltTwFilteredAccepted=deltTwFiltered(500:1000);
testtimeAccepted=testtime(500:1000);
lntimeAccepted=lntime(500:1000);
 
% Linear Fit For Wire Temperature vs. lntime
LinearCoefRaw=polyfit(lntimeAccepted,deltTwRawAccepted,1);
mRaw=LinearCoefRaw(1,1);
intersectRaw=LinearCoefRaw(1,2);
LinearValRaw=mRaw.*lntimeAccepted+intersectRaw;
 
LinearCoefFiltered=polyfit(lntimeAccepted,deltTwFilteredAccepted,1);
mFiltered=LinearCoefFiltered(1,1);
intersectFiltered=LinearCoefFiltered(1,2);
LinearValFiltered=mFiltered.*lntimeAccepted+intersectFiltered;

% Plots
    % Plots of Voltage vs. Time (Raw and Filtered) (Full Time and 0.5-1s)
figure(1)
subplot(2,1,1); plot(testtime,RawBridgeVoltage,testtime,FilteredBridgeVoltage) 
title('Plots of Bridge Voltage')
xlabel('Time (s)')
ylabel('Voltage (V)')
legend1=legend('Raw Signal','Filtered Signal');
set(legend1,'Location','Best');
subplot(2,1,2); plot(testtimeAccepted, RawBridgeVoltageAccepted, testtimeAccepted, FilteredBridgeVoltageAccepted)
axis tight
xlabel('Time (s)')
ylabel('Voltage (V)')
legend2=legend('Raw Signal', 'Filtered Signal');
set(legend2,'Location','Best');
figurefile1=sprintf('%s Figure 1', figurefile);
print('-f1','-djpeg','-append',figurefile1)
    %Plots of Resistance Change in Hot Wire (Raw and Filtered) (Full Time and 0.5-1s)
figure(2)
subplot(2,1,1); plot(testtime, deltRwRaw, testtime, deltRwFiltered)
title('Plots of Hot Wire Resistance vs. Time')
xlabel('Time (s)')
ylabel('Hot Wire Resistance (Ohms)')
legend3=legend('Raw Signal', 'Filtered Signal');
set(legend3,'Location','Best');
subplot(2,1,2); plot(testtimeAccepted, deltRwRawAccepted, testtimeAccepted, deltRwFilteredAccepted)
axis tight
xlabel('Time (s)')
ylabel('Hot Wire Resistance (Ohms)')
legend4=legend('Raw Signal', 'Filtered Signal');
set(legend4,'Location','Best');
figurefile2=sprintf('%s Figure 2', figurefile);
print('-f2','-append','-djpeg',figurefile2)
    %Plots of Wire Temp. vs. Standard Time (Raw and Filtered) (Full Time and 0.5-1s)
figure(3)
subplot(2,1,1); plot(testtime, deltTwRaw, testtime, deltTwFiltered)
title('Plots of Hot Wire Temperature vs. Time')
xlabel('Time (s)')
ylabel('Hot Wire Temperature (deg C)')
legend5=legend('Raw Signal', 'Filtered Signal');
set(legend5,'Location','Best');
subplot(2,1,2); plot(testtimeAccepted, deltTwRawAccepted, testtimeAccepted, deltTwFilteredAccepted)
axis tight
xlabel('Time (s)')
ylabel('Hot Wire Temperature (deg C)')
legend6=legend('Raw Signal', 'Filtered Signal');
set(legend6,'Location','Best');
figurefile3=sprintf('%s Figure 3', figurefile);
print('-f3','-append','-djpeg',figurefile3)
%Plots of Wire Temp. vs. lnTime (Raw and Filtered) (Full Time and 0.5-1s)
figure(4)
subplot(2,1,1); plot(lntime, deltTwRaw, lntime, deltTwFiltered)
title('Plots of Hot Wire Temperature vs. ln(Time)')
xlabel('Time (ln(s))')
ylabel('Hot Wire Temperature (deg C)')
legend7=legend('Raw Signal', 'Filtered Signal');
set(legend7,'Location','Best');
subplot(2,1,2); plot(lntimeAccepted,deltTwRawAccepted, lntimeAccepted,deltTwFilteredAccepted, lntimeAccepted,LinearValRaw, lntimeAccepted,LinearValFiltered)
axis tight
xlabel('Time (ln(s))')
ylabel('Hot Wire Temperature (deg C)')
legend8=legend('Raw Signal', 'Filtered Signal','Raw Fit','Filtered Fit');
set(legend8,'Location','BestOutside');
figurefile4=sprintf('%s Figure 4', figurefile);
print('-f4','-append','-djpeg',figurefile4)
 

% Calculations of dT/dlnt (Raw and Filtered)
dT_dlntRaw=LinearCoefRaw(1);
dT_dlntFiltered=LinearCoefFiltered(1);
 
% Calculations of q (Raw and Filtered)
qRaw=(Icc-((Icc.*(R3+RW+deltRwRaw+RL))./(R1+R2+R3+RW+deltRwRaw+RL))).^2.*(RW+deltRwRaw);
qFiltered=(Icc-((Icc.*(R3+RW+deltRwFiltered+RL))./(R1+R2+R3+RW+deltRwFiltered+RL))).^2.*(RW+deltRwFiltered);
 
qRawAccepted=qRaw(500:1000);
qFilteredAccepted=qFiltered(500:1000);
 
qAvgRaw=mean(qRawAccepted);
qAvgFiltered=mean(qFilteredAccepted);
 
% Calculations of k (Raw and Filtered)
kRaw=(qAvgRaw/(4*pi*L*dT_dlntRaw));
kFiltered=(qAvgFiltered/(4*pi*L*dT_dlntFiltered));
 
% Output of k values (Raw and Filtered)
fprintf('k Raw is: %f W/(mK) \n', kRaw)
fprintf('k Filtered is: %f W/(mK) \n', kFiltered)
end