function [] = LinkLegend( legend,colors,areas )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    

  bw=im2bw(legend,0.935);
%   figure,imshow(bw),title("BW Legend");
  
  neg=~bw;
  SE=strel('rectangle',[6 6]);
  colorBox=imerode(neg,SE);
%   figure,imshow(colorBox),title("Eroded colored Boxes");
  
  colorBox=imdilate(colorBox,SE);
%   figure,imshow(colorBox),title("Dilated colored Boxes");
   
  text=bw + colorBox;
%   figure,imshow(text),title("Text");
   
  neg=~text;
  neg=bwareaopen(neg,3);
%   figure,imshow(neg),title("Negative Text");
    
  SE=strel('rectangle',[5 15]);
  dilated=imdilate(neg,SE);
%   figure,imshow(dilated),title("dilated Text");
  
  [L,num]=bwlabel(colorBox);
  props = regionprops(L,'Centroid');
  centroids=ceil(vertcat(props.Centroid));
  boxesRGB=uint8(zeros(num,3));
  
  for i=1:num
     x=centroids(i,1);
     y=centroids(i,2);
     boxesRGB(i,:)= legend(y,x,:);
  end
  
  [L,num]=bwlabel(dilated);
  props = regionprops(L,'BoundingBox');
  boundingBox=ceil(vertcat(props.BoundingBox));
  
  %arrange them box with label
  for i=1:num
      min=100000000000;
      min2=100000000000;
      index=i;
      index2=i;
      x1=centroids(i,1);
      y1=centroids(i,2);
      r1=double(boxesRGB(i,1));
      g1=double(boxesRGB(i,2));
      b1=double(boxesRGB(i,3));
     for j=1:num
         x2=boundingBox(j,1);
         y2=boundingBox(j,2);
         distance = sqrt( (x1-x2)^2 + (y1-y2)^2 );
         
         r2=double(colors(j,1));
         g2=double(colors(j,2));
         b2=double(colors(j,3));
         distance2 = sqrt((r1-r2)^2 + (g1-g2)^2 + (b1-b2)^2);
         if distance<min
            min=distance;
            index=j;
         end
         if distance2<min2
            min2=distance2;
            index2=j;
         end
     end
     temp=boundingBox(index,:);
     boundingBox(index,:)=boundingBox(i,:);
     boundingBox(i,:)=temp;
     
     rgbTemp=colors(index2,:);
     colors(index2,:)=colors(i,:);
     colors(i,:)=rgbTemp;
     
     areaTemp=areas(index2);
     areas(index2)=areas(i);
     areas(i)=areaTemp;
  end
  
  %find each word
%   figure,imshow(legend),title("Extracted Legend");
  for i=1:num
     y=1;
     minX=ceil(boundingBox(i,1));
     minY=ceil(boundingBox(i,2));
     maxX=minX+boundingBox(i,3) - 1;
     maxY=minY+boundingBox(i,4) - 1;
      word=uint8(zeros(boundingBox(i,4)-1,boundingBox(i,3)-1,3));
     for j=minY:maxY
         x=1;
         for m=minX:maxX
            word(y,x,:)=legend(j,m,:); 
            x=x+1;
         end
         y=y+1;
     end
      figure(i),imshow(word),title('word');
      fprintf('The value of figure ( %d ) is : %.2f\n',i,areas(i));
  end
 

end

