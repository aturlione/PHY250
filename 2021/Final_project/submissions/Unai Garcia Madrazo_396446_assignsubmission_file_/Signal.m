
#################################################################
# TOTAL GRADE EXERCISE 2: 50/50p
#################################################################

#The simulation is performed correctly ---> 35/35
#The questions are answer correctly ---> 15/15
#################################################################

function Signal
  
  %Name for the folder to create the images at
  out_dir = "result_images_signal";
  %Makes the directory
  mkdir(out_dir);
  
  for i=1:2
   
  %Reads the sound 
  if(i == 1)  
    [s fs] = audioread('Sounds\Viola.wav');
  else
    [s fs] = audioread('Sounds\Cello.wav');
  endif
  
  %Normalizes the s
  s = s/max(s);
  
  %Computes the fourier
  trans = abs(fft(s));
  %Computes the length
  L = length(trans);
  %Negates the bottom part
  spectrum = trans(1:L/2);
  
  %Computes the length for the spectrum
  Ls = length(spectrum);
  spectrum = spectrum/max(spectrum);
  %Writs the frequencies in terms of the sampling rate
  frequencies = fs*(1:(L/2))/L;
  %Computes the length for the frequencies
  Lf = length(frequencies);
  
  %Computes the amount of s
  n = length(s);
  %Computes the finish time (TOTAL TIME)
  t = n/fs;
  %Computes the timestep
  Ts = 1/fs;
  %Computes the array for the time
  time = [0:Ts:(t-Ts)];
  
  figure(1);
  
  y_distance = 0.5;
  x_start = 0.4;
  x_distance = 0.1;
  
  %Plots the signal over the time
  subplot(3,1,1);
  plot(time,s,'b');
  title(['Signal']);
  xlabel ("Time(s)");
  ylabel ("Amplitude");
  axis([x_start,x_start+x_distance,-y_distance,y_distance]);
  
  x_start = 0;
  x_distance = 3000;
  y_start = 0;
  y_distance = 1;
  
  %Plots the amplitude over the frequencies
  subplot(3,1,2);
  plot(frequencies,spectrum,'b');
  title(['Spectrum']);
  xlabel ("Frequencies(Hz)");
  ylabel ("Amplitude");
  axis([x_start,x_start + x_distance,y_start,y_start+y_distance]);
  
  A = [];
  if(i == 1)  
    A = [0.05,1,0.6,0.3,0.4,0.3,0.1];
    f0 = 125;
  else
    A = [1,0.75,0.61,0.04,0.03,0,0.02];
    f0 = 230;
  endif
  
  f = A(1)*cos(2*1*pi*f0*time);  
  for n=2:7
    f += A(n)*cos(2*n*pi*f0*time);  
  endfor 
  
  if(i == 1)
    f = f/7;
  else
    f = f/10;
  endif
  
  y_distance = 0.5;
  x_start = 0.4;
  x_distance = 0.1;
  
  %Plots the function over the time
  subplot(3,1,1);
  hold on;
  plot(time,f,'r');
  axis([x_start,x_start+x_distance,-y_distance,y_distance]);

  x_start = 0;
  x_distance = 3000;
  y_start = 0;
  y_distance = 1;
  
  %Plots the amplitude over the frequencies
  subplot(3,1,3);
  frequencies = linspace(f0,f0*7,7);
  bar(frequencies,A,0.1,'r');
  title(['Simulated spectrum']);
  xlabel ("Frequencies(Hz)");
  ylabel ("Amplitude");
  axis([x_start,x_start + x_distance,y_start,y_start+y_distance]);  
  
  %Writes into file images at the end   
  if(i == 1)  
    fname = fullfile(out_dir, sprintf("SoundGraph_Viola.jpg", i));
  else
    fname = fullfile(out_dir, sprintf("SoundGraph_Cello.jpg", i));
  endif
  imwrite(getframe(gcf).cdata,fname);
  hold off;  
endfor  
endfunction

%Compare your sounds with the sources. What are the differences between your
%signals and the sources?

% Our plot is similar to the original plot but not the same, as the original plot takes into acount the change
% of the amplitud over the time, and also has some destructive and constructives interferences generated by
% the resonance chamber of the instrument which will make the sound wave change but in our case we are not taking
% that into account

%  How could you improve the quality of the digitalized sounds?

%  If we take more frecuencies to generate the sound the result will be much precise and better, and also we should
%  consider how the amplitude and frequency varies with the time and the waves generated by the resonance chamber.
