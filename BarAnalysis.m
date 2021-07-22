function [ colors,values ] = BarAnalysis(I,maxVal,maxY)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%0.8
bw = im2bw(I,0.99);
% figure ,imshow(bw);
se=strel('rectangle' , [30 30]);
neg=~bw;
% figure ,imshow(neg);
eroded = imerode(neg, se);
eroded = imdilate(eroded,se);
% figure ,imshow(eroded);

[L,num]=bwlabel(eroded);
if num<4
    bw = im2bw(I,0.8);
    neg=~bw;
    eroded = imerode(neg, se);
    eroded = imdilate(eroded,se);
    [L,num]=bwlabel(eroded);
end



props = regionprops(L,'BoundingBox','Centroid');

boundingBox=vertcat(props(:).BoundingBox);
centers=vertcat(props(:).Centroid);

minY = ceil(boundingBox(1,2)+boundingBox(1,4));
yHeight = minY - maxY;
pxHeight = yHeight / maxVal;
barHeights = zeros(num);
for i = 1:num
    barHeights(i) = boundingBox(i,4);
end
values = barHeights/pxHeight;
% values
colors=uint8(zeros(num,3));
for i=1:num
     y=ceil(centers(i,2));
     x=ceil(centers(i,1));
     colors(i,:)=I(y,x,:);
end
% colors
end

