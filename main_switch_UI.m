%%
% change path in the code line number 10 
%%
delete('size1.mat')
delete ('imagename.mat')
delete ('inputDir.mat')
delete('outputDir.mat')
%%  Remove the directory every time 
rmSubDir( 'F:\bm3d\BM3D\images\prepared_data_normal')
%%  create patches 
 inputDir = uigetdir('.', 'Select input images'' directory');
 inputDir = strcat(inputDir, '\');
 imageFiles = dir(strcat(inputDir, '*.png'));
 [size1 ,size2]=size(imageFiles);
 save size1.mat size1
imagename=strcat(inputDir,imageFiles(1).name);
save inputDir.mat inputDir
save imagename.mat imagename
 %% Extract patch
 outputDir = strcat(inputDir, 'prepared_data_normal\');
% if output directory does not exist then create it
save  outputDir.mat  outputDir
if(exist(outputDir, 'dir') == 0)
    mkdir(outputDir);
end
display('Begin preparing training data...');
tic;
%%
patchSize = 64;
% window size used in local contrast normalization
% A window of windowSize x windowSize will be used
windowSize = 8;

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
%     normalizedPatches = normalizeLocalContrast(imagePatches, windowSize, patchSize);
    
    saveImagePatches(imagePatches, outputDir, imageName);
end
toc;
display('Finished preparing training data.')
