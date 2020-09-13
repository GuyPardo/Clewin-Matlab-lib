function [Mat] = txtScaleMat(scaleFactor)
% Written by Guy 2020_08
% scaleMat(scaleFactor) creates a Clewin transformation matrix that scales by a factor scaleFactor 
% 
Mat = [scaleFactor, 0,0; 0,scaleFactor,0;0,0,1];
end

