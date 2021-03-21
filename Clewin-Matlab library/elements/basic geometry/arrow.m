classdef arrow < compound_element
    %ARROW Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        length
        width
    end
    
    methods
        function obj = arrow(length,width)
            %ARROW Construct an instance of this class
            %   Detailed explanation goes here
            obj.length = length; obj. width = width;
            
            head_size = width*1.5;
            
            obj.elements.rectangle = rect(width, length-head_size);
            trig_nodes =  [-head_size/2,0;
                              head_size/2,0;
                              0,-head_size;
                              -head_size/2,0
                              ];
                          
            obj.elements.triangle = polygon_element(trig_nodes).shift([0,-(length-head_size)/2]);
            obj.ports.tail = obj.elements.rectangle.ports.top;
            obj.ports.head = [0,-length/2-head_size/2];
            
        end
        

    end
end

