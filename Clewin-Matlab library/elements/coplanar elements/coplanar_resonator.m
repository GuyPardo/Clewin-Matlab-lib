
classdef coplanar_resonator < compound_element
% written by Guy 2020_08
% a meandering coplanar resonator with total length total_l.
%  built from a coplanar_meander and two additional coplanar lines to reach the
%  desired total_l
%
% input arsuments for ctor:
% 
% required arguments:
% total_l - the total length of the resonator
%
% optional parameters ( use with name-value pair syntax, or input a
% struct):
%   trace_w: width of the trace (metal) . default value: 8
%   gap_w: width of the gap (insulator . default value: 5
%   segment_l : the length of the bulk N-2 segments of the meander. there
%               are another two segments of length segmentl/2 in the input and in the
%               output. default value: 500
%   distance : the distance between the segments ( = the diameter of the
%   arcs). default value: 200
%
%   to make a tight-meander , set distance = trace_w + gap_w;

% ports:
% input
% output
% center

 % sub elements (call with obj.elements):
 % line_in
 % line_out
 % meander


   properties
      length
      trace_w
      gap_w
      boundaries       
   end
   
   methods
       function [obj] = coplanar_resonator(total_l, varargin)
            
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
            addParameter(p, 'trace_w', trace_w_def);
            addParameter(p, 'gap_w', gap_w_def);
            addParameter(p, 'boundaries', boundaries_def);
            addParameter(p, 'segment_l', segment_l_def);
            addParameter(p, 'distance', distance_def);
            parse(p, total_l, varargin{:});
            
            % read arguments
            total_l = p.Results.total_l;
            params.trace_w = p.Results.trace_w;
            params.gap_w = p.Results.gap_w;
            params.segment_l = p.Results.segment_l;
            params.distance = p.Results.distance;
            params.boundaries = p.Results.boundaries;
        % construct object: 
          % find optimal N
          for n= 1:100
            mea  = coplanar_meander( n, params);
            
            if mea.get_length() > total_l
                break
            end
            
            if n==100
                error("didn't reach with N = 100. try different parameters (segment_l etc..)")
            end
                
          end
            
        
          
          
          N = n-1;
          
          % defining meander
          obj.elements.meander = coplanar_meander( N, params);
          
          % calculation extra length needed:
          add_l = total_l - obj.elements.meander.length;
          
          % adding lines
          obj.elements.line_in = coplanar_line(add_l/2, params.trace_w, params.gap_w, [params.boundaries(1),0]).place('output',obj.elements.meander.ports.input);
          obj.elements.line_out = coplanar_line(add_l/2, params.trace_w, params.gap_w, [0,params.boundaries(2)]).place('input',obj.elements.meander.ports.output);
          
          % defining ports
          obj.ports.input = obj.elements.line_in.ports.input;
          obj.ports.output = obj.elements.line_out.ports.output;
          obj.ports.center = obj.elements.meander.ports.center;
          
          obj.trace_w = params.trace_w;
          obj.gap_w = params.gap_w;
          obj.length = obj.elements.meander.get_length() + add_l;
          obj.boundaries = params.boundaries;
         end
          
       end
       
end
    
