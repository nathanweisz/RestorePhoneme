function ptb = init_ptb(ptb_config)
%% init ptb...
ptb = o_ptb.PTB.get_instance(ptb_config);
ptb.setup_audio();
ptb.setup_trigger();
ptb.setup_screen();
ptb.setup_response();
end
