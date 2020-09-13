function [elem] = pol2elem(pol)
%UNTITLED4 retuens an elemet_array or a polygon array
%   Detailed explanation goes here
mat =  pol.Vertices;

% getting rid of nan rows and seperating into cells:
idx = all(isnan(mat),2);

idr = diff(find([1;diff(idx);1]));
 D = mat2cell(mat,idr(:),size(mat,2));
nodesArr = D(1:2:end);





for i=1:length(nodesArr)
   nodesArr{i} =  [ nodesArr{i};nodesArr{i}(1,:)];
end

nodesArr{end} = [nodesArr{end} ;nodesArr{1}(1,:)] ;

nodes = cell(ceil(length(nodesArr)/2),1);
 for i = length(nodes)
    nodes{i} = (cell2mat(nodesArr(2*i-1:min(2*i, length(nodesArr))))); 
 end

 
if length(nodes)>1
    for i = 1:length(nodes)
        elements{i} = polygon_element(nodes{i});
    end
    elem = element_array(elements);
    
else
    elem = polygon_element(nodes{1});

end

