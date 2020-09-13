% written by Guy 2020_08
% an abstract coplanat element with some trace and some gap.
% boundaries is a 2 row vector defining the boundarie of the coplanar
% element: [0,0] is open on both sides, [1,0] closed on the left and open
% on the right etc..
% this has to be implemented in the constructor of the specific element.
% for an example see coplanar_line.m
classdef coplanar_element < compound_element
    properties
        trace_w
        gap_w
        boundaries
    end
    methods
        function [obj] = coplanar_element()
        end
    end
end