function ptb_config = config_ptb(o_ptb_path, ptb_path, mpraat_path)
%% init paths....
restoredefaultpath;
addpath(o_ptb_path)

if nargin == 3
    addpath(mpraat_path)
end

o_ptb.init_ptb(ptb_path);

commandwindow;

%% create ptb_config
ptb_config = o_ptb.PTB_Config();

ptb_config.window_scale = 0.25;
ptb_config.flip_horizontal = false;
ptb_config.fullscreen = false;
ptb_config.skip_sync_test = false;
ptb_config.force_datapixx = false;

ptb_config.defaults.text_size = 70;
ptb_config.defaults.fixcross_size = 240;

ptb.config.hide_mouse=false;

% BUTTONS FOR NOUN QUESTIONS
ptb_config.datapixxresponse_config.button_mapping('right') = ptb_config.datapixxresponse_config.Red;
ptb_config.keyboardresponse_config.button_mapping('right') = KbName('RightArrow');
ptb_config.datapixxresponse_config.button_mapping('left') = ptb_config.datapixxresponse_config.Green;
ptb_config.keyboardresponse_config.button_mapping('left') = KbName('LeftArrow');

% BUTTONS FOR STATEMENT QUESTIONS
ptb_config.datapixxresponse_config.button_mapping('false') = ptb_config.datapixxresponse_config.Red;
ptb_config.keyboardresponse_config.button_mapping('false') = KbName('RightArrow');
ptb_config.datapixxresponse_config.button_mapping('true') = ptb_config.datapixxresponse_config.Green;
ptb_config.keyboardresponse_config.button_mapping('true') = KbName('LeftArrow');

ptb_config.real_experiment_sbg_cdk(false);

end
