classdef star < compound_element
    %UNTITLED9 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function obj = star()
            %UNTITLED9 Construct an instance of this class
            %   Detailed explanation goes here
            lo = layered_object().shift([1000,0]);
            obj.sub_elements.arr = duplicate_circ(lo, pi/2, 5, [0,0]);
        end
        

        end

end

