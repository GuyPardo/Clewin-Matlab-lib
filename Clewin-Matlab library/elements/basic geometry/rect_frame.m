% written bt Guy 2020_08
% a rectangular frame of size Lx * Ly , and frame widths wx and wy
% ports : for now only the origin, maybe add later corners etc..
classdef rect_frame  < compound_element
    methods
        function [obj] = rect_frame(Lx, Ly, wx, wy)
            
            if nargin<4
                wy = wx;
            end
            





            obj.elements.rect1 = rect(Lx+wx,wy).shift([0,-Ly/2]);
            obj.elements.rect2 = rect(Lx+wx,wy).shift([0,Ly/2]);
            obj.elements.rect3 = rect(wx,Ly+wy).shift( [-Lx/2,0]);
            obj.elements.rect4 = rect(wx,Ly+wy).shift( [Lx/2,0]);
        end
    end
    
end