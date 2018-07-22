%% Divide image into patches
function patches = getImagePatches(image, patchSize)
[rows, cols] = size(image);
% scale the number of rows and columns of the image such that a whole
% number of patches can be made out of it
nRowPatches = double(int32(rows / patchSize));
nColPatches = double(int32(cols / patchSize));
nScaledRows = nRowPatches * patchSize;
nScaledCols = nColPatches * patchSize;
% resize the image according to the new rows and columns
resizedImage = imresize(image, [nScaledRows nScaledCols]);
% now divide into patches
rowPatchSizeVector = patchSize * ones(1, nRowPatches);
colPatchSizeVector = patchSize * ones(1, nColPatches);
patches = mat2cell(resizedImage, rowPatchSizeVector, colPatchSizeVector);

end