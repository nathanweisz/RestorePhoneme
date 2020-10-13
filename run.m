%% clear...
clear all global
close all

o_ptb_path = '/Users/b1019548/Documents/GitHub/o_ptb';
ptb_path = '/Users/b1019548/Documents/GitHub/Psychtoolbox-3/Psychtoolbox/';
mpraat_path= '~/Documents/GitHub/mPraat/';

exp.init.config_ptb(o_ptb_path, ptb_path, mpraat_path);

%% set variables....
subject_id = 'Fritz';

targetvoice = 'Fabi';
targetphoneme = 'E';

%% prepare...
exp.init.prepare_subject(subject_id, targetvoice, targetphoneme);
load(fullfile('data_test', subject_id))

%% RUN SOMETHING TO ADJUST VOLUME

subj_data.ambientrms = exp.parts.matchambientlevel(subj_data, o_ptb_path, ptb_path);
save(fullfile('data_test', subject_id), 'subj_data')

%% run Resting

subj_data=exp.parts.resting(subj_data, o_ptb_path, ptb_path);
save(fullfile('data_test', subject_id), 'subj_data') 

%% run LOCALIZER
%20 mins audiobook?
%https://www.gratis-hoerspiele.de/der-stumme-tod-das-hoerspiel-zu-babylon-berlin-staffel-2/
%cut into 4x3 mins pieces

%% run real thing

for blocknum = 1:length(subj_data.stims.block)
    fprintf('Running block %i from %i\n', blocknum, length(subj_data.stims.block))
    [PointsNoiseTarget PointsNoiseDistract Response]=exp.parts.presentsounds(subj_data, blocknum,...
        o_ptb_path, ptb_path, mpraat_path);
    
    subj_data.blocks_complete = subj_data.blocks_complete +1;
    subj_data.stims.block{subj_data.blocks_complete}.PointsNoiseTarget = PointsNoiseTarget;
    subj_data.stims.block{subj_data.blocks_complete}.PointsNoiseDistract = PointsNoiseDistract;
    subj_data.stims.block{subj_data.blocks_complete}.Response = Response;
    
    save(fullfile('data_test', subject_id), 'subj_data') %
end

fprintf('Done!\n')