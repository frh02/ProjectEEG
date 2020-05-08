dataset=load('2014.10.15_1.mat')
y= dataset.EEG;
aim =8;                      % numbers of IMF
NR =10;                      % value of ensemble
Nstd = 0.3;                  % param to white noise
% imf=eemd_e(y,aim,NR,Nstd);
plot(y)
xlim([0 672])
% 
% % subplot(8,1,1)
% % plot(y)
% % xlim([0 672])
% % title ('Original Signal')
% % % eemd(y,'Display',1)
% % fs=128;
% % N=672;
% % T=N/fs;
% % figure();
% % Y=abs(fft(eemd(y,aim,NR,Nstd),N)); 
% % freq=(0:N-1)/T;
% % plot(freq,Y);xlabel('Frequency');
% % % xlim([0 30])
% for j=1:NR
%     for i=1:aim
%         hold on 
%         subplot(8,1,i);
%         plot(IMF(:,i), 'r');
% %         title('IMF plot')
%         xlim([0 672])
% %     hold on
% %     plot(1:0.8:2000, 0, 'k');
% %     set(gca,'YLim',[-1,1],'YTick',[-1:1])
%     end 
% end
% % Y =fft(detrend(IMF(:,2)));       %??FFT??
% % N = length(Y);    %FFT???????
% % power = abs(Y(1:N/2)).^2;  %????
% % nyquist = 1/2;
% % freq = (1:N/2)/(N/2)*nyquist; %???
% % subplot(7,1,7);
% % plot(freq,power); grid on     %??????
% % xlabel('??')
% % ylabel('??')
% % title('????')
% % % period = 1./freq;                %????
% % % subplot(5,2,4);
% % % plot(period,power); grid on  %??????????
% % % ylabel('??')
% % % xlabel('??')
% % % title('??—????')
% % % [mp,index] = max(power);       %???????????
% % % T_mean=period(index); 