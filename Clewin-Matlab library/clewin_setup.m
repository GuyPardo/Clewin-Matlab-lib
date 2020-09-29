
% run this from clewin once. with lib_path the path to the liberary folder
% by default it is "Z:\Clewin-Matlab library" 
n_chars = numel('clewin_setup');
% full_name =  matlab.desktop.editor.getActiveFilename;
full_name =  mfilename('fullpath');
 lib_path = full_name(1:end-n_chars-1);
% 
 excluded_path = strcat(lib_path,"\excluded_folder" );
% 
addpath(genpath(lib_path));
rmpath(genpath(excluded_path));
 savepath
% 
clearvars
