%%  
 
clc;
clear all;
close all;
warning off all
%% ----------------------------------------------------------------------------------------------------
 addpath BM3D_images/
 addpath images/
 addpath output/
 addpath results/
 addpath train/
 addpath utility/
 addpath val/
addpath layers/
addpath layers_adapters/
 addpath mem/
addpath optimization/
 addpath pipeline/
addpath utils/
 %% -------------
repeat=1;
 while (repeat==1) % to keep the application running until you do not press exit as until value of repeat is 1
    % in the exit case value is reset to 0 when the program takes an exit
choice=menu('Denoising project ',...
'LOAD IMAGE DIRECTORY AND CREATE PATCH  ','Generate training data and validate  ',...
'TRAIN INTO MODEL  ','DENOISE','Exit');

% creatiing menu bar 
switch choice % depending on choice each program executes the files related to the work are 
    % present in all the case which will be the main files 
    
          
    case 1
        
     main_switch_UI % double click on train databse file in current folder inside which change the path 
        
    case 2
       
     
    training_d;
       pause(0.0001)
       gen_val_data;
    
    
       
       % similar as above
        disp('done')
    case 3
        
      %display_global.m
   train_d
   disp('Done training')
   pause(0.001)
   erification
   disp('Verifiaction done')
        %disp('done')
    case 4
      test_dem
    case 5
         clc
        clear all
        close all
        repeat=0;
end
fprintf('\n')
%display('THIS IS THE PROCESS TIME FOR CODE')
% toc;
fprintf('\n')
 end
 