classdef layer < matlab.mixin.Copyable
    %LAYER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id % an integer 0,1,2,...
        name % a string     
    end
    
    methods
        function obj = layer(id, name)
            %LAYER Construct an instance of this class
            if nargin > 0
               obj.id = id;
            end
            
            if nargin  > 1
                obj.name = name;
            end
        end
            
           


    end
end

