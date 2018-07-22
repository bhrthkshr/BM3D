 
filename=load ('imagename.mat');
or_img=filename.imagename;
patch_dim = 64;
num_patches = 150;
listing = dir('F:/ydit/YDIT/images/*.jpg');
%%
load size1.mat
num_file = size1;
for m = 1 : num_file
    fprintf('Extracting patch batch: %d / %d\n', m, num_file);
    % extract random patches
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

        samples(:,:,:,i) = imnoise(input_patch, 'gaussian', 0, 0.01); % add noise 
         

%         figure,imshow(samp)
        labels(:,:,:,i) = input_patch;
    end
    test_samples = single(samples);
    test_labels = single(labels);
    % save it
    filename = strcat('F:\ydit\YDIT\val\val_', num2str(m));
    save(filename, '-v7.3', 'test_samples', 'test_labels');
end
%% 
 
  