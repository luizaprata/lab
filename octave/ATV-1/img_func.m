
function ret = img_func(img)
	i = imread("circuit.jpg");
	i = flipud(i);
	i = minus(255,i);
	w = size(i, 2);
	h = size(i, 1);
	x=[1:w];
	y=[1:h];
	z=double(i);

	clf;
	surf(x,y,z,'EdgeColor','none');
	%mesh(x,y,z);
	view(20,50);
	xlabel("width");
	ylabel("height");
	zlabel("intensity");
	axis([ 0 w 0 h 0 1000 ]);
endfunction