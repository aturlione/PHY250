function interference
  out_dir =  "interference_images";
  mkdir(out_dir);
  
  %Initial data
  distance = 10;
  angular_freq_1 = 1;
  angular_freq_2 = 1;
  initial_amplitude = 1;
  new_t = 0;
  
  %Grid to update
  tx = linspace(-4 * pi ,4 * pi,100);
  ty = linspace(-4 * pi,4 * pi,100);
  [xx,yy] = meshgrid(tx,ty);
  
  
  for i =1:200
    
    %Compute the new value of the grid using the first emiter
    tz = initial_amplitude * sin(2* sqrt( (xx + distance/2) .* (xx + distance/2) + yy .*yy) - angular_freq_1*new_t);
    
    %Compute the new value of the grid using the second emiter
    tz += initial_amplitude * sin(2* sqrt( (xx - distance/2) .* (xx - distance/2) + yy .*yy) - angular_freq_2*new_t);
    
    %Plot the interference
    S = surf(tx,ty,tz);
    view(0,90);
    set(S,'edgecolor','none');
    axis([-4 * pi 4 * pi -4 * pi 4 * pi -2 2]);
    hold on;
    
    
    fname = fullfile(out_dir,sprintf("img%03i.png",i));
    imwrite(getframe(gcf).cdata,fname);
    hold off;
    
    %Update the time
    new_t += 0.1;
  endfor
  
  
endfunction
