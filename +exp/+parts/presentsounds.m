function [PointsNoiseTarget PointsNoiseDistract Response]=presentsounds(subj_data, blocknum, o_ptb_path, ptb_path, mpraat_path)

%% TRIGGER CODING
% Onset Fixation Cross:    11
% 
% Target Voice Fabi:      100
% Target Voice Juliane:   200
%        No Distractor:   +10
%      with Distractor:   +20
%         No Noise Seg:    +1
%       With Noise Seg:    +2

%% init...
ptb_config = exp.init.config_ptb(o_ptb_path, ptb_path, mpraat_path);
ptb = exp.init.init_ptb(ptb_config);

%% prepare stims

if strcmpi(subj_data.stims.targetvoice, 'Fabi')
    distractPath='Julie';
else
    distractPath='Fabi';
end

%% Prepare Trigger

if strcmpi(subj_data.stims.targetvoice, 'Fabi')
    SND_TrigVal = 100;
elseif strcmpi(subj_data.stims.targetvoice, 'Juliane')
    SND_TrigVal = 100;
end

if subj_data.stims.distseq(blocknum) == 0
    SND_TrigVal = SND_TrigVal + 10;
else
     SND_TrigVal = SND_TrigVal + 20;
end

if subj_data.stims.noiseseq(blocknum) == 0
    SND_TrigVal = SND_TrigVal + 1;
else
    SND_TrigVal = SND_TrigVal + 2;
end

%%
[questions, targetwords, distractorwords] = exp.mfiles.load_questions();
tmp=split(subj_data.stims.block{blocknum}.TargetWav, '_');

ind4questions = (str2num(tmp{1})-1)*3 + str2num(tmp{2});

%% Prepare Target Speech

soundName=split(subj_data.stims.block{blocknum}.TargetWav, '.');
soundName=soundName{1};

TextGridTarget=fullfile('./listening_paradigm/Audio final version/', subj_data.stims.targetvoice, '/textgrids/', [soundName '.TextGrid']);
WavFileTarget=fullfile('./listening_paradigm/Audio final version/', subj_data.stims.targetvoice, '/', subj_data.stims.block{blocknum}.TargetWav);

fprintf('Reading following Textgrid: %s\n', TextGridTarget);
tgTarget = tgRead(TextGridTarget);


[wavMatTarget, Fs] = audioread(WavFileTarget);

if ~isempty(subj_data.stims.block{blocknum}.DistractWav)
    [wavMatDistract, Fs] = audioread(fullfile('./listening_paradigm/Audio final version/',distractPath, '/', subj_data.stims.block{blocknum}.DistractWav));
    
    soundName=split(subj_data.stims.block{blocknum}.DistractWav, '.');
    soundName=soundName{1};
    
    TextGridDistract=fullfile('./listening_paradigm/Audio final version/', distractPath, '/textgrids/', [soundName '.TextGrid']);
    
    fprintf('Reading following Textgrid: %s\n', TextGridDistract);
    tgDistract = tgRead(TextGridDistract);

else
    wavMatDistract=zeros(size(wavMatTarget));
    tgDistract=[];
end

%% NORMALIZE SOUND TO AMBIENT RMS

normfacsTar=rms(wavMatTarget)/subj_data.ambientrms;
wavMatTarget(:,1)=wavMatTarget(:,1) / normfacsTar(1);
wavMatTarget(:,2)=wavMatTarget(:,2) / normfacsTar(2);


if length(unique(wavMatDistract(:))) ~= 1
    normfacsDist=rms(wavMatDistract)/subj_data.ambientrms;
    wavMatDistract(:,1)=wavMatDistract(:,1) / normfacsDist(1);
    wavMatDistract(:,2)=wavMatDistract(:,2) / normfacsDist(2);
end

%% CHECK WHETHER TO ADD NOISES

if ~isempty(subj_data.stims.block{blocknum}.Phoneme)
    [wavMatTarget PointsNoiseTarget]= exp.mfiles.phoneme2noise(wavMatTarget, tgTarget, subj_data.stims.block{blocknum}.Phoneme, Fs, 0); %NOISE EQUAL RMS
    if ~isempty(subj_data.stims.block{blocknum}.DistractWav)
        [wavMatDistract PointsNoiseDistract]= exp.mfiles.phoneme2noise(wavMatDistract, tgDistract, subj_data.stims.block{blocknum}.Phoneme, Fs, 0); %NOISE EQUAL RMS
    else
        PointsNoiseDistract=[];
    end
else
    PointsNoiseTarget =[];
    PointsNoiseDistract=[];
