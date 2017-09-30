% This code is part of:
%
%   CMPSCI 670: Computer Vision
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
% Evaluation code for Part 1: Color image alignment.
%
% Your goal is to implement the alignChannels() function. A correct 
% implementation should have 'gt shift' + 'pred shift' = O, i.e.,
% the all zeros vector.
%
% Credits: The homework is adapted from a similar one developed by Alyosha
% Efors (UC Berkeley, previously at CMU).


% Path to your data directory
dataDir = fullfile('C:','Users','User','Documents','Umass Amherst', 'Semester 1', 'COMPSCI 670 - Computer Vision','Mini Projects','1','p1_data','data','sample-images');

% List of images
imageNames = {'balloon.jpeg','cat.jpg',	'ip.jpg', 'puppy.jpg','squirrel.jpg', 'pencils.jpg','house.png', 'light.png', 'sails.png', 'tree.jpeg'};
numImages = length(imageNames);
          
% Global variables
maxShift = [15 15]; % the shifts are checked within this range
display = true;     % if set to true then aligned images are shown
global imO;
% Loop over methods and print results
fprintf('Evaluating alignment ..\n');
for i = 1:numImages,
    % Read image
    
    thisImage = fullfile(dataDir, imageNames{i});
    im = imread(thisImage);
    imO = im;
    im = im2double(im);
    imO = im2double(imO);
    
    % Randomly shift channels
    [channels, gtShift]  = randomlyShiftChannels(im, maxShift);
    
    
  
    % Compute alignment
    [colorIm, predShift] = alignChannels(channels, maxShift);
    
    
   
    
    % Print results
    %fprintf('%2i %s\n\t   gt shift: (%2i,%2i) (%2i,%2i)\n\t pred shift: (%2i,%2i) (%2i,%2i)\n',...
     %       i, imageNames{i}, gtShift(1,:), gtShift(2,:), predShift(1,:), predShift(2,:));

    % Optionally display the results
    if display
        % We will use subplot which is a way to show multiple plots/images
        % in a single figure.
        figure(1); clf;
        subplot(1,2,1); imagesc(channels); axis image off;
        title('Input image');
        
        subplot(1,2,2); imagesc(colorIm); axis image off;
        title('Aligned image');
        pause(1); %Pause for 1 second after display
    end
end