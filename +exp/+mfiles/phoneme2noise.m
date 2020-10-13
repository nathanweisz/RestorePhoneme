function [wavMat_Trans, TarPoints]=phoneme2noise(wavMat, tg, TarPhoneme, Fs, dbamp)


indTar=[];

for ii=1:length(tg.tier{3}.Label)
    if strcmp(tg.tier{3}.Label(ii) ,TarPhoneme) && isempty(find(tg.tier{1}.T1 == tg.tier{3}.T1(ii))) %remove target phoneme at word onset
        indTar = [indTar ii];
    end
end


%%

TarPoints = round([tg.tier{3}.T1(indTar); tg.tier{3}.T2(indTar)]' * Fs);

%%

wavMat_Trans = wavMat;


for ii = 1:length(TarPoints)
    %nn=randn(size(wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2),:)));
    nn(:,1) =exp.mfiles.make_pink_noise(length(wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2))));
    nn(:,2) = exp.mfiles.make_pink_noise(length(wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2))));
    
    %scale to be equal RMS to sound
    %nn_0 = nn ./ (rms(nn)/rms(wavMat));
    nn = nn ./ (rms(nn)/rms(wavMat(TarPoints(ii,1):TarPoints(ii,2),:)));
    nn = 10^(dbamp/20) * nn;
    
    wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2),:)=nn;
    
    clear nn*
end


