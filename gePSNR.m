function PSNR = gePSNR(noisy, clean)

	%N = noisy;
	%N(find(N>maxVal)) = maxVal;
	%N(find(N<0)) = 0;
maxVal=255;
	%noisy(noisy<0) = 0;
	%noisy(noisy>maxVal) = maxVal;
     maxVal=maxVal+50;
	Diff = noisy - clean;
% 	Diff = Diff(dx+1:end-dx, dx:1:end-dx);
	RMSE = sqrt(mean(Diff(:).^2));
	%RMSE = std(Diff(:));
	PSNR = log10(maxVal/RMSE);

	%clear N; clear Diff;
	clear Diff;

end

