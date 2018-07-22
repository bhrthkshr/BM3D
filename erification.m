 %% 
addpath layers/
addpath layers_adapters/
 addpath mem/
addpath optimization/
 addpath pipeline/
addpath utils/
 filename=load ('imagename.mat');
or_img=filename.imagename;
%%
clearvars -global config;
clearvars -global mem;
%%
global config;
denoise_configure();
init(0);
% view(init)
% for gradient checking
img = im2double(imread(or_img));
startpt = 1 ;
 image = config.NEW_MEM((img(startpt:startpt+config.input_size(1)-1, startpt:startpt+config.input_size(2)-1, :)));
 label = config.NEW_MEM((image(1:config.output_size(1), 1:config.output_size(2), :)));

image = repmat(image, 1,1,1,config.batch_size);
 label = repmat(label, 1,1,1,config.batch_size);

% gradient checking
 op_train_pipe(image, label);
 computeNumericalGradient(image, label, 1); % modify here to validate whole image 
load size1
% speed test
loop = size1 ;
tic
for m = 1:loop
     op_train_pipe(image, label);
end
elapse = toc/loop/config.batch_size;
num = 1 / elapse;
fprintf('Process %f samples per second.\n', num);


