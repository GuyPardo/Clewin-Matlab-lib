classdef layered_object<compound_element
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       
    end
    
    methods
        function obj =layered_object()
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            L0 = layer(0, 'Layer 0');
            L1 = layer(1, 'Layer 1');

            obj.sub_elements.line = coplanar_line(1000,8,5).set_layer(L0);
            obj.sub_elements.rec = rect(1000,8).set_layer(L1);
        
        end
    end
end

