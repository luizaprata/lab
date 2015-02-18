function ret = transf2d(img)
	% <var>0: Source
	% <var>1: Destination

	img0     = imread("image.jpg");
	rows     = size(img0,1);
	cols     = size(img0,2);
	channels = size(img0,3);
	img1     = uint8(zeros(rows, cols, channels));

  theta = 30 * pi/180;
  rot = double([cos(theta) -sin(theta); sin(theta) cos(theta)]);
  flip = [-1,1]
  
	for i1 = 1:rows;
		for j1 = 1:cols;
    
      scaleCenterCol = cols*0.5;
      scaleCenterRow = ((rows*1.2)-rows)*0.5;
      
      centerCol = cols*0.5;
      centerRow = rows*0.5;
    
      col = cols-j1;
      row = i1;
      
      coord = double([row; col]);
      traslate = double([-scaleCenterRow;scaleCenterCol]);
      coordRotation = (rot*coord)*1.2;
      coordRotation -= traslate;
      
      
      
      i0 = uint8(coordRotation(1));
      j0 = uint8(coordRotation(2));
      

			if (i0 > 0 && i0 <= rows && j0 > 0 && j0 <= cols)
				img1(i1, j1, :) = img0(i0, j0, :);
			else
				img1(i1, j1, :) = ones(1, channels) * 128;
			endif
		endfor
	endfor
	imshow(img1);	 
endfunction
