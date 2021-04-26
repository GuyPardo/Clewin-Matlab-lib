classdef ebeam_AMs < compound_element
    % A-B-C-D  alignment-marks for ebeam
    %   4 alignment marks labelled A,B,C,D, arranged  in a rectangle around
    %   the origin of the element
    %
    % inputs for ctor:
    % W_x ,W_y : rectangle dimensions
    % R (optional) : alignment mark size, default value: 0
    % pos_label (parameter - call with name-value pair): a booliean . if
    % true the element will also include a label with the coordinates of
    % each AM, in mm. default value: true.
    
    properties
        Wx % rectangle x dimension
        Wy % rectangle y dimensio
        R % size of AMs
        pos_label % a logical flag to determine whether t include coordinates in label 
    end
    
    methods
        function obj = ebeam_AMs(Wx,Wy,varargin)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            % input parsing
            obj.Wx = Wx; obj.Wy=Wy;
            p = inputParser;
            p.addOptional('R',30);
            p.addParameter('pos_label',true)
            
            parse(p,varargin{:})
            
            obj.R = p.Results.R;
            obj.pos_label = p.Results.pos_label;
            
            % actual_ctor
            obj.elements.A = alignment_M(obj.R, 'A').place('origin', [-Wx/2, -Wy/2]);
            obj.elements.B = alignment_M(obj.R,'B').place('origin', [+Wx/2, -Wy/2]);
            obj.elements.C = alignment_M(obj.R,'C').place('origin', [+Wx/2, +Wy/2]);
            obj.elements.D = alignment_M(obj.R,'D').place('origin', [-Wx/2, +Wy/2]);
            

        end
        
        function [obj] = draw(obj)
            %envelope for elemet's draw - to recalculate coordinates for
            %labels before drawing
            if obj.pos_label
                obj.elements.A.elements.text.txt_str = sprintf('A [%.3g, %.3g]',obj.elements.A.ports.origin(1)/1000, obj.elements.A.ports.origin(2)/1000);
                obj.elements.B.elements.text.txt_str = sprintf('B [%.3g, %.3g]',obj.elements.B.ports.origin(1)/1000, obj.elements.B.ports.origin(2)/1000);
                obj.elements.C.elements.text.txt_str = sprintf('C [%.3g, %.3g]',obj.elements.C.ports.origin(1)/1000, obj.elements.C.ports.origin(2)/1000);
                obj.elements.D.elements.text.txt_str = sprintf('D [%.3g, %.3g]',obj.elements.D.ports.origin(1)/1000, obj.elements.D.ports.origin(2)/1000);
            end
            draw@compound_element(obj);
            
        end
    end
end

