%% Start by loading the EEG data for the relative BIS value
disp('start part 1')
samp15=xlsread('pat_15.xlsx');
save samp15.mat samp15;
y=samp15(:,2);
disp('Done with part 1')
%% creating array of the data values into batches of 625 samples
disp('start part 2 ')
fs=125;
ts=[0:1/fs:5];
ME=[y(1:fs*5)];
for i=5:5:(1600*5)
    ts=[ts; (i:1/fs:i+5)];
    ME=[ME , y((i*fs):(fs*(i+5)-1))];
end
ts=ts(:,1:end-1);
disp('Done with part 2')

%% Reading the BIS and the SQI values from the data sheets 
disp('starting with part 3')
datb=readtable('Num_Data_15.xlsx');
bis=datb(:,13);
bis = table2array(bis);
dats=readtable('Num_Data_15.xlsx');
sqi=dats(:,14);
sqi = table2array(sqi);
disp('Done Importing BIS/SQI') 
%% creating folders to save images
disp('start loading folder ')
folder1 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_25\Anesthesia_DEEP_SQI';
folder2 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_25\Anesthesia_LOW_SQI';
folder3 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_25\Anesthesia_OK';
folder4 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_25\Anesthesia_LOW';
folder5 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_25\Anesthesia_DEEP';
folder6 = 'C:\Users\ANUPAMA\Desktop\EEG_Dataset\Training\Patient_25\Anesthesia_OK_SQI';
disp('Done creating folders')
%% CONVERTING INTO ROW - COLUMN MATRIX
disp('Matrix conversion')
nval=numel(y); %count the number of data points in the ECG file
nbis=numel(bis); %count the number of BIS values 
nsqi=numel(sqi);
Column2Row_val=reshape(y,[1,nval]); % Reshape form column to row
Column2Row_bis=reshape(bis,[1,nbis]);
Column2Row_sqi=reshape(sqi,[1,nsqi]);
disp('Done with matrix conversion')
%% Generating and saving images into respective folders
N=625;
fs=125;
T=N/fs;
freq=(0:N-1)/T;
aim =4;                      % numbers of IMF
NR =5;                      % value of ensemble
Nstd = 0.3;                  % param to white noise
pat=15

for ii=51:53
    
        XX=Column2Row_bis(ii);

        YY=Column2Row_sqi(ii);
   
    hold on
    IMF =eemd_e(ME(:,ii),aim,NR,Nstd);
    T=N/fs; 
    freq=(0:N-1)/T;

     for lp=1:aim
        if lp == 1 
            T=N/fs;
            Y =abs(fft(detrend(IMF(:,lp)),N));%for noise 
            freq=(0:N-1)/T;

            subplot(2,2,lp,'position',[.01 .5 .60 .55])
            set(gca,'xtick',[],'ytick',[],'Color','none')
            
           
            pspectrum(IMF(:,lp),fs,'spectrogram',...
            'FrequencyLimits',[0 60],'TimeResolution',0.3)
        
        colorbar('off')
        set(gca,'visible','off')

        elseif lp == 2

            T=N/fs;

            freq=(0:N-1)/T;
            subplot(2,2,lp,'position',[.5 .5 .60 .55])
            set(gca,'xtick',[],'ytick',[],'Color','none')
            
            

             pspectrum(IMF(:,lp),fs,'spectrogram',...
                'FrequencyLimits',[0 60],'TimeResolution',0.3)
            
           colorbar('off')
           set(gca,'visible','off')


        elseif lp == 3

            T=N/fs;

            Y =fft(detrend(IMF(:,lp)),N);

            freq=(0:N-1)/T;
             subplot(2,2,lp,'position',[.01 .005 .60 .5])
             set(gca,'xtick',[],'ytick',[],'Color','none')
             

            pspectrum(IMF(:,lp),fs,'spectrogram',...
                'FrequencyLimits',[0 60],'TimeResolution',0.3)
            
            colorbar('off')
            set(gca,'visible','off')

        else 

            T=N/fs;

            Y =fft(detrend(IMF(:,lp)),N);

            freq=(0:N-1)/T;
            subplot(2,2,lp,'position',[.5 .005 .60 .5])
            set(gca,'xtick',[],'ytick',[],'Color','none')
            set(gca,'visible','off')

            pspectrum(IMF(:,lp),fs,'spectrogram',...
                'FrequencyLimits',[0 100],'TimeResolution',0.3)
            
            colorbar('off')
            set(gca,'visible','off')

            hold on


        if YY>60
            if XX>60
                    baseFileName = sprintf('Pat%dLOW_%d.png',pat,ii);
                    fullFileName = fullfile(folder2, baseFileName);
                    saveas(gcf, fullFileName);
            elseif XX>40
                    baseFileName = sprintf('Pat%dOKAY_%d.png',pat,ii);
                    fullFileName = fullfile(folder3, baseFileName);
                    saveas(gcf, fullFileName);
            else
                    baseFileName = sprintf('Pat%dDEEP_%d.png',pat,ii);
                    fullFileName = fullfile(folder1, baseFileName);
                    saveas(gcf, fullFileName);
            end
        else
            if XX>60
                    baseFileName = sprintf('Pat%dLOW_%d_lsqi.png',pat, ii);
                    fullFileName = fullfile(folder5, baseFileName);
                    saveas(gcf, fullFileName);
            elseif XX>40
                    baseFileName = sprintf('Pat%dOKAY_%d_sqi.png',pat, ii);
                    fullFileName = fullfile(folder6, baseFileName);
                    saveas(gcf, fullFileName);
            else
                    baseFileName = sprintf('Pat%dDEEP_%d_sqi.png',pat, ii);
                    fullFileName = fullfile(folder4, baseFileName);
                    saveas(gcf, fullFileName);
            end        
    end
          

        end
     end
     
  
     
    ii=ii+1;
    clc 
    close all
     message=sprintf('IMFs Plotted');
     disp(message)
end
mess= sprintf('Done Processing');
disp(message)