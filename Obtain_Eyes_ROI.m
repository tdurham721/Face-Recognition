function [ROI] = Obtain_Eyes_ROI(normalizedFaceImage)
%**********************************************************
%This function extracts the eyes from a face image after it
%has been geometrically normalized.
%**********************************************************
ROI = normalizedFaceImage(12:61,:);
end