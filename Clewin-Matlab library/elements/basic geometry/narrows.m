classdef narrows < compound_element
    %NARROWS a circular array of n  equidistant arrows (n is an input argument) pointing
    % towards the origin. 
    %   
    % input arguments for ctor:
    % n - number of arrows
    %
    % optional parameters (call with name-value pair):
    % 
    % arrow_l (default value: 1000) length of each arrow
    % arrow_w (default value: 100) width of each arrow
    % gap (defualt value: 200) : size of the gap at the origin between the
    % arrows  = the distance between two opposing arrow heads.
    %
    %ports: for now just the origin. 
    
    
    properties
        arrow_l
        arrow_w
        gap
        n
    end
    
    methods
        function obj = narrows(n,varargin)
            %NARROWS Construct an instance of this class
            %   Detailed explanation goes here
            p = inputParser;
            p.addParameter('arrow_l', 1000);
            p.addParameter('arrow_w', 100);
            p.addParameter('gap', 200);
            
            p.parse(varargin{:});
            obj.arrow_l = p.Results.arrow_l;
            obj.arrow_w = p.Results.arrow_w;
            obj.gap = p.Results.gap;
            obj.n = n;
            
            
            unit_arrow = arrow(obj.arrow_l, obj.arrow_w).place('head', [0,obj.gap/2]);
            obj.elements.grid = unit_arrow.duplicate_circ(2*pi/n,n, [0,0]); 
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

