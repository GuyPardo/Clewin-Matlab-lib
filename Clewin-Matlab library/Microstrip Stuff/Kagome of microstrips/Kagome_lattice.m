% written by Samuel, 10.09.20
classdef Kagome_lattice  < compound_element
    methods
        function [obj] = Kagome_lattice(KB,Lattice_Size)
           obj@compound_element();
           
           %KB = Kagome brick - 4 triangles
            
           %Find triangle side length (of basic unit):
            TSL=abs( KB.elements.triangleU.elements.bottom.ports.input(1) - KB.elements.triangleU.elements.bottom.ports.output(1)); 
          
            obj.elements.buildingBlocks  = duplicate(KB,Lattice_Size,[4*TSL*cos(pi/6),2*TSL]);
          
        end
    end
    
end