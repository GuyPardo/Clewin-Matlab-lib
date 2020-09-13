% written by Guy 2020_08_16
% a cicular arc defined by a radius R,  an angle and width, starting from the positive x
% direction and going counterclockwise. 
% ports:
% center = origin - the center of the circle
% output : the edge at positive x
% input : the other edge
% TODO : maybe we also want middle?

classdef arc < polygon_element
    properties
        R
        angle
        width
        length
    end
    
    methods
        function [obj] = arc(R, angle,width, res)
           if nargin < 4
               res = 100;
           end
           % call parent constructor
           obj@polygon_element(circArcNodes(R, angle,width, res));
           
           % define properties
           obj.R=R;
           obj.angle = angle;
           obj.width = width;
           obj.length = angle*R;
           
           % define ports
           obj.ports.center = [0,0];
           obj.ports.input = [R*cos(angle),R*sin(angle)];
           obj.ports.output = [R,0];
           
           
        end
    end

end