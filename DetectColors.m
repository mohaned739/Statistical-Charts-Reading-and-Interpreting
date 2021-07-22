function [ colors,areas ] = DetectColors( I,center,radius )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

minX=floor(center(1)-radius);
minY=floor(center(2)-radius);
maxX=ceil(center(1)+radius);
maxY=ceil(center(2)+radius);


bw=im2bw(I,0.9);
gray=rgb2gray(I);

edges = edge(gray, 'canny');

SE = strel('rectangle',[6 6]);
closed=imclose(edges,SE);

% figure,imshow(closed);

filtered=bwareaopen(closed,1000);

% figure,imshow(filtered);

neg=~filtered;

% figure,imshow(neg);

h=maxY-minY;
w=maxX-minX;
pie=zeros(h,w);

y=1;
for i=minY:maxY
        x=1;
   for j=minX:maxX
        pie(y,x)=abs(bw(i,j)-neg(i,j));
        x=x+1;
   end
      y=y+1;
end

SE= strel('rectangle',[3 3]);
pie=imerode(pie,SE);
pie=bwareaopen(pie,1000);

%  figure,imshow(pie);

[L,num]=bwlabel(pie);
props = regionprops(L,'Centroid','Area');

% figure,imshow(I);   

coloredPie=uint8(zeros(h,w,3));
y=1;
for i=minY:maxY
        x=1;
   for j=minX:maxX
        coloredPie(y,x,1)=I(i,j,1);
        coloredPie(y,x,2)=I(i,j,2);
        coloredPie(y,x,3)=I(i,j,3);
        x=x+1;
   end
      y=y+1;
end


% figure,imshow(coloredPie);

centers=vertcat(props.Centroid);
colors=uint8(zeros(num,3));
areas=vertcat(props.Area);
total=sum(areas);

for i=1:num
    x=ceil(centers(i,1));
    y=ceil(centers(i,2));
    colors(i,:)=coloredPie(y,x,:);
    areas(i)=(areas(i)/total)*100;
end
end

