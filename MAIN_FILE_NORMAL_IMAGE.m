%% THIS PROGRAMM PREPARES PATCHES OF IMAGES AND GIVES A NORMALISED PATCH 
%% Prepare training data into blocks  and  training  
%% THIS PROGRAM IS TO EXTRACT FEATURE FOR GOOD QUALITY IMAGE 
%%
% clc;
% clear all;
% close all;
% warning off all;
 %%
% Image will be divided into patchSize x patchSize patches
patchSize = 32;
% window size used in local contrast normalization
% A window of windowSize x windowSize will be used
windowSize = 3;

% Prompt user for the directory holding input images
% inputDir = uigetdir('.', 'Select input images'' directory');
% inputDir = strcat(inputDir, '\');
%%
% Get all image files in the directory
imageFiles = dir(strcat(inputDir, '*.jpg'));
% Output images' path
outputDir = strcat(inputDir, 'prepared_data_normal/');
% if output directory does not exist then create it
if(exist(outputDir, 'dir') == 0)
    mkdir(outputDir);
end
display('Begin preparing training data...');
tic;
%%
% Run through all images
nImages = length(imageFiles);
for i = 1 : nImages
    % Read image and convert to a grayscale and double matrix
    imageName = imageFiles(i).name;
    image = imread(strcat(inputDir, imageName));
    image = rgb2gray(image);
    image = im2double(image);    
    % Divide the image into patchSize x patchSize size patches
    imagePatches = getImagePatches(image, patchSize);
    % Uncomment to visualize the image patches
    visImagePatches(imagePatches);    
    % Apply local contrast normalization to image patches
    normalizedPatches = normalizeLocalContrast(imagePatches, windowSize, patchSize);
    % Uncomment to visualize the normalized image patches
%     visImagePatches(imagePatches);
    % Save normalized image patches to disk
    saveImagePatches(imagePatches, outputDir, imageName);
end
toc;
display('Finished preparing training data.')
%% EXTRACTING FEATURES OF IMAGE PATCHES 
delete('Total  features list.xlsx')
 %
Files1=dir('F:\ydit\YDIT\images\prepared_data_normal\fish-bike'); % change the directory 
num_files=size(Files1,1); % initialising number of images
% x1(num_files,7)=0; % creating a matrix of zero for number of images vs Gabor features
%
count=1; % initialising count
for j=3:num_files  %Change loop, according to number of images in the folder% start dfrom 3 as 1 to 3 it takes junk value 
     str = strcat('F:\ydit\YDIT\images\prepared_data_normal\fish-bike\',Files1(j).name); % extracting files from folder
      disp(str)      %For displaying the path of image in command window%
     %% Load Image
 I= imread(str);
   % pause(0.001)
    [~, ~, mp]=size(I);
    if mp==3
    grayI=rgb2gray(I);
    else 
         grayI=I;
    end 
   
        
     
 glcm = graycomatrix(grayI,'Offset',[0 1;-1 1;-1 0;-1 -1]); % Creating gray-level co-occurrence matrix from image
      stats=feature_pro(glcm); % calling glcm function
      %disp(stats);
      j=struct2cell(stats); % converting cell structure to array
      %xlswrite('testdata.xls', 'glcm')
      x=cell2mat(j); % converting cell array into matrix
      x=[(x(:,1)+x(:,2))/2]'; % extracting one value from the matrix of 1,2
       x1(count,1)=x(1,2);% saving the 14 features in different variables CONTRAST
      x1(count,2)=x(1,3); %CORRELATION
      x1(count,3)=x(1,14); % IVERSE DIFFERENCE MOMENT
      x1(count,4)=x(1,1); %AUTOCORRELATION
       x1(count,5)=x(1,8); % SUM ENTROPY
      x1(count,6)=x(1,6); % VARIANCE
      x1(count,7)=x(1,12); % INFORMATION MEASURE OF CORRELATION 
      %x1(count,8)=x(1,8);
            
      
      count=count+1;
 
end
 features_u=x1;
 xlswrite('F:\ydit\YDIT\Total  features list.xlsx',features_u,'A1') % writing feature values to xls sheet 
%  mydialog()
  
