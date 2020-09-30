classdef circle < polygon_element
 % a basic circle
    
    properties
        radius
    end
    
    methods
        function obj = circle(R)
            %circle Construct a circle element with radius R.
            res  = 200; % rendering resolutoin (no of points)

            
            % building the polygon
            theta = transpose(linspace(0,2*pi,res));
            nodes = [R*cos(theta), R*sin(theta)];
            
            %call parent constructor
            obj@polygon_element(nodes)
            
            % define property
            obj.radius = R;
            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end
