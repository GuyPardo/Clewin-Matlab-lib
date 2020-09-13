
% run this from matlab  

n_chars = numel('matlab_setup.m');
full_name =  matlab.desktop.editor.getActiveFilename;
 lib_path = full_name(1:end-n_chars-1);
% 

% 
addpath(genpath(lib_path));

 savepath
% 

