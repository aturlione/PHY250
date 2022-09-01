function travelling_wave
  out_dir =  "travelling_wave_images";
  mkdir(out_dir);
  
  %Initial data
  angular_freq = 1;
  initial_amplitude = 1;
  new_t = 0;
  first_k = [2,0];
  third_k = [2,2];
  
  %Mesh grid for the ploting
  tx = ty = linspace(-4 * pi,4 * pi,100);
  [xx,yy] = meshgrid(tx,ty);
   
  for i =1:200
    
    subplot(3,1,1);
    
    %First wave using the first k
    tz = initial_amplitude * sin(first_k(1)*(xx) + first_k(2)*(yy) - angular_freq*new_t);
    
    %Plot the first wave
    S = surf(tx,ty,tz);
    view(15,40);
    set(S,'edgecolor','none');
    axis([-4 * pi 4 * pi -4 * pi 4 * pi -2 2]);
    hold on;
    
    
    subplot(3,1,2);
    
    %Second wave using the k with the radial direction
    tz = initial_amplitude * sin(2* sqrt( xx .* xx + yy .*yy) - angular_freq*new_t);
    
    %Plot the second wave
    S = surf(tx,ty,tz);
    view(15,40);
    set(S,'edgecolor','none');
    axis([-4 * pi 4 * pi -4 * pi 4 * pi -2 2]);
    hold on;
    
    
    subplot(3,1,3);
    %Third wave using the third k
    tz = initial_amplitude * sin(third_k(1)*(xx) + third_k(2)*(yy) - angular_freq*new_t);
    
    %Plot the third wave
    S = surf(tx,ty,tz);
    view(15,40);
    set(S,'edgecolor','none');
    axis([-4 * pi 4 * pi -4 * pi 4 * pi -2 2]);
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
