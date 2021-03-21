classdef narrows < compound_element
    %NARROWS Summary of this class goes here
    %   Detailed explanation goes here
    
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
            p.addParameter('gap', 100);
            
            p.parse(varargin{:});
            obj.arrow_l = p.Results.arrow_l;
            obj.arrow_w = p.Results.arrow_w;
            obj.gap = p.Results.gap;
            obj.n = n;
            
            
            unit_arrow = arrow(obj.arrow_l, obj.arrow_w).place('head', [0,obj.gap/2]);
            obj.elements.grid = unit_arrow.duplicate_circ(2*pi/n,n); 
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