end

subj_data.stims.block{blocknum}.PointsNoiseTarget=PointsNoiseTarget;
subj_data.stims.block{blocknum}.PointsNoiseDistract=PointsNoiseDistract;

%% DISPLAY INSTRUCTIONS

wait_text = o_ptb.stimuli.visual.Text('Bitte Warten ...!');
ptb.draw(wait_text);
ptb.flip();

KbWait;

%%

minpos=min([length(wavMatTarget) length(wavMatDistract)]);
%minpos=Fs*10;

cmb_snd= o_ptb.stimuli.auditory.FromMatrix(wavMatTarget(1:minpos,:)'+wavMatDistract(1:minpos,:)', Fs);

ptb.prepare_trigger(11); %Trigger fixation cross
ptb.schedule_trigger;
ptb.play_on_flip;


fix_cross = o_ptb.stimuli.visual.FixationCross();
ptb.draw(fix_cross);
ptb.flip();

%TO DO: ADD TRIGGER
ptb.prepare_audio(cmb_snd);
ptb.schedule_audio;
ptb.prepare_trigger(SND_TrigVal); 
ptb.schedule_trigger;

now_time=GetSecs();
ptb.play_without_flip;

WaitSecs('UntilTime', now_time + cmb_snd.duration + 1);
%audiowrite('test.wav', wavMatTarget(1:minpos,:)+wavMatDistract(1:minpos,:), Fs)

%% TO DO ADD QUESTIONS

winWidth = RectWidth(ptb.win_rect);
winHeight = RectHeight(ptb.win_rect);
ypos=winHeight*.6;
xpos=[winWidth*.25 winWidth*.55];
xpos=Shuffle(xpos);


%%%%%%%%%%%%%%%%%%%%%%%NOUNS
noun_prompt = o_ptb.stimuli.visual.Text('Welches Wort ...!');

target_text= o_ptb.stimuli.visual.Text(targetwords{ind4questions});
target_text.sx= xpos(1);
target_text.sy= ypos;

distract_text= o_ptb.stimuli.visual.Text(distractorwords{ind4questions});
distract_text.sx= xpos(2);
distract_text.sy= ypos;

ptb.draw(noun_prompt);
ptb.draw(target_text);
ptb.draw(distract_text);
ptb.flip();

now_time=GetSecs();
[button, endRT] = ptb.wait_for_keys({'left', 'right'}, Inf);

Response.NounRT = endRT-now_time;

if xpos(1) < xpos(2)
    Response.NounCorrect = strcmpi(cell2mat(button), 'left');
elseif xpos(1) > xpos(2)
    Response.NounCorrect = strcmpi(cell2mat(button), 'right');
end

WaitSecs('UntilTime', endRT+1)
clear button endRT
%%%%%%%%%%%%%%%%%%%%%%%STATEMENTS
ss=1;
for ii = 1:length(questions{ind4questions}.true)
    tmpquests{ss}=questions{ind4questions}.true{ii};
    truevec(ss)=1;
    ss=ss+1;
end

for ii = 1:length(questions{ind4questions}.false)
    tmpquests{ss}=questions{ind4questions}.false{ii};
    truevec(ss)=0;
    ss=ss+1;
end

indperms=randperm(length(truevec));

for qq=1:length(truevec)
    
    question_text= o_ptb.stimuli.visual.Text(tmpquests{indperms(qq)});
    question_text.size=40;
    answer_text= o_ptb.stimuli.visual.Text('Rot: Trifft nicht zu.\n Grün: Trifft zu');
    answer_text.sy=winHeight*.7;
    answer_text.size=40;
    ptb.draw(question_text);
    ptb.draw(answer_text);
    ptb.flip();
    
    now_time=GetSecs();
    [button, endRT] = ptb.wait_for_keys({'true', 'false'}, Inf);
    
    Response.QuestionRT(qq) = endRT-now_time;
    
    if truevec(indperms(qq)) == 1 & strcmpi(cell2mat(button), 'true')
        Response.QuestionCorrect(qq) = 1;
    elseif truevec(indperms(qq)) == 0 & strcmpi(cell2mat(button), 'false')
        Response.QuestionCorrect(qq) = 1;
    else
        Response.QuestionCorrect(qq) = 0;
    end
    
    WaitSecs('UntilTime', endRT+1)
    
end %qq


%% END

wait_text = o_ptb.stimuli.visual.Text('Bitte Warten ...!');
ptb.draw(wait_text);
ptb.flip();

KbWait; sca

%%




