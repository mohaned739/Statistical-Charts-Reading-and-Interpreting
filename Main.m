clc;
close all  ;
% I=imread('1.1.png');
% I=imread('1.2.jpg');
% I=imread('2.1.png');
% I=imread('2.2.jpg');
% I=imread('3.1.png');
% I=imread('3.2.jpg');
% I=imread('4.1.jpg');
% I=imread('4.2.png');
I=imread('1B.jpg');

[ shape,centers,radii,metric]=DetectChart(I);
%  figure,imshow(I);
 disp(shape);
if shape=="Pie Chart"
    %viscircles(centers(1,:), radii(1,:),'EdgeColor','b');
    center=centers(1,:);
    radius=radii(1,:);
    [colors,areas]=DetectColors( I,center,radius );
    legend=ExtractLegend(I);
%     figure,imshow(legend);
    LinkLegend(legend,colors,areas);
 %   figure,imshow(I);
elseif shape=="Bar Chart"
    [maxVal,maxY]=GetScale(I);
    [ colors,values ] = BarAnalysis(I,maxVal,maxY);
    legend=ExtractLegend(I);
%     figure,imshow(legend);
    LinkLegend(legend,colors,values);
end


