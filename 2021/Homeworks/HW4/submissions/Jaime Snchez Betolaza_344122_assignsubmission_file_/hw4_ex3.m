function hw4_ex3
  %Create figure and folder
  figure(1);
  out_dir = "ex3_images";
  mkdir (out_dir);
  
  %Get a sample for x
  x = linspace(-1, 1, 300);
  
  %This will store the sumation from the previous iteration
  %to add it to the new iteration
  previous = linspace(0, 0, 300);
  i = 1;
  
  while (i != 43)
    
    hold off;
    
    %Compute the increment of this iteration and add it to the total
    actual =  (2/(i*pi))*realpow(-1, (i - 1)/2)*cos(i*pi*x);
    actual += previous;
    fx = 1/2 + actual;
    
    
    %Plot the graph
    plot(x, fx);
    hold on;
    %Plot the square function
    line([-1, -0.5], [0, 0]);
    hold on;
    line([-0.5, -0.5], [0, 1]);
    hold on;
    line([-0.5, 0.5], [1, 1]);
    hold on;
    line([0.5, 0.5], [1, 0]);
    hold on;
    line([1, 0.5], [0, 0]);
    
    previous = actual;
    
    %Save the frammes
    fname = fullfile(out_dir, sprintf("img%0.3i.png", i));
    imwrite(getframe(gcf).cdata, fname);
    i += 2;
  endwhile
  
endfunction
