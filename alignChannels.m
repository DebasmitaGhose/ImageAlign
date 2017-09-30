function [imShift, predShift] = alignChannels(im, maxShift)

% ALIGNCHANNELS align channels in an image.
%   [IMSHIFT, PREDSHIFT] = ALIGNCHANNELS(IM, MAXSHIFT) aligns the channels in an
%   NxMx3 image IM. The first channel is fixed and the remaining channels
%   are aligned to it within the maximum displacement range of MAXSHIFT (in
%   both directions). The code returns the aligned image IMSHIFT after
%   performing this alignment. The optimal shifts are returned as in 
%
%   PREDSHIFT a 2x2 array. PREDSHIFT(1,:) is the shifts  in I (the first) 
%   and J (the second) dimension of the second channel, and PREDSHIFT(2,:)
%   are the same for the third channel.
%
% This code is part of:
%   CMPSCI 670: Computer Vision
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Author: Subhransu Maji
        
disp(size(im))
% Sanity check
%image=im;
   assert(size(im,3) == 3);
   assert(all(maxShift > 0));
   
   Blue = im(:,:,1);
   Green = im(:,:,2);
   Red = im(:,:,3);
   
   min_xyz1=[];
   min_xyz2=[];
   
   ShiftI = [0,0];
   ShiftJ = [0,0];
   
   
   for i=-maxShift(1):1:maxShift(1)
       for j=-maxShift(2):1:maxShift(2)
            ssd1 = sum(sum((circshift(Green,[i,j])-Blue).^2));
            ssd2 = sum(sum((circshift(Red,[i,j])- Blue).^2));
            min_xyz1 = [min_xyz1, ssd1];
            min_xyz2 = [min_xyz2, ssd2];
            [MM1,~]=min(min_xyz1);
            [MM2,~]=min(min_xyz2);
            if ssd1 == MM1
                ShiftI(1) = i;
                ShiftJ(1) = j;
            end
             if ssd2 == MM2
                ShiftI(2) = i;
                ShiftJ(2) = j;
             end
       end
   end
   predShift = [ShiftI' ShiftJ'];
   disp("predshift")
   disp(predShift)
   imShift(:,:,2) = circshift(Green, [ShiftI(1) ShiftJ(1)]);
   imShift(:,:,3) = circshift(Red,[ShiftI(2) ShiftJ(2)]);
  
   
   
 
   
   
         