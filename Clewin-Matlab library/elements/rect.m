classdef rect < polygon_element
% written by Guy 2020_08
%
% a rectangle centered at the origin with dimensions wx and wy
%
% ports:
%
% top_left, top_right, bottom_left, bottom_right : corners
% left, right, top, bottom : centers of the edges
% note that the names of the ports refer to the rectangle when it was
% created. they might become confusing after rotation etc. for example, if
% you rotate the rectangle by pi/2, the port left will correspond to the
% the bottom edge.
    

   methods
       function obj = rect(wx, wy) %ctor
           % call parent ctor
           obj@polygon_element([-wx/2, -wy/2;
                        -wx/2, wy/2;
                        wx/2, wy/2;
                        wx/2, -wy/2;
                        -wx/2, -wy/2
           
                        ])
            % define ports
            % the naming of the ports refers to the the rectangle when it
            % is created. if, for example, we rotate it later, the names
            % could become confusing maybe?
            % TODO - check this issue later while working with this stuff.
            obj.ports.top_left = [-wx/2,wy/2];
            obj.ports.top_right = [wx/2,wy/2];
            obj.ports.bottom_left = [-wx/2,-wy/2];
            obj.ports.bottom_right = [wx/2,-wy/2];
            
            obj.ports.left = [-wx/2,0]; % the center of the left edge 
            obj.ports.right = [wx/2 ,0];
            obj.ports.top = [0,wy/2];
            obj.ports.bottom = [0,-wy/2];
       end
   end
   
   
end