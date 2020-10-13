function cfg = prepare_cfg(targetvoice, targetphoneme) %ADD WHICH TARGET SPEAKER AND TARGET PHONEME

cfg = [];
cfg.data_path = 'data_test';
cfg.targetvoice = targetvoice;
cfg.targetphoneme = targetphoneme;
%WAVFILES
%TEXTGRIDS



% cfg.stim.sine.freq = 1732;
% cfg.stim.sine.duration = 0.3;
% cfg.stim.sine.add_db = 35;
% cfg.stim.noise.duration = 0.1;
% cfg.stim.noise.bandstop_octave = 0.1;
% cfg.stim.noise.transition_factor = 0.02;
% cfg.stim.ramps = 0.005;
% cfg.stim.snrs = -30:3:-2;
% cfg.sounds_per_trial = 20;
% cfg.ml.db_range = -40:-0.5:-100;
% cfg.ml.false_alarm = 0;
% cfg.ml.slope = 0.5;
% cfg.ml.start = -40;
% cfg.ml.mean_onset_delay = 0.5;
% cfg.ml.onset_jitter = 0.1;
% cfg.ml.post_sound_delay = 0.2;
% cfg.noise_discomfort.db_steps = [3, 2, 1];
% cfg.noise_discomfort.post_sound_delay = 0.2;
% cfg.noise_discomfort.onset_delay = 0.2;
% cfg.noise_discomfort.initial_add_db = 40;
% cfg.noise_discomfort.decrease_factor = 3;


end