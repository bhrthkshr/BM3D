 function denoisedIm = fNeural(noisyIm, sigma, model)

  % load the weights
  load(sprintf('neuralweights_sig%d.mat',sigma));
  w = {};
  w{1} = single(w_1);
  w{2} = single(w_2);
  w{3} = single(w_3);
  w{4} = single(w_4);
  w{5} = single(w_5);
  clear w_1; clear w_2; clear w_3; clear w_4; clear w_5;

  patchSz = sqrt(size(w{1}, 2)-1);
  patchSzOut = sqrt(size(w{5},1));

  p_diff = (patchSz - patchSzOut)/2;
  % check if input is larger than output. In that case, extend the image
  sz = size(noisyIm);
  if (p_diff>0)
    noisyIm = [fliplr(noisyIm(:,(1:p_diff)+1)) noisyIm fliplr(noisyIm(:, sz(2)-p_diff:sz(2)-1))];  
    noisyIm = [flipud(noisyIm((1:p_diff)+1,:)); noisyIm; flipud(noisyIm((sz(1)-p_diff:sz(1)-1), :))];  
  end

  pixel_weights = zeros(patchSzOut);
  mid = ceil(patchSzOut/2);
  sig = floor(patchSzOut/2)/model.weightsSig;
  for i=1:patchSzOut
    for j=1:patchSzOut
      d = sqrt((i-mid)^2 + (j-mid)^2);    
      pixel_weights(i,j) = exp((-d^2)/(2*(sig^2))) / (sig*sqrt(2*pi));
    end
  end
  pixel_weights = pixel_weights/max(pixel_weights(:));


  noisyIm = single(((noisyIm/255)-0.5)/0.2);


  chunkSize = 1000;


  range_y = 1:model.step:(size(noisyIm,1)-patchSz+1);
  range_x = 1:model.step:(size(noisyIm,2)-patchSz+1);
  if (range_y(end)~=(size(noisyIm,1)-patchSz+1))
    range_y = [range_y (size(noisyIm,1)-patchSz+1)];
  end
  if (range_x(end)~=(size(noisyIm,2)-patchSz+1))
    range_x = [range_x (size(noisyIm,2)-patchSz+1)];
  end

  res = zeros(patchSz^2, chunkSize, 'single');
  positions_out = zeros(2, chunkSize);

  denoisedIm = zeros(sz);
  wIm = zeros(sz);

  idx = 0;
  for y=range_y
    for x=range_x
      p = noisyIm(y:y+patchSz-1,x:x+patchSz-1)';
      idx = idx + 1;
      res(:,idx) = p(:);
      positions_out(:,idx) = [y; x];
      if (idx>=chunkSize)
        % predict
        part = res;
        for i=1:5
          part = [part; ones(1, size(part,2))];
          if (i<5)
            part = tanh(single(w{i})*single(part));
          else
            p_final = single(w{i})*single(part);

            patches_w = repmat(pixel_weights(:), [1 size(p_final, 2)]);
            p_final = p_final.*patches_w;

            % place in output noisyImage            
            for j=1:chunkSize
              tmp_p_y = positions_out(1,j):positions_out(1,j)+patchSzOut-1;
              tmp_p_x = positions_out(2,j):positions_out(2,j)+patchSzOut-1;
              denoisedIm(tmp_p_y,tmp_p_x) = denoisedIm(tmp_p_y,tmp_p_x) + reshape(p_final(:,j),[patchSzOut patchSzOut])';
              wIm(tmp_p_y,tmp_p_x) = wIm(tmp_p_y,tmp_p_x) + reshape(patches_w(:,j),[patchSzOut patchSzOut])';

            end
          end
        end

        idx = 0;
      end
    end
  end
  % predict
  part = res(:,1:idx);
  for i=1:5
    part = [part; ones(1, size(part,2))];
    if (i<5)
      part = tanh(single(w{i})*single(part));
    else
      p_final = single(w{i})*single(part);

      patches_w = repmat(pixel_weights(:), [1 size(p_final, 2)]);
      p_final = p_final.*patches_w;

      % place in output noisyImage            
      for j=1:size(part,2)
        tmp_p_y = positions_out(1,j):positions_out(1,j)+patchSzOut-1;
        tmp_p_x = positions_out(2,j):positions_out(2,j)+patchSzOut-1;
        denoisedIm(tmp_p_y,tmp_p_x) = denoisedIm(tmp_p_y,tmp_p_x) + reshape(p_final(:,j),[patchSzOut patchSzOut])';
        wIm(tmp_p_y,tmp_p_x) = wIm(tmp_p_y,tmp_p_x) + reshape(patches_w(:,j),[patchSzOut patchSzOut])';
      end
    end
  end

  denoisedIm = denoisedIm./wIm;
  denoisedIm = ((denoisedIm*0.2)+0.5)*255;

  clear w; 
  clear patches_w;
  clear wIm;

return



