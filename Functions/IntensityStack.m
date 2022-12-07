function [IntMat tilts]=IntensityStack(filename)









holoinfo=h5info(filename,'/Epi/Hologram');
count=holoinfo.ChunkSize;
Epiinfo=h5info(filename,'/Epi');
datainfo=Epiinfo.Datasets.Dataspace;
datasize=datainfo.Size;
rootinfo=h5info(filename);
disp(rootinfo.Attributes.Value)   % display data comments


NA=.16;
lambda=1.030/2;
% ps=(1/40)/83.5; %mm
% ps=ps*1000; %um             % pixel size from callibration image
ps=0.5576;
Fs=1/ps;

Nx=datasize(2);
Ny=datasize(1);  
x=ps*[-Nx/2:Nx/2-1];
y=ps*[-Ny/2:Ny/2-1];
dFx=Fs/Nx;
dfxs         = dFx;%1/(N*ps);             % Fourier spacing 
fxs          = dfxs*[-Nx/2:Nx/2-1];         % 1D axis in fx
dFy=Fs/Ny;
dfys         = dFy;%1/(N*ps);             % Fourier spacing 
fys          = dfys*[-Ny/2:Ny/2-1];         % 1D axis in fy
[Xs Ys]=meshgrid(x,y);
[fxxs fyys]=meshgrid(fxs,fys);


SPX=h5readatt(filename,'/Epi','scanPathX');
SPY=h5readatt(filename,'/Epi','scanPathY');
scanAmplitudeX = 0.22;          % peak-to-peak voltage, in Volts
scanAmplitudeY = scanAmplitudeX / 1.333;    % scaled by magnification  

% NA=.16;
% lambda=1.030; %um


% Find voltage to frequency conversion
Fpupx=linspace(-NA/lambda,NA/lambda,length(SPX))*((SPX(end)-SPX(1))/2)/scanAmplitudeX;
Fpupy=linspace(-NA/lambda,NA/lambda,length(SPY))*((SPY(end)-SPY(1))/2)/scanAmplitudeY;

IntMat=zeros(datasize(1),datasize(2),datasize(3));

for ii=1:datasize(3)
    start=[1 1 ii];
    IntMat(:,:,ii)=h5read(filename,'/Epi/Signal',start,count);
    [row,col] = ind2sub([size(SPX) size(SPY)],ii);
    tilts{ii}=[Fpupx(col) Fpupy(row)];
    %phsrmp=exp(1i*2*pi*(Fpupx(col).*Xs-Fpupy(row).*Ys));
    
end

