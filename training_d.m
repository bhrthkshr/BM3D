 % change pathname only at xlswrite line and line 76 till concolution line nowhere else   
   h = waitbar(0,'Loading Data..');
steps = 20;
for step = 1:steps
  filename=load ('imagename.mat');
full_filename=load ('inputDir.mat');
outp_dir=load('outputDir.mat');
k=strcat(full_filename.inputDir,'*.png');
or_img=filename.imagename;
       waitbar(step / steps)
end
close(h) 

%%
patch_dim = 64;
num_patches =150;
listing = 1;
num_files=size(1,1); % initialising number of images
% x1(num_files,7)=0; % creating a matrix of zero for number of images vs Gabor features
%
count=1; % initialising count
   %Change loop, according to number of images in the folder% start dfrom 3 as 1 to 3 it takes junk value 
%      str = strcat(or_img,Files1(j).name); % extracting files from folder
%   disp(or_img)      %For displaying the path of image in command window%
     %% Load Image
 I= imread(or_img);
   % pause(0.001)
    [~, ~, mp]=size(I);
    if mp==3
    grayI=rgb2gray(I);
    else 
         grayI=I;
    end 
 h = waitbar(0,'Generate Training Data starts..');
steps = 20;
for step = 1:steps
     
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
 waitbar(step / steps)
end
close(h) 
 features_u=x1;
%  xlswrite('F:\bm3d\BM3D\Total  features list.xlsx',features_u,'A1') % writing feature values to xls sheet 
%  mydialog()
%   h = waitbar(0,'Extracting patches..');
% steps = 10;
% for step = 1:steps


num_file = 20;
for m = 1 
    fprintf('Extracting patch batch: %d / %d\n', m, num_file);
        samples = zeros(patch_dim, patch_dim, 3, num_patches);
    labels = zeros(size(samples));
    for i = 1 : num_patches
        if (mod(i,5) == 0)
            fprintf('Extracting patch: %d / %d\n', i, num_patches);
        end
        
        r_idx = random('unid', size(listing, 1));
        orig_img = imread(or_img);

        orig_img_size = size(orig_img);
        offset = 30;
        r = random('unid', orig_img_size(1) - patch_dim - 2*offset + 1) + offset;
        c = random('unid', orig_img_size(2) - patch_dim - 2*offset + 1) + offset;
        
        input_patch = im2double(orig_img(r:r+patch_dim-1, c:c+patch_dim-1, :));

        samples(:,:,:,i) = imnoise(input_patch, 'gaussian', 0, 0.01);
        labels(:,:,:,i) = input_patch;
    end
    samples = single(samples);
    labels = single(labels);
    % save it
    filename = strcat('F:\bm3d\BM3D\train\patches_', num2str(m),'.mat');
    save(filename, '-v7.3', 'samples', 'labels');
end
%   waitbar(step / steps)
% end
% close(h) 
% 
delete('Total  features list.xlsx')
 %
% Files1=dir(or_img); % change the directory 
