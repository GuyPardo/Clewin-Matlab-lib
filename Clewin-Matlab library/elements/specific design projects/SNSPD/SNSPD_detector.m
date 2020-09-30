classdef SNSPD_detector < compound_element
    % an SNSPD_meander with an adiabatic opening
    %   rotated by 90 degrees such that the opening is above the meander
    %
    % ports:
    %
    % input : the wide part of the adiabatic opening
    % output : the opposite end of the meander
    % origin: is the origin of the meander (it's center).
    %
    % input arguments for constructor:
    %
    % trace_w - width of metal in meander
    % gap_w - width of insulator in meander
    % segment_l - meander segment length
    % adiabatic_l - adiabatic opening length
    % final_w - adiabatic opening final (large) width
    %
    % you can also call the ctor with no arguments at all: detector() to get
    % the default values for these parameters:
    % trace_w = .200 gap_w = .200 segment_l=10 adiabatic_l=18 final_w = 18
    
    
    methods
        function obj = SNSPD_detector(trace_w, gap_w, segment_l,adiabatic_l, final_w)
            %DETECTOR Construct an instance of this class.
            
            % default configurations:
            if nargin<1
               trace_w = .200; gap_w = .200; segment_l=10; adiabatic_l=18; final_w = 18;
            end
            
            
            mea = SNSPD_meander(trace_w, gap_w, segment_l);
            ad = adiabatic_opening(adiabatic_l, trace_w, gap_w, final_w).place('input', mea.ports.output);
            
            obj.sub_elements.meander = mea;
            obj.sub_elements.adiabatic = ad;
            
            obj.rotate(pi/2);
            
            %ports
            obj.ports.input  = obj.sub_elements.adiabatic.ports.output;
            obj.ports.output  = obj.sub_elements.meander.ports.input;
            
            
        end

    end
end

