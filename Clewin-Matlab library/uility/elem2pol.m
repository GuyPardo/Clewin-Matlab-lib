function [pol] = elem2pol(elem)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
pol = polyshape(elem.nodes);
end

