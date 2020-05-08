dataset=load('2014.10.15_1.mat')
y= dataset.EEG;
N=672;
fs=128;
aim =8;                      % numbers of IMF
NR =10;                      % value of ensemble
Nstd = 0.3;                  % param to white noise
IMF =eemd_e(y,aim,NR,Nstd);
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
%for j=1:NR
    for i=1:aim
%         hold on
%         subplot(8,1,i);
%         plot(IMF(:,i), 'r');
% %         title('IMF plot')
%         xlim([0 672])
        T=N/fs;
        figure();
        Y =fft(detrend(IMF(:,i)),N);
%         Y=abs(fft(emd(y),N));
        freq=(0:N-1)/T;
        plot(freq,abs(Y));xlabel('Frequency')
        xlim([0 34])

%         figure
%         plot(abs(Y), 'r')
%     hold on
%     plot(1:0.8:2000, 0, 'k');
%     set(gca,'YLim',[-1,1],'YTick',[-1:1])
    end
