function [ legend ] = ExtractLegend( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% figure,imshow(I),title("Input Image");

bw=im2bw(I,0.1);
%   figure,imshow(bw),title("BW Image");

neg=~bw;
%  figure,imshow(neg),title("Negative Image");

fill=imfill(neg,'hole');
%  figure,imshow(fill),title("Hole filling");

SE= strel('rectangle',[10 10]);
eroded=imerode(fill,SE);
% figure,imshow(eroded),title("Eroded");

% dilated=imdilate(eroded,SE);
% figure,imshow(dilated),title("Dilated");

largest = bwareafilt(eroded,1);
[L,num]=bwlabel(largest);
props = regionprops(L,'BoundingBox');
boundingBox=vertcat(props.BoundingBox);

sz=size(boundingBox);
if sz==0
    bw=im2bw(I,0.5);
    figure,imshow(bw),title("BW Image");
    neg=~bw;
    fill=imfill(neg,'hole');
    SE= strel('rectangle',[10 10]);
    eroded=imerode(fill,SE);
    largest = bwareafilt(eroded,1);
    [L,num]=bwlabel(largest);
    props = regionprops(L,'BoundingBox');
    boundingBox=vertcat(props.BoundingBox);
end

minX=ceil(boundingBox(1));
minY=ceil(boundingBox(2));
maxX=minX+ceil(boundingBox(3)) - 1;
maxY=minY+ceil(boundingBox(4)) - 1;

h=maxY-minY;
w=maxX-minX;
legend=uint8(zeros(h,w,3));

y=1;
for i=minY:maxY
        x=1;
   for j=minX:maxX
        legend(y,x,:)=I(i,j,:);
        x=x+1;
   end
      y=y+1;
end
%  figure,imshow(legend),title("Extracted Legend");


 

end

