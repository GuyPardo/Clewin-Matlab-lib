function [out] = seperate_nan(mat)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

% getting rid of nan rows and seperating into cells:
idx = all(isnan(mat),2);

idr = diff(find([1;diff(idx);1]));
 D = mat2cell(mat,idr(:),size(mat,2));
out = D(1:2:end);

end

