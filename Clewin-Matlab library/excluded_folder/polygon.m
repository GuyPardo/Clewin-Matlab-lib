function [] = polygon(nodes)
% This is an function to replace clewin's polygon(nodes) when you work in matlab %   Detailed explanation goes here
id = 'MATLAB:polyshape:repairedBySimplify';
warning('off',id);

pgon = polyshape(nodes(:,1)',nodes(:,2)' );

figure(gcf)
plot(pgon)
hold on
grid on
axis equal

warning('on',id);
end

