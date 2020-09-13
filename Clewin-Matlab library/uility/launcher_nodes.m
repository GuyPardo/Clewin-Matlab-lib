function [nodes] = launcher_nodes(contact_size,line_w, line_gap,adiabatic_l, boundary_w)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% written 14.08.19
%create contact pad
%dimensions are in micrones.

%assuming the origin is in the input of the line

%% derived parameters
ratio = line_gap/line_w;
contact_gap = contact_size*ratio; 

%% define points
nodes = ... 
[
 0, line_w/2+line_gap;
 -adiabatic_l, contact_size/2 + contact_gap;
 -adiabatic_l - contact_size - boundary_w ,contact_size/2 + contact_gap;
 -adiabatic_l - contact_size - boundary_w, -contact_size/2 - contact_gap;
 -adiabatic_l, -contact_size/2 - contact_gap;
 0,-line_w/2-line_gap;
 0,-line_w/2;
 -adiabatic_l, -contact_size/2;
 -adiabatic_l-contact_size, -contact_size/2;
 -adiabatic_l-contact_size, +contact_size/2;
 -adiabatic_l, +contact_size/2;
 0,line_w/2
];

end

