classdef layered_object<compound_element
    %layered_object is a simple example of a multi-layer compound element
    %   Detailed explanation goes here
    
    methods
        function obj =layered_object()
            % Construct an instance of this class
            
            %define two layers
            L0 = layer(0, 'Layer 0');
            L1 = layer(1, 'Layer 1');

            % define sub elements:
            obj.sub_elements.line = coplanar_line(1000,8,5).set_layer(L0); % coplanar_line in layer 0
            obj.sub_elements.rec = rect(1000,8).set_layer(L1); % rectangle in layer 1
        
        end
    end
end

