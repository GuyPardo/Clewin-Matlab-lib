% written by Guy 2020_08

% a rectangle centered at the origin with dimensions wx and wy
% ports:
% top_left, top_right, bottom_left, bottom_right : corners
% left, right, top, bottom : centers of the edges

classdef rect < polygon_element

   methods
       function obj = rect(wx, wy)
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