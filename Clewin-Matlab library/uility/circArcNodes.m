function [nodes] = circArcNodes(R,angle,width,res)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin<4
    res = 100;
end

angleVec = linspace(0,angle, res);
Rout = R+0.5*width;
Rin = R-0.5*width;
nodes = [Rin.*cos(angleVec) ,Rout.*cos(fliplr(angleVec)) ; Rin.*sin(angleVec),Rout.*sin(fliplr(angleVec))]';
end

