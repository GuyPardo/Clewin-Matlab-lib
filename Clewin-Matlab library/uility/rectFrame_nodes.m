function [nodes] = rectFrame_nodes(Lx,Ly,wx,wy)

%creates a rectangular Lx*Ly frame  with widths wx and wy.
%   Detailed explanation goes here
if nargin<4
    wy=wx;
end

rectW = rectNodes(Lx+2*wx,wy);
rectL = rectNodes(wx,Ly+2*wy);




nodes1 = rectW+transMat(0,-Ly/2-wy/2, length(rectW));
nodes2 =rectW+transMat(0,Ly/2+wy/2, length(rectW));
nodes3 = rectL+transMat( -Lx/2-wx/2,0, length(rectL));
nodes4 = rectL+transMat( Lx/2+wx/2,0, length(rectL));

nodes = [nodes1; nodes2; nodes3; nodes4];
end

