function [pol] = elem2pol(elem)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
warning('off');
pol = polyshape(elem.nodes);
warning('on');
end

