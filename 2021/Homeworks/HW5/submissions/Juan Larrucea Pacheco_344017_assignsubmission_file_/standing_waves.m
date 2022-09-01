function standing_waves
  out_dir =  "standing_wave_images";
  mkdir(out_dir);
  
  %Initial data
  angular_freq = 1;
  initial_amplitude = 1;
  length = 1;
  
  %Mesh grid for ploting
  tx = ty = linspace(0,1,100);
  [xx,yy] = meshgrid(tx,ty);
  new_t = 0;
  
  
  for i =1:200
    
    subplot(3,1,1);
    
    %First harmonic
    n = 1;
    kx = (n* pi)/length;
    ky = (n* pi)/length;
    
    %Compute the first standing wave
    tz = 2 * initial_amplitude * sin(kx*(xx)) .* sin( ky*(yy)) * cos(angular_freq*new_t);
    
    %Plot the first wave
    S = surf(tx,ty,tz);
    view(15,40);
    set(S,'edgecolor','none');
    axis([0 1 0 1 -2 2]);
    hold on;
    
    
    subplot(3,1,2);
    
    %Second harmonic
    n = 2;
    kx = (n *pi)/length;
    ky = (n * pi)/length;
    
    %Compute the second standing wave
    tz = 2 * initial_amplitude * sin(kx*(xx)) .* sin( ky*(yy)) * cos(angular_freq*new_t);
    
    %Plot the second wave
    S = surf(tx,ty,tz);
    view(15,40);
    set(S,'edgecolor','none');
    axis([0 1 0 1 -2 2]);
    hold on;
    
    
    subplot(3,1,3);
    
    %Third harmonic
    n = 3;
    kx = (n *pi)/length;
    ky = (n * pi)/length;
    
    %Compute the third standing wave
    tz = 2 * initial_amplitude * sin(kx*(xx)) .* sin( ky*(yy)) * cos(angular_freq*new_t);
    
    %Plot the third wave
    S = surf(tx,ty,tz);
    view(15,40);
    set(S,'edgecolor','none');
    axis([0 1 0 1 -2 2]);
    hold on;
    
    
    fname = fullfile(out_dir,sprintf("img%03i.png",i));
    imwrite(getframe(gcf).cdata,fname);
    hold off;
    
    %Update the time
    new_t += 0.1;
    
    subplot(3,1,1);
    hold off;
    
    subplot(3,1,2);
    hold off;
    
     subplot(3,1,3);
    hold off;
  endfor
endfunction
