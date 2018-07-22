 clc
 clear 
 close all
addpath layers/
addpath layers_adapters/

clearvars -global config;
clearvars -global mem;
%%
[path,inputDir ]= uigetfile('*.*', 'Select input images');
 inputDir = strcat(inputDir,path);
%  imageFiles = dir(strcat(inputDir, '*.png'));
% imagename=strcat(inputDir,imageFiles.name);


%%
% filename=load ('imagename.mat');
% or_img=filename.imagename;
%%
im_clean =double (imread(inputDir));
im_clean=im_clean(:,:,1);
model = {};
% width of the Gaussian window for weighting output pixels
model.weightsSig = 2;
% the denoising stride. Smaller is better, but is computationally 
% more expensive.
model.step = 3;

%
% figure,imshow(im_clean,[])
rand('seed', 1);
randn('seed', 1);
im_noisy = im_clean + 50*randn(size(im_clean));
 
tstart = tic;
% im_denoised = fdenoiseNeural(im_noisy, 50, model);
% h = waitbar(0,'TESTING IMAGE..');
% steps = 10;
% for step = 1:steps
% 
% pause(0.1)

 fprintf('Starting to denoise...\n');
tstart = tic;
im_denoised = fNeural(im_noisy, 50, model);
telapsed = toc(tstart);
fprintf('Done! Loading the weights and denoising took %.1f seconds\n',telapsed);
%%
% get PSNR values
[peaksnr, snr] = psnr(im_denoised, im_clean, 255);
fprintf('PSNRs: denoised: %.2fdB\n', peaksnr);
%%
[ssimval, ssimmap] = ssim(im_denoised,im_clean);
figure,imshow(ssimmap)
fprintf('The SSIM value is %0.2f.\n',(ssimval));
%%
figure,
% display the result
subplot(131); imagesc(im_clean); s = gca;           title('clean'); axis image
subplot(132); imagesc(im_noisy, get(s, 'CLim'));    title('noisy'); axis image
subplot(133); imagesc(im_denoised, get(s, 'CLim')); title('denoised'); axis image
colormap(gray);
 repeat=1;