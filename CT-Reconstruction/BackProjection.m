function BPI = BackProjection( sinogram, N)
% this function use back peojection to implement CT reconstruction
% N is the number of projection we want

[gl,gt] = size(sinogram);

hfgl = floor(gl/2); % half size of l in sinogram
iw = 2 * floor(gl / (2 * sqrt(2))); % set image window size
hfiw = iw / 2; % half size of image window

BPI = zeros(iw);

 % reset the coordinates by Cartesian coordinates in image window
 %           
 %                   ● y
 %                   |
 %                   |
 %                   |
 %          ！！！！！！！！！！★ x
 %                   |
 %                   |
 %                   |  (Cartesian coordinates)
 %
[posX, posY] = meshgrid((1:iw) - hfiw);



igt = floor(gt/N); % degrees interval of each projection
for angle = 1:igt:gt % the number of projection
    
    % under each degree, calculate l of each coordinate in the image window  
    pos = posX * cosd(angle) + posY * sind(angle) + hfgl; 
    % interpolate the value in corresponding l into image window
    BPI = BPI + interp1(1:gl, sinogram(:, angle), pos);
    
%     implementing following code will plot each projection on real time

%     imagesc(BPI)
%     colormap gray
%     axis('off')
%     drawnow
end

% multiply a factor
BPI = BPI * pi/( 2 * N);

end

