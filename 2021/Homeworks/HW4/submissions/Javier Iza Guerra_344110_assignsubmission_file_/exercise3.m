%========================================================
% PHY250 HW4
% Digipen Bilbao
% Javier Guerra  - j.guerra@digipen.edu
%========================================================

function exercise3
  precision = 81;
  x = linspace(-1, 1, 300);
  %first iteration outside of the loop
  f =(1/2) + (2/pi) * cos(pi*x);
  %Create folder for the video
  out_dir = "temp_img";
  mkdir(out_dir);
  for i = 3: 2 : precision
    %Plot curve
    plot(x,f, 'Color', 'b');
    hold on;
    %plot lines
    plot([-1 -0.5],[0 0], 'Color', 'b')
    hold on;
    plot([-0.5 -0.5],[0 1], 'Color', 'b')
    hold on;
    plot([-0.5 0.5],[1 1], 'Color', 'b')
    hold on;
    plot([0.5 0.5],[0 1], 'Color', 'b')
    hold on;
    plot([0.5 1],[0 0], 'Color', 'b')
    hold off;
    axis([-1 1 -0.2 1.4])
    %add this iterations value
    f += 2/(i*pi)*(-1)^((i-1)/2) * cos(i*pi*x);
    %Create a image
    fname = fullfile (out_dir, sprintf("img%03i.png", i));
    imwrite (getframe (gcf).cdata, fname);
  endfor
  
  
endfunction