
clear variables
restoredefaultpath
addpath("C:\Users\0412m\OneDrive\Documenten\MATLAB\fieldtrip-20191213"); %Example path
ft_defaults;
%%
% Frequency analysis
%T=0 is when the cue appears

  
%MyExpdir - Keep   
expdir = "C:\Users\0412m\OneDrive\Bureaublad\Thesis\Final_data_derivatives";

files = dir(expdir);
files(1:2) = []; %This removes extra lines added to the file directory info

%%
% here the data is loaded and separated into the conditions 
nsubj = length(files);

%Stick data Alldata
%All data regardless of accuracy 
    freqStickAllDbBL = cell(1, nsubj);
    freqStickCongAllDbBL = cell(1, nsubj);
    freqStickIncongAllDbBL = cell(1, nsubj);


%Gaze data Alldata
%All data regardless of accuracy 
    freqPeopleAllDbBL = cell(1, nsubj);
    freqPeopleCongAllDbBL = cell(1, nsubj);
    freqPeopleIncongAllDbBL= cell(1, nsubj);



 for subnum = 1:length(files)
subjdir   = fullfile(expdir, files(subnum).name);

% fullfile(file_eeg.folder, file_eeg.name);

    CurrentDir = strcat(subjdir, '\ProcessedData');
    out_dir = strcat(subjdir, '\results');
    if ~exist(out_dir, 'dir')
        mkdir(out_dir)
    end

    datafileC = fullfile(CurrentDir, 'data_ica.mat');
      
    data_freqShifttoProbe= load(datafileC);


%All Acc data Overall Stick          
%Stick All Stick data 
            cfg=[];
            cfg.trials = find( data_freqShifttoProbe.trialinfo(:,6)==1);
            freqCueShift_StickAll = ft_selectdata(cfg,  data_freqShifttoProbe); 
%Stick All Stick Cong data 
            cfg=[];
            cfg.trials = find( data_freqShifttoProbe.trialinfo(:,1)==1);
            freq_StickCongAll = ft_selectdata(cfg,  data_freqShifttoProbe);
%Stick All Stick Incong data 
            cfg=[];
            cfg.trials = find( data_freqShifttoProbe.trialinfo(:,1)==2);
            freq_StickIncongAll = ft_selectdata(cfg,  data_freqShifttoProbe);
        
%%
%All Acc data Overall People                
%People All people data 
            cfg=[];
            cfg.trials = find( data_freqShifttoProbe.trialinfo(:,6)==2);
            freqCueShift_PeopleAll = ft_selectdata(cfg,  data_freqShifttoProbe);
%People All People Cong data 
            cfg=[];
            cfg.trials = find( data_freqShifttoProbe.trialinfo(:,1)==3);
            freq_PeopleCongAll = ft_selectdata(cfg,  data_freqShifttoProbe);            
%People All People Incong data 
            cfg=[];
            cfg.trials = find( data_freqShifttoProbe.trialinfo(:,1)==4);
            freq_PeopleIncongAll = ft_selectdata(cfg,  data_freqShifttoProbe);
                
            
%Freq analysis
            
cfg = [];
cfg.channel    = {'all'}; 
cfg.method     = 'wavelet';
cfg.width      = 3; % three cycles per time-window in steps of 50ms  
cfg.output     = 'pow'; % return the power-spectra
cfg.pad        = 'nextpow2';
cfg.foi        = 2:1:30; % meaning  2-30Hz (for every 1Hz)
cfg.toi        = -0.7:0.05:6.0; %   From inter trial interval to 1.5 second after first probe shown


freqStickAll  = ft_freqanalysis(cfg, freqCueShift_StickAll);
freqStickCongAll  = ft_freqanalysis(cfg, freq_StickCongAll);
freqStickIncongAll  = ft_freqanalysis(cfg, freq_StickIncongAll);

%People

freqPeopleAll  = ft_freqanalysis(cfg, freqCueShift_PeopleAll);
freqPeopleCongAll  = ft_freqanalysis(cfg, freq_PeopleCongAll);
freqPeopleIncongAll  = ft_freqanalysis(cfg, freq_PeopleIncongAll);


% Baseline correction decibel baseline

cfg = [];
cfg.baseline     = [-0.5 -0.1];
cfg.baselinetype = 'db';
cfg.parameter    = 'powspctrm';

freqStickAllDbBL{subnum} = ft_freqbaseline(cfg,  freqStickAll);
freqStickCongAllDbBL{subnum} = ft_freqbaseline(cfg, freqStickCongAll);
freqStickIncongAllDbBL{subnum} = ft_freqbaseline(cfg, freqStickIncongAll);

%People

freqPeopleAllDbBL{subnum} = ft_freqbaseline(cfg,  freqPeopleAll);
freqPeopleCongAllDbBL{subnum} = ft_freqbaseline(cfg, freqPeopleCongAll);
freqPeopleIncongAllDbBL{subnum} = ft_freqbaseline(cfg, freqPeopleIncongAll);

%save("C:\Users\0412m\OneDrive\Bureaublad\Thesis\wavelet_trans", 'freqStickAllDbBL{subnum}')
%save("C:\Users\0412m\OneDrive\Bureaublad\Thesis\wavelet_trans", 'freqStickCongAllDbBL{subnum}')
%save("C:\Users\0412m\OneDrive\Bureaublad\Thesis\wavelet_trans", 'freqStickIncogAllDbBl{subnum}')
%save("C:\Users\0412m\OneDrive\Bureaublad\Thesis\wavelet_trans", 'freqPeopleAllDbBL{subnum}')
%save("C:\Users\0412m\OneDrive\Bureaublad\Thesis\wavelet_trans", 'freqPeopleCongAllDbBL{subnum}')
%save("C:\Users\0412m\OneDrive\Bureaublad\Thesis\wavelet_trans", 'freqPeopleIncongAllDbBL{subnum}')

 end
 
 % compute grandaverage spectra
cfg         = [];
cfg.keepindividual = 'yes';
 % compute grandaverage spectra

gafreqStickAlldb = ft_freqgrandaverage(cfg, freqStickAllDbBL{:});
gafreqStickCongAlldb = ft_freqgrandaverage(cfg, freqStickCongAllDbBL{:});
gafreqStickIncongAlldb = ft_freqgrandaverage(cfg, freqStickIncongAllDbBL{:});


%People

gafreqPeopleAlldb = ft_freqgrandaverage(cfg, freqPeopleAllDbBL{:});
gafreqPeopleCongAlldb = ft_freqgrandaverage(cfg, freqPeopleCongAllDbBL{:});
gafreqPeopleIncongAlldb = ft_freqgrandaverage(cfg, freqPeopleIncongAllDbBL{:});
