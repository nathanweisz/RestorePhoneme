function prepare_subject( subject_id, targetvoice, targetphoneme)

%% set paths
cfg = exp.init.prepare_cfg(targetvoice, targetphoneme);

if ~exist(cfg.data_path)
  mkdir(cfg.data_path);
end %if

if exist(fullfile(cfg.data_path, [subject_id '.mat']))
  fprintf('The Subject is already prepared. You can load the precomputed Stimlist.\n');
  
else
    subj_data.stims = exp.init.prepare_stim_list(cfg);
    subj_data.blocks_complete = 0;
    save(fullfile(cfg.data_path, subject_id), 'subj_data');
    
end %if


end

