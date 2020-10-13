clear all
restoredefaultpath

addpath('~/Documents/GitHub/mPraat/')
addpath('/Users/b1019548/Documents/GitHub/Experiments/RestorePhoneme/mfiles/')

%%
TextGridIn1='/Users/b1019548/Documents/GitHub/Experiments/RestorePhoneme/listening_paradigm/Audio final version/Fabi/textgrids/1_1_m.TextGrid';
TextGridIn2='/Users/b1019548/Documents/GitHub/Experiments/RestorePhoneme/listening_paradigm/Audio final version/Julie/textgrids/1_3_f.TextGrid';
WavFile1='/Users/b1019548/Documents/GitHub/Experiments/RestorePhoneme/listening_paradigm/Audio final version/Fabi/1_1_m.wav';
WavFile2='/Users/b1019548/Documents/GitHub/Experiments/RestorePhoneme/listening_paradigm/Audio final version/Julie/1_3_f.wav';
tg1 = tgRead(TextGridIn1);
tg2 = tgRead(TextGridIn2);

%%

TarPhoneme = 'E';

indTar1=[];
indTar2=[];

for ii=1:length(tg1.tier{3}.Label)
    if strcmp(tg1.tier{3}.Label(ii) ,TarPhoneme) && isempty(find(tg1.tier{1}.T1 == tg1.tier{3}.T1(ii))) %remove target phoneme at word onset
        indTar1 = [indTar1 ii];
    end
end

for ii=1:length(tg2.tier{3}.Label)
    if strcmp(tg2.tier{3}.Label(ii) ,TarPhoneme) && isempty(find(tg2.tier{1}.T1 == tg2.tier{3}.T1(ii))) %remove target phoneme at word onset
        indTar2 = [indTar2 ii];
    end
end


%%

[wavMat1, Fs] = audioread(WavFile1);
[wavMat2, Fs] = audioread(WavFile2);

%%

TarPoints1 = round([tg1.tier{3}.T1(indTar1); tg1.tier{3}.T2(indTar1)]' * Fs);
TarPoints2 = round([tg2.tier{3}.T1(indTar2); tg2.tier{3}.T2(indTar2)]' * Fs);

%%

wavMat_Trans1 = wavMat1;
wavMat_Trans2 = wavMat2;


for ii = 1:length(TarPoints1)
    %nn=randn(size(wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2),:)));
    nn(:,1) = make_pink_noise(length(wavMat_Trans1(TarPoints1(ii,1):TarPoints1(ii,2))));
    nn(:,2) = make_pink_noise(length(wavMat_Trans1(TarPoints1(ii,1):TarPoints1(ii,2))));
    
    %scale to be equal RMS to sound
    %nn_0 = nn ./ (rms(nn)/rms(wavMat));
    nn_0 = nn ./ (rms(nn)/rms(wavMat1(TarPoints1(ii,1):TarPoints1(ii,2),:)));
    
    nn_3 = 10^(3/20) * nn_0;
    nn_6 = 10^(6/20) * nn_0;
    
    wavMat_Trans1(TarPoints1(ii,1):TarPoints1(ii,2),:)=nn_6;
    
    clear nn*
end

for ii = 1:length(TarPoints2)
    %nn=randn(size(wavMat_Trans(TarPoints(ii,1):TarPoints(ii,2),:)));
    nn(:,1) = make_pink_noise(length(wavMat_Trans2(TarPoints2(ii,1):TarPoints2(ii,2))));
    nn(:,2) = make_pink_noise(length(wavMat_Trans2(TarPoints2(ii,1):TarPoints2(ii,2))));
    
    %scale to be equal RMS to sound
    %nn_0 = nn ./ (rms(nn)/rms(wavMat));
    nn_0 = nn ./ (rms(nn)/rms(wavMat2(TarPoints2(ii,1):TarPoints2(ii,2),:)));
    
    nn_3 = 10^(3/20) * nn_0;
    nn_6 = 10^(6/20) * nn_0;
    
    wavMat_Trans2(TarPoints2(ii,1):TarPoints2(ii,2),:)=nn_6;
    
    clear nn*
end

%%

minpos=min([length(wavMat_Trans1) length(wavMat_Trans2)]);

wavMat_Trans=wavMat_Trans1(1:minpos,:)+wavMat_Trans2(1:minpos,:);


%%

audiowrite('test_cmb.wav', wavMat_Trans, Fs)


