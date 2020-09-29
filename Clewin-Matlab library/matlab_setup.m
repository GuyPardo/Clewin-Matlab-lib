
% run this from matlab  

n_chars = numel('matlab_setup');
%full_name =  matlab.desktop.editor.getActiveFilename;
full_name = mfilename('fullpath');
 lib_path = full_name(1:end-n_chars-1);
% 

% 
addpath(genpath(lib_path));

 savepath
%
clearvars

