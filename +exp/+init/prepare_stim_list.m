function stim_list = prepare_stim_list(cfg)

% 2 x 2 ... i.e 1 vs 2 speaker, noise vs no noise

stim_list.targetvoice = cfg.targetvoice;
targetphoneme = cfg.targetphoneme;

if strcmpi(stim_list.targetvoice, 'Fabi')
    wavend ='m';
    distend='f';
else
    wavend ='f';
    distend='m';
end


%%
        
tmp=randperm(6);
tarstories=tmp(1:4);
diststories=tmp(5:6);

tarwavs={[num2str(tarstories(1)) '_1_' wavend '.wav'],
         [num2str(tarstories(1)) '_2_' wavend '.wav'],
         [num2str(tarstories(2)) '_1_' wavend '.wav'],
         [num2str(tarstories(2)) '_2_' wavend '.wav'],
         [num2str(tarstories(3)) '_1_' wavend '.wav'],
         [num2str(tarstories(3)) '_2_' wavend '.wav'],
         [num2str(tarstories(4)) '_1_' wavend '.wav'],
         [num2str(tarstories(4)) '_2_' wavend '.wav']};

distwavs={[num2str(diststories(1)) '_1_' distend '.wav'],
         [num2str(diststories(1)) '_2_' distend '.wav'],
         [num2str(diststories(1)) '_3_' distend '.wav'],
         [num2str(diststories(2)) '_1_' distend '.wav'],
         [num2str(diststories(2)) '_2_' distend '.wav'],
         [num2str(diststories(2)) '_3_' distend '.wav']};

distwavs=distwavs(randperm(length(distwavs),length(tarwavs)/2));

%% DEFINE SINGLE VS MULTISPEAKER

distseq = [zeros(1, length(distwavs)), ones(1, length(distwavs))];
distseq = distseq(randperm(length(distseq)));

%% DEFINE NOISE REPLACEMENT ... MAKE SURE THAT EQUALLY DISTRIBUTED

indMulti=find(distseq==1);
indSingle=find(distseq==0);

noiseseq=zeros(1,length(tarwavs));
noiseseq([indMulti(randperm(length(indMulti),length(indMulti)/2)) indSingle(randperm(length(indSingle),length(indSingle)/2))]) = 1;

%%

stim_list.distseq = distseq;
stim_list.noiseseq = noiseseq;

kk=1;
nn=1;

for ii = 1:length(tarwavs)
    stim_list.block{ii}.TargetWav=tarwavs{ii};
    
    if distseq(ii) == 1
        stim_list.block{ii}.DistractWav=distwavs{kk};
        kk=kk+1;
    else
        stim_list.block{ii}.DistractWav=[];
    end
    
    if noiseseq(ii) == 1
        stim_list.block{ii}.Phoneme=targetphoneme;
        nn=nn+1;
    else
        stim_list.block{ii}.Phoneme=[];
    end
        
end%for ii

end




