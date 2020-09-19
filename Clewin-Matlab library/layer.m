classdef layer < matlab.mixin.Copyable
    %LAYER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id % an integer 0,1,2,...
        name % a string
        elements % a cell array of elements to be drawn in this layer
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
            
            obj.elements = {};
            

        end
        
        function [] = draw(obj)
            % draws all the elements in the layer                   
            set_layer(obj.id);
            cellfun(@(x) x.draw(), obj.elements, 'uniformoutput', false);
        end
        function [obj] = append(obj, element)
            % appends element to layer
            obj.elements{end+1} =   element;
        end
        
        function [obj] = remove(obj, element)
            obj.elements = setdiff(obj.elements, {element})
            
        end
    end
end

