function rmSubDir( pathDir )
    d = dir(pathDir);
    isub = [d(:).isdir];
    nameFolds = {d(isub).name}';
    nameFolds(ismember(nameFolds,{'.','..'})) = [];

     for i=1:size(nameFolds,1)
        dir2rm = fullfile(pathDir,nameFolds{i});
        rmdir(dir2rm, 's');
     end

end
