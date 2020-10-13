function subj_data=resting(subj_data, o_ptb_path, ptb_path)

ptb_config = exp.init.config_ptb(o_ptb_path, ptb_path);
ptb = exp.init.init_ptb(ptb_config);

%%
inst_text =  o_ptb.stimuli.visual.Text('Einen Moment. Es geht gleich los...');
ptb.draw(inst_text);
ptb.flip();

KbWait();

%% show fixation cross...

ptb.prepare_trigger(11); %Trigger fixation cross
ptb.schedule_trigger;
ptb.play_on_flip;

fixcross = o_ptb.stimuli.visual.FixationCross();
ptb.draw(fixcross)
ptb.flip()

%%

WaitSecs(.5*60+10);

wait_text = o_ptb.stimuli.visual.Text('Bitte Warten ...!');
ptb.draw(wait_text);
ptb.flip();

KbWait; sca

%% Goodbye
subj_data.resting_done = true;

