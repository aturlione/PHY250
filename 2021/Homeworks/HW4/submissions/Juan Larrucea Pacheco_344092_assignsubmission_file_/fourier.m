function fourier
  out_dir =  "third_exercise_images";
  mkdir(out_dir);
  
  %Initial variables
  max_number_of_iterations =40;
  period = 2;
  a0 = 1;
  
  %Arrays for plotting
  x = linspace(-1,1,300);
  y = linspace(0,0,300);
  
  %Do it for the maximun number of fourier iterations
  for u = 1: max_number_of_iterations
  
    %Respective number of iterations
    number_of_iterations = u;
    
    for i=1:300
      
      %Compute the respective a_n for the fourier graph
      current_an = 0;
      for j=1:number_of_iterations
        
        %Done to avoid imaginary parts
        k = 2*j -1;
        current_an += 2/(k * pi) * (-1)^((k-1)/2) * cos(k * pi*x(i));
      endfor
      
      %Store the respective y
      y(i) = a0/2 + current_an;
        
    endfor
    
    %Plot the fourier graph
    plot(x,y,'r');
    axis([-1,1,-0.2,1.4]);
    hold on;
    
    %Plot the square wave
    line([-1,-0.5],[0 , 0],"linestyle","-","color","b");
    axis([-1,1,-0.2,1.4]);
    hold on;
    
    line([-0.5,0.5],[1 , 1],"linestyle","-","color","b");
    axis([-1,1,-0.2,1.4]);
    hold on;
    
    
    line([0.5,1],[0 , 0],"linestyle","-","color","b");
    axis([-1,1,-0.2,1.4]);
    hold on;
    
    line([-0.5,-0.5],[0 , 1],"linestyle","-","color","b");
    axis([-1,1,-0.2,1.4]);
    hold on;
    
    line([0.5,0.5],[0 , 1],"linestyle","-","color","b");
    axis([-1,1,-0.2,1.4]);
    hold on;
    
    fname = fullfile(out_dir,sprintf("img%03i.png",u));
    imwrite(getframe(gcf).cdata,fname);
    hold off;
    
  endfor

endfunction
