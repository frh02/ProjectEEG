clear all
close all
 
nsamples=10000;
fs=1e3;
 
time=(1:nsamples-1)/fs;
 
signal=0.5*time+sin(pi*time)+sin(2*pi*time)+sin(6*pi*time);%
threshouldSifting=0.1;
monotone=0;
indexIMF=0;
signalmem=signal;

while (not(monotone))
    h=signal;
    SD=1;
    while(SD>threshouldSifting)
        %% upper
        [pksMax,locsMax] = findpeaks(h);
        pksMax=[h(1), pksMax, h(end)];
        locsMax=[1, locsMax, length(h)];
        upperSpline=spline(time(locsMax),pksMax);
        spmax=ppval(upperSpline,time);
        
        %% lower
        [pksMin,locsMin] = findpeaks(-1*h);
        pksMin=-1*pksMin;
        pksMin=[h(1), pksMin, h(end)];
        locsMin=[1, locsMin, length(h)];
        lowerSpline=spline(time(locsMin),pksMin);
        spmin=ppval(lowerSpline,time);
        
        %% evaluate the mean
        
        mspline=(spmax+spmin)/2;

        hprec=h;
        h=h-mspline;
        SD=sum((hprec-h).^2)/sum(hprec.^2);  %criterio di stop proposto da by Huang et al. (1998)
    end

    indexIMF=indexIMF+1;
    IMF(indexIMF,:)=h;
    signal=signal-h;
    monotone=all(diff(signal)>0)||all(diff(signal)<0);
    for index=1:indexIMF
        subplot(indexIMF+2,1,index+1), plot(time,IMF(index,:));
    end
end

