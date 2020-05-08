function [modes] = eemd_e(y, aim, NR, Nstd)
stdy = std(y);
if stdy < 0.01
    stdy = 1;
end
y = y ./ stdy;
siz = length(y);
modes = zeros(siz,aim);
for k = 1:NR
    disp(['Ensemble number #' num2str(k)]);
    wn = (randn(1,siz).*Nstd)';
    y1 = y + wn;
    y2 = y - wn;
    modes = modes + emd(y1,'MaxNumIMF',aim);
    if Nstd > 0 && NR > 1
        modes = modes + emd(y2,'MaxNumIMF',aim);  
    end
end
modes = modes .* stdy ./ (NR);
if Nstd > 0 && NR > 1
    modes = modes ./ 2;
end
end
