function [nicerms]=matchambientlevel(subj_data, o_ptb_path, ptb_path)

%% CHECK WHETHER RMS HAS ALREAD BEEN CALCULATED
if ~isfield(subj_data, 'ambientrms')
    
    %% init...
    ptb_config = exp.init.config_ptb(o_ptb_path, ptb_path);
    ptb = exp.init.init_ptb(ptb_config);
    
    wait_text = o_ptb.stimuli.visual.Text('Bitte Warten ...!');
    ptb.draw(wait_text);
    ptb.flip();

    KbWait;
    
    %%
    
    [storyWav, Fs] = audioread('./schnitzler_fremde.mp3');
    
    %% Generate random 10 sec segments
    
    winsecs=10; % 10 second segments
    startindx=[1:Fs*winsecs:length(storyWav)-Fs*winsecs];
    randseq=randperm(length(startindx));
    
    %%
    
    new_rms=.01;
    ii=1;
    while ~isempty(new_rms)
        
        fix_cross = o_ptb.stimuli.visual.FixationCross();
        ptb.draw(fix_cross);
        ptb.flip();
        
        snipp_storyWav=storyWav(startindx(randseq(ii)):startindx(randseq(ii))+Fs*winsecs);
        snipp_storyWav = o_ptb.stimuli.auditory.FromMatrix(snipp_storyWav', Fs);
        snipp_storyWav.rms = new_rms;
        
        %%
        
        ptb.prepare_audio(snipp_storyWav);
        ptb.schedule_audio;
        
        now_time=GetSecs();
        ptb.play_without_flip;
        
        
        WaitSecs('UntilTime', now_time + snipp_storyWav.duration + 2);
        wait_text = o_ptb.stimuli.visual.Text('Wie XXXX?');
        
        ptb.draw(wait_text);
        ptb.flip();
        
        fprintf('Current RMS: %f.\n', snipp_storyWav.rms(1));
        
        new_rms=input('New RMS (hit return to quit): ');
        
        while new_rms/snipp_storyWav.rms(1) > 2
            fprintf('Too much increase in one step!\n');
            new_rms=input('New RMS (hit return to quit): ');
        end
        
        
        %ADD SECURITY THAT IF STEP TO BIG TO HAVE NEW PROMP
        
        KbWait;
        ii=ii+1;
        
    end
    
    nicerms = snipp_storyWav.rms(1);
    sca;
    
else
    fprintf('Ambient RMS has already been determined. You may continue!\n');
    nicerms = subj_data.ambientrms;
end

end
