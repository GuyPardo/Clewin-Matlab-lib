function [elem] = pol2elem(pol)
% written by Guy 2020_08_29 returns an elemet_array or a polygon_element

%pol = simplify(pol, 'keepcollinearpoints', false);
rgns = regions(pol); % regions of pol
elems = cell(length(rgns),1); % pre allocating cell array
for i = 1:length(rgns)
    outer_nodes = seperate_nan(rgns(i).Vertices); 
    outer_nodes = outer_nodes{1}; % the first (outer) region
    
    elems{i} = polygon_element(outer_nodes);
    hols = holes(rgns(i)); % holes of region
   
   for j = 1:length(hols)
       elems{i} = pol_sub(elems{i},polygon_element(hols(j).Vertices) ); % subtract holes from region
       
   end
    
end

if length(elems)==1
    elem = elems{1};
else
    elem = element_array(elems);
end
    
end
