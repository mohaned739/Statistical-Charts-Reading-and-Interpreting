function [ maxVal,maxY ] = GetScale( I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[~,w,~]=size(I);
croped=I(:,2:floor(w/10),:);
%figure,imshow(croped);

BW = im2bw(croped);

results = ocr(BW,'TextLayout','Block');

maxY = results.CharacterBoundingBoxes(1,2);

maxVal = str2double(results.Words(1,1));
end

