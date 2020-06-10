%% IMPORTING DATA FILES
disp('Start')
samp_18=xlsread('pat_18.xlsx');
save samp_18.mat samp_18;
disp('Done Importing datafile')
%% SAMPLING INTO 640 DATA-POINTS
fs=128;
val=samp_18(:,2);
ts=[0:1/fs:5];
ME=[val(1:fs*5)];
pat=18;
for i=5:5:(1637*5)
    ts=[ts; (i:1/fs:i+5)];
    ME=[ME , val((i*fs):(fs*(i+5)-1))];
end
ts=ts(:,1:end-1);
disp('Done sampling the EEG signals')
%% EXTRACTING THE EEG SIGNALS USING EEMD PARAMETERS
aim =4;                      % numbers of IMF
NR =10;                      % value of ensemble
Nstd = 0.3;                  % param to white noise
N=640;
disp('Done setting parametes for EEMD')
%% ALOTTING FOLDERS FOR DIFFERENT BIS VALUES AND SQI VALUES 
folder1 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_18\Anesthesia_DEEP_SQI';
folder2 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_18\Anesthesia_LOW_SQI';
folder3 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_18\Anesthesia_OK';
folder4 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_18\Anesthesia_LOW';
folder5 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_18\Anesthesia_DEEP';
folder6 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_18\Anesthesia_OK_SQI';
disp('Done Alocating path')
%% IMPORTING BIS AND SQI VALUES FROM NUMDATA
datb=readtable('Num_Data_18.xlsx');
bis=datb(:,13);
bis = table2array(bis);

dats=readtable('Num_Data_18.xlsx');
sqi=dats(:,14);
sqi = table2array(sqi);
disp('Done Importing BIS/SQI') 
%% CONVERTING INTO ROW - COLUMN MATRIX
nval=numel(val); %count the number of data points in the ECG file
nbis=numel(bis); %count the number of BIS values 
nsqi=numel(sqi);
Column2Row_val=reshape(val,[1,nval]); % Reshape form column to row
Column2Row_bis=reshape(bis,[1,nbis]);
Column2Row_sqi=reshape(sqi,[1,nsqi]);
%% SAVING PLOTS INTO RESPECTIVE FOLDERS
n=nbis;
disp('Done section 6');
bis_num=0;
sqi_num=0;
 for ii= 1:1638
    
         
%          jmp1=jmp1+2601;
%         jmp2=jmp2+2601;
        bis_num=bis_num+1;
        %XX=Column2Row_bis(bis_num);
        XX=Column2Row_bis(ii);
        sqi_num=sqi_num+1;
%         YY=Column2Row_sqi(sqi_num);
        YY=Column2Row_sqi(ii);
%        

% for ii=1:3
%     figure()
%     ploteeg=plot(ts(ii,:),ME(:,ii));
%     
%     i=num2str(ii);
%     baseFileName = sprintf('samp_%d.png', ii+2000);
%     fullFileName = fullfile(folder1, baseFileName);
% %     saveas(gcf, fullFileName);    
%     hold on
%   
    IMF=eemd_e(ME(:,ii),aim,NR,Nstd);
    T=N/fs;
            %Y =abs(fft(detrend(IMF(:,lp)),N));%for noise 
    Y =abs(fft(detrend(IMF(:),N)));
    freq=(0:N-1)/T;
    figure() 
          
    spectrogram(Y,freq)
    if YY>60
            if XX>60
                    baseFileName = sprintf('Pat%dLOW_%d.png',pat,ii);
                    fullFileName = fullfile(folder4, baseFileName);
                    saveas(gcf, fullFileName);
            elseif XX>40
                    baseFileName = sprintf('Pat%dOKAY_%d.png',pat,ii);
                    fullFileName = fullfile(folder3, baseFileName);
                    saveas(gcf, fullFileName);
            else
                    baseFileName = sprintf('Pat%dDEEP_%d.png',pat,ii);
                    fullFileName = fullfile(folder5, baseFileName);
                    saveas(gcf, fullFileName);
            end
        else
            if XX>60
                    baseFileName = sprintf('Pat%dLOW_%d_lsqi.png',pat, ii);
                    fullFileName = fullfile(folder2, baseFileName);
                    saveas(gcf, fullFileName);
            elseif XX>40
                    baseFileName = sprintf('Pat%dOKAY_%d_sqi.png',pat, ii);
                    fullFileName = fullfile(folder6, baseFileName);
                    saveas(gcf, fullFileName);
            else
                    baseFileName = sprintf('Pat%dDEEP_%d_sqi.png',pat, ii);
                    fullFileName = fullfile(folder1, baseFileName);
                    saveas(gcf, fullFileName);
            end        
    end
    ii=ii+1;
    clc
    close all
     message=sprintf('Processing done: %s of %d',i,n);
     disp(message)
    
 end
 disp('IMAGES Saved')
 