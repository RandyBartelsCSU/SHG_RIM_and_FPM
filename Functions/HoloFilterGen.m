function [FilterHolo]=HoloFilterGen(filename)


% This function generates a filter for the hologram in R-space. The filter in R-space is designed
% to mitigate ringing artifacts when taking fourier transforms of the
% hologram due to non-zero values near the edge of the field of view. 

% Inputs:

% ps:       Calibrated pixel size corresponding to a camera image in
%           R-space. Units: microns

% NA:       Numerical aperture of collection objective

% Lambda:   Wavelength of collected light





holoinfo=h5info(filename,'/Epi/Hologram');
count=holoinfo.ChunkSize;
Epiinfo=h5info(filename,'/Epi');
datainfo=Epiinfo.Datasets.Dataspace;
datasize=datainfo.Size;

Nx=datasize(2);
Ny=datasize(1);


x=linspace(-1,1,Nx);
y=linspace(-1,1,Ny);

[X Y]=meshgrid(x,y);

sig2=.7;
FilterHolo=exp(-((X).^2/sig2).^4).*exp(-((Y).^2/sig2).^4);
figure; 


imagesc(FilterHolo)
daspect([1 1 1])
axis off
title('Filter for R-space Hologram')
figure;
tiledlayout(1,2)
nexttile
plot(FilterHolo(round(end/2),:))
title('y-dir lineout')
nexttile
plot(FilterHolo(:,round(end/2)))
title('x-dir lineout')







end

