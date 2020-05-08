dataset=load('2014.10.15_1.mat')
y= dataset.EEG;
fs=128;
N=672;
subplot(3,1,1)
T=N/fs;
plot(T,y)
% % title('EEG of patient_1')
% % xlabel('Time')
% % ylabel('Amplitude')
% % emd(s,'Interpolation','pchip','Display',1)
% % y=fft(emd(s));
% % plot(abs(y))
% 
T=N/fs;
figure();
Y=abs(fft(emd(y),N)); 
freq=(0:N-1)/T;
subplot(3,1,2)
plot(freq,Y);xlabel('Frequency');
xlim([0 64])
subplot(3,1,3)
plot(freq,Y);xlabel('Frequency');
xlim([0 30])
      % load a signal.
% aim = 5;                      % numbers of IMF
% NR = 3;                      % value of ensemble
% Nstd = 0.3;                   % param to white noise
% IMF1=eemd(y,aim,NR,Nstd);
% plot(IMF)