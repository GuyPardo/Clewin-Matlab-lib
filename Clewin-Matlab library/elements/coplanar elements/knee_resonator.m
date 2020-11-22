classdef knee_resonator < compound_element 
    % written by Guy and Samuel. editted by Guy 09/10/20
    % a coplanar resonator with length total_l, and a knee-type coupling
    % of length coupling_l.
    %
    % input arguments for ctor:
    %
    % required arguments:
    %   total_l - total length of resonator
    %   coupling_l = length of coupling segment
    %
    % optional parameters (call with name-value pair ot input a struct):
    %   trace_w: width of the trace (metal) . default value: 8
    %   gap_w: width of the gap (insulator . default value: 5
    %   segment_l : the length of the bulk N-2 segments of the meander. there
    %               are another two segments of length segmentl/2 in the input and in the
    %               output. default value: 500
    %   distance : the distance between the segments ( = the diameter of the
    %   arcs). default value: 200
    %
    %   to make a tight-meander , set distance = trace_w + gap_w;
    %
    % ports:
    % input - the end of the coupling knee
    % output - the other end of the resonator
    % origin = center - the center of the meander.

   properties
       length
       trace_w
       gap_w
       boundaries
       coupling_l
   end
   
   methods
       %cosntructor
       
       
       function [obj] = knee_resonator( total_l, coupling_l , varargin)
       
        % input parsing
           
            % default configuration:
            trace_w_def = 8;
            gap_w_def = 5;
            boundaries_def = [0,0];
            segment_l_def = 500;
            distance_def = 200;
            
            % input parser object
            p = inputParser;
            addRequired(p,'total_l');
            addRequired(p, 'coupling_l')
            addParameter(p, 'trace_w', trace_w_def);
            addParameter(p, 'gap_w', gap_w_def);
            addParameter(p, 'boundaries', boundaries_def);
            addParameter(p, 'segment_l', segment_l_def);
            addParameter(p, 'distance', distance_def);
            parse(p, total_l,coupling_l, varargin{:});
            
            % read arguments
            total_l = p.Results.total_l;
            coupling_l = p.Results.coupling_l;
            trace_w = p.Results.trace_w;
            gap_w = p.Results.gap_w;
            segment_l = p.Results.segment_l;
            distance = p.Results.distance;
            boundaries = p.Results.boundaries;   
           % meander parameters
            meander_params.trace_w = p.Results.trace_w;
            meander_params.gap_w = p.Results.gap_w;
            meander_params.segment_l = p.Results.segment_l;
            meander_params.distance = p.Results.distance;
           
       obj.boundaries = boundaries;    
       obj.elements.CouplingKnee=coplanar_line(coupling_l,trace_w,gap_w,[1 0]);
       obj.elements.res_arc=coplanar_arc(distance/2,pi/2,trace_w,gap_w).place('input', obj.elements.CouplingKnee.ports.output);
       
       target_l =  total_l - obj.elements.CouplingKnee.length - obj.elements.res_arc.length;          
           for N=1:100
                    test_res=coplanar_meander(N, meander_params);
                    if test_res.get_length()> target_l
                        NO_hor=N-1;
                        break
                    end          
           end
           
           if NO_hor ==0 
              error('computed number of segments is zero. total_l is too small.') 
           end
           
           obj.elements.mea = coplanar_meander( NO_hor, meander_params).rotate(-pi/2);
           
           add_l = target_l - obj.elements.mea.get_length();
           
           obj.elements.downLine=coplanar_line(add_l/2,trace_w,gap_w).rotate(-pi/2).place('input', obj.elements.res_arc.ports.output);
           obj.elements.mea.place('input', obj.elements.downLine.ports.output);
           obj.elements.outLine =  coplanar_line(add_l/2,trace_w,gap_w).rotate(-pi/2).place('input', obj.elements.mea.ports.output);
          
            % defining ports etc
           
           obj.ports.input = obj.elements.CouplingKnee.ports.input;
           obj.ports.output = obj.elements.outLine.ports.output;
    
          obj.ports.center = obj.elements.mea.ports.center;
          
          obj.trace_w = trace_w;
          obj.gap_w = gap_w;
          obj.length = obj.get_length();
          obj.coupling_l = coupling_l;
          obj.shift(-obj.ports.center);
          obj.ports.origin = [0,0];
           
       end
         
       function [len] = get_length(obj)
        % loop on elements
        field_names = fieldnames(obj.elements);
        len = 0;   
            for k = 1:numel(field_names)
                   len = len + obj.elements.(field_names{k}).length;
            end      
            
       end
           
       end
       
end
   
    

















