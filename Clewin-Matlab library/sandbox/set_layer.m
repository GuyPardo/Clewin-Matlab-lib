function [  ] = set_layer(id)
% an envelope function for setlayer
%   running setlayer from the base workspace
evalin('base',sprintf("setlayer('#%d')", id));
end

