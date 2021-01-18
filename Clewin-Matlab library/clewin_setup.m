
% run this from clewin once.
% you have to call this script file clewin_setup.m
% if you copy and paste it won't work and will probably cause a big mess.

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

