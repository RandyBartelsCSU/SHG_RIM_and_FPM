function GenerateTransmissionSHGMovie(filename)


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
Fpupx=SPX./max(SPX)*(SPX(end)/scanAmplitudeX*NA/lambda);
Fpupy=SPY./max(SPY)*((SPY(end)/scanAmplitudeY*NA/lambda));


f=figure;
f.WindowState='fullscreen';
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
for ii=1:datasize(3)
    start=[1 1 ii];
    [row,col] = ind2sub([length(SPX) length(SPY)],ii);

    Signal=h5read(filename,'/Epi/Signal',start,count);

    




    imagesc(x,y,Signal)
    xlabel('x (\mum)','FontWeight','bold')
    ylabel('y (\mum)','FontWeight','bold')
    title(['SHG Widefield Image' '   ' 'Angle:' '<' num2str(Fpupx(row)) '  ' num2str(Fpupy(col)) '>' '  ' '(\mum^{-1})'],'FontWeight','bold')
    axis square
    colormap Turbo
    %set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    f.WindowState='fullscreen';
    pause(.3)
    
    drawnow;




end

