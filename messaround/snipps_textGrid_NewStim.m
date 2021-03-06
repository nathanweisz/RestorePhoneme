clear all
restoredefaultpath

addpath('~/Documents/GitHub/mPraat/')
addpath('/Users/b1019548/Documents/GitHub/Experiments/RestorePhoneme/mfiles/')

%%
TextGridIn='/Users/b1019548/Documents/GitHub/Experiments/RestorePhoneme/listening_paradigm/Audio final version/Fabi/textgrids/1_1_m.TextGrid';
WavFile='/Users/b1019548/Documents/GitHub/Experiments/RestorePhoneme/listening_paradigm/Audio final version/Fabi/1_1_m.wav';
tg = tgRead(TextGridIn);

%%

TarPhoneme = 'E';

indTar=[];

for ii=1:length(tg.tier{3}.Label)
    if strcmp(tg.tier{3}.Label(ii) ,TarPhoneme) && isempty(find(tg.tier{1}.T1 == tg.tier{3}.T1(ii))) %remove target phoneme at word onset
        indTar = [indTar ii];
    end
end

%%

[wavMat, Fs] = audioread(WavFile);

%%

TarPoints = round([tg.tier{3}.T1(indTar); tg.tier{3}.T2(indTar)]' * Fs);

%%

wavMat_Trans = wavMat;


for ii = 1:length(TarPoints)
    %nn=randn(size(wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2),:)));
    nn(:,1) = make_pink_noise(length(wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2))));
    nn(:,2) = make_pink_noise(length(wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2))));
    
    %scale to be equal RMS to sound
    %nn_0 = nn ./ (rms(nn)/rms(wavMat));
    nn_0 = nn ./ (rms(nn)/rms(wavMat(TarPoints(ii,1):TarPoints(ii,2),:)));
    
    nn_3 = 10^(3/20) * nn_0;
    nn_6 = 10^(6/20) * nn_0;
    
    wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2),:)=nn_6;
    
    clear nn*
end

%%

audiowrite('test.wav', wavMat_Trans, Fs)

