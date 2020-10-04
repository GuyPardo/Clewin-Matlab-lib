classdef arc < polygon_element
% written by Guy 2020_08_16 a cicular arc defined by a radius R,  an angle
% and width, starting from the positive x direction and going
% counterclockwise.
%
% ports:
%
% center = origin - the center of the circle
% output : the edge at positive x
% input : the other edge
% input_inner : the inner corner of the input edge
% input_outer : the outer corner of the input edge
% output_inner : the inner corner of the output edge
% output_outer : the outer corner of the output edge

    properties
        R % radius
        R_in % inner radius
        R_out % outer radius
        angle 
        width
        length
    end
    
    methods
        function [obj] = arc(R, angle,width, res) % ctor
            % creates an arc element
            %
            % inputs:
            % R - radius of the arc
            % angle - angle of the arc
            % width - width of the arc
            % res (optional, by default = 100) - resolution (no. of points)
            
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
           obj.R_in = R-width/2;
           obj.R_out = R+width/2;
           
           % define ports
           obj.ports.center = [0,0];
           obj.ports.input = [R*cos(angle),R*sin(angle)];
           obj.ports.output = [R,0];
           obj.ports.output_inner = [obj.R_in, 0];
           obj.ports.output_outer = [obj.R_out, 0];
           obj.ports.input_inner = [obj.R_in*cos(angle), obj.R_in*sin(angle)];
           obj.ports.input_outer = [obj.R_out*cos(angle), obj.R_out*sin(angle)];
           
        end
    end

end