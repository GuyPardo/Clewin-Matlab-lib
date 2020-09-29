function [output_elem] = duplicate(input_elem,size, spacing)
%written by Guy 2020_08_28
%   returns an element_array object which is a 2D array of copies of
%   input_elem.
%   
%   input arguments:
%   input_elem : any element
%   size : the dimensions of the array given as a 2 vector [rows, collums]
%   spacing : the spcacing between rows and collums, given as a 2 vector.

arr = cell(size(1), size(2));
for i = 1:size(1)
    for j = 1:size(2)
        y = -spacing(1)*(size(1)-1)/2+spacing(1)*(i-1);
        x = -spacing(2)*(size(2)-1)/2+spacing(2)*(j-1);
        arr{i,j} =  input_elem.copy().shift([x,y]);
         
    end
end

output_elem = element_array(arr);

end

