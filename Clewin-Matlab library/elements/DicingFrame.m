% written by Samuel 2020_08_30
% Creates array of DicingLines
% ports:
% center = origin - the center of array
%AM marks are alignment marks (write in mm as list, e.g. [ -6 -6; 6 -6; -6 6; 6 6] 

classdef DicingFrame < compound_element
   properties
      ChipNumber
      thickness
      L_Vertical
      L_Horizontal
      N_Horizontal
      N_Vertical
   end
   
   methods
        function [obj] = DicingFrame(L_Horizontal,L_Vertical,N_Horizontal,N_Vertical,AM_pos,thickness)
            if nargin<6
                thickness = 50;
            end    
            Ideal_Die = rect_frame(L_Horizontal,L_Vertical,thickness,thickness);
            
%             MyCellArray=cell(N_Horizontal,N_Vertical);
            
            
%             for nh=1:N_Horizontal 
%               for nv=1:N_Vertical 
%               MyCellArray{nh,nv}=Ideal_Die.copy().shift([L_Horizontal*(nh-1) L_Vertical*(nv-1)]);
%               end  
%             end
            obj@compound_element();             
            Temp=duplicate(Ideal_Die,[N_Horizontal,N_Vertical],[L_Horizontal,L_Vertical]);
            
            obj.elements.lines=Temp;
                    
            obj.thickness = thickness;
            obj.ChipNumber=N_Horizontal*N_Vertical;
            obj.L_Horizontal = L_Horizontal;
            obj.L_Vertical = L_Vertical;
            obj.N_Horizontal = N_Horizontal;
            obj.N_Vertical = N_Vertical;
            
            obj.ports.center = [0,0];
            
            %create alignment marks and tags
            
            obj.elements.AM_nameA=text_element('A',6000); 
            obj.elements.AM_nameA.shift([80+AM_pos(1,1)*1e3 -30+AM_pos(1,2)*1e3]);
            obj.elements.AM_A=alignment_M();
            obj.elements.AM_A.shift([AM_pos(1,1)*1e3 AM_pos(1,2)*1e3]);
            
            obj.elements.AM_nameB=text_element('B',6000); 
            obj.elements.AM_nameB.shift([80+AM_pos(2,1)*1e3 -30+AM_pos(2,2)*1e3]);
            obj.elements.AM_B=alignment_M();
            obj.elements.AM_B.shift([AM_pos(2,1)*1e3 AM_pos(2,2)*1e3]);
            
            obj.elements.AM_nameC=text_element('C',6000); 
            obj.elements.AM_nameC.shift([80+AM_pos(3,1)*1e3 -30+AM_pos(3,2)*1e3]);
            obj.elements.AM_C=alignment_M();
            obj.elements.AM_C.shift([AM_pos(3,1)*1e3 AM_pos(3,2)*1e3]);
            
            obj.elements.AM_nameD=text_element('D',6000); 
            obj.elements.AM_nameD.shift([80+AM_pos(4,2)*1e3 -30+AM_pos(4,2)*1e3]);
            obj.elements.AM_D=alignment_M();
            obj.elements.AM_D.shift([AM_pos(4,1)*1e3 AM_pos(4,2)*1e3]);
            
            end
           end
        
   end
