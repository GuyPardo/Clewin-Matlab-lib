% written by Samuel, 10.09.20
classdef Kagome_Houck  < compound_element
    methods
        function [obj] = Kagome_Houck(KC,Lattice_Size)
            %Takes kagome cross and makes a lattice
            % call parent constructor
           obj@compound_element();
           
           %Find triangle side length (of basic unit):
           x_space=abs(KC.ports.top(1)-KC.ports.right(1));
           y_space=abs(KC.ports.top(2)-KC.ports.bottom(2));

           %obj.sub_elements.Cross2   = KC.copy().place("top",obj.sub_elements.Cross1.ports.right);
           
           obj.sub_elements.buildingBlocks1  = duplicate(KC,Lattice_Size,[y_space,2*x_space]);
           obj.sub_elements.buildingBlocks2  = duplicate(KC.copy().place("right",KC.ports.top),Lattice_Size,[y_space,2*x_space]);
        end
    end
    
end