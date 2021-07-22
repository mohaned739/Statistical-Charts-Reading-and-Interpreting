function [ shape,centers,radii,metric] = DetectChart( I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


[centers,radii,metric] = imfindcircles(I,[90,200],'ObjectPolarity','dark','Sensitivity',0.96);
sz=size(radii);
if sz~=0
    shape="Pie Chart";
elseif sz==0
    shape="Bar Chart";
end

end

