classdef circ < polygon_element
 % a basic circle
 % ports:
 % origin: the center of the circle
 % top, bottom, left, right - the point on the perimeter in each direction 
    
    properties
        radius
    end
    
    methods
        function obj = circ(R)
            %circle Construct a circle element with radius R.
            res  = 200; % rendering resolutoin (no of points)

            
            % building the polygon
            theta = transpose(linspace(0,2*pi,res));
            nodes = [R*cos(theta), R*sin(theta)];
            
            %call parent constructor
            obj@polygon_element(nodes)
            
            % define property
            obj.radius = R;
            % define ports
            
            obj.ports.left = [-R,0];
            obj.ports.right = [R,0];
            obj.ports.top = [0,R];
            obj.ports.bottom = [0,-R];
            
        end
        

    end
end

