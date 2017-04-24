function CBPI = ConvolutionBackProjection( sinogram, N , method)
% this function use Convolution Back Projection method 
% to implement CT reconstruction.

% N is the number of projection we want
% two method in this project will be used :
% input '0' for Ram-lak high-pass filter 
% input '1' is for Ram-lak combined with Hamming filter

[gl, gt] = size(sinogram);
hfgl = floor(gl / 2);

if mod(gl, 2) == 0
    gx = [0:hfgl, hfgl-1:-1:1];
else
    gx = [0:hfgl, hfgl-1:-1:0];
    
end

ramlak = gx';

switch method 

    case 0
        H = ramlak;
    case 1
        ham = hamming(size(sinogram,1));
        H = [ham(hfgl:gl); ham(1:hfgl-1)] .* ramlak;
    otherwise
        fprintf('Error! Input value should be 0 or 1.')
end

% almost procedures are same as FilteredBackProjection funtion except here
% take inverse fourier transform of filter firstly to get h
h = real(ifftshift(ifft(H)));
% convolute sinogram with h to get new sinogram data.
gh = zeros(gl,gt);
for i = 1:gt
    gh(:,i) = conv(sinogram(:,i),h,'same');
end

% use back projection method to generate filtered reconstruction image
CBPI = BackProjection(gh,N);

end



