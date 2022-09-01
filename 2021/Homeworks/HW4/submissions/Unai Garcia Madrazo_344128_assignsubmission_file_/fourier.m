function fourier
  
  figure(1)
  title("Fourier Aproximation");
  
  %Name for the folder to create the images at
  out_dir = "result_images_fourier";
  %Makes the directory
  mkdir(out_dir);
  
  %Values for drawing and iterating
  max_iterations = 41;
  frames = 300;
  range_x = 1;  
  range_y = 0.5;  
  x_values = linspace(-1,1,frames);
  sum = linspace(0,0,frames);
  
  i = 1;
  while (i != max_iterations)
    
    %Calculates the value for the y
    y_val = 2/(i*pi) * power(-1,(i-1)/2)*cos(i*pi*x_values);
    y_val += sum;
    sum = y_val;
    y_val = 1/2 + y_val;

    %Plotting for the function
    plot(x_values,y_val);
    axis([-range_x,range_x,-1+range_y,1+range_y]);
    hold on;
    
    %Plotting for the desired wave (manually plotted)
    
    %First segment
    line([-1,-0.5],[0,0]);
    axis([-range_x,range_x,-1+range_y,1+range_y]);
    hold on;
    %Second segment
    line([-0.5,-0.5],[0,1]);
    axis([-range_x,range_x,-1+range_y,1+range_y]);
    hold on;
    %Third segment
    line([-0.5,0.5],[1,1]);
    axis([-range_x,range_x,-1+range_y,1+range_y]);
    hold on;
    %Fourth segment
    line([0.5,0.5],[0,1]);
    axis([-range_x,range_x,-1+range_y,1+range_y]);
    hold on;
    %Fifth segment
    line([1,0.5],[0,0]);
    axis([-range_x,range_x,-1+range_y,1+range_y]);
    title("Fourier Aproximation");    
    hold off;  
    
    %Increments the i by two, as we only care about odd numbers
    i += 2;
    
    %Writes into file images at the end   
    fname = fullfile(out_dir, sprintf("img%0.3i.png",i));
    imwrite(getframe(gcf).cdata,fname); 
  endwhile

endfunction