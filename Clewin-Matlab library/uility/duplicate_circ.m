function [output_elem] = duplicate_circ(input_elem,angle, N,origin, rotate)
%written by Guy 2020_08_28
%   returns an element_array which is a circular  array of copies of
%   input_elem
%
%   input arguments:
%   input_elem : any element object
%   angle : the angle between successive copies 
%   N : number of copies
%   origin : the origin for the circle, given as a 2 vector
%   rotate(optional): a boolian. if true, the copies are also rotated about
%   their respective origins. by default it is true.
if nargin < 4
    origin = [0,0];
end
if nargin<5
    rotate = true;
end

pos = input_elem.ports.origin - origin;
R = sqrt(pos(1)^2 + pos(2)^2);

angle_in = atan(pos(2)/pos(1));
arr = cell(1,N);
for i = 1:N
        angle_temp = angle_in + angle*(i-1);
        x = R*cos(angle_temp);
        y = R*sin(angle_temp);
        
        arr{i} =  copy(input_elem).place('origin',[x,y] + origin);
        if rotate
            arr{i}.rotate(angle*(i-1))
        end
         

end

output_elem = element_array(arr);

end