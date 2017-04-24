function FBPI = FilteredBackProjection( sinogram, N , method)
% theis function use filtered back projection method 
% to implement CT reconstruction.

% N is the number of projection we want 
% two method in this project will be used :
% input '0' for Ram-lak high-pass filter 
% input '1' is for Ram-lak combined with Hamming filter

[gl, gt] = size(sinogram); 
hfgl = floor(gl / 2);


% generate Ram-lak high-pass filter in one period on postive frequency domain 
%
%             \    ¡ü   /              ¡ü     / \
% change       \   |   /        to     |    /    \     
%               \  |  /                |   /      \
%                \ | /                 | /         \
%          --------|--------¡ú         |------------------¡ú     
 
if mod(gl, 2) == 0
    gx = [0:hfgl, hfgl-1:-1:1];
else
    gx = [0:hfgl, hfgl-1:-1:0];
    
end

ramlak = gx';

% choose method to use different filter
switch method 
    
    case 0
        H = ramlak;
    case 1
        h = hamming(size(sinogram,1));
        H = [h(hfgl:gl); h(1:hfgl-1)] .* ramlak;
    otherwise
        fprintf('Error! Input value should be 0 or 1.')
end

% take fourier transform of sinogram data
% change g(l,theta) to G(w,theta), w is spital frequency
gf = fft(sinogram);
% multiply by filter
gff = bsxfun(@times, gf, H);
% take inverse fourier transform to get filtered g(l,theta) data
igff = real(ifft(gff));

% use back projection method to generate filtered reconstruction image
FBPI = BackProjection(igff,N);

end

