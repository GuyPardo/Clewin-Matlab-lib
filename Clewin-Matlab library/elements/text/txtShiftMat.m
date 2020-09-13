function [Mat] = txtShiftMat(shift_vec)
%written by Guy 2020_08_23
%  create a 3x3 matrix that when used in clewin with function 
% text (str, Mat) draws the text of str shifted by shift_vec 
Mat =[1 0 shift_vec(1); 0 1 shift_vec(2); 0 0 1];

end
