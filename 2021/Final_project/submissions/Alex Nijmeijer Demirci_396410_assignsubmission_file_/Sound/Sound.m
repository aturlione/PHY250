#################################################################
# TOTAL GRADE EXERCISE 2: 43/50p
#################################################################

#The simulation is performed correctly ---> 35p
#Regarding the questions, You didn't mention the variation in the amplitude of the origin source with 
#the time, ---> 8/15 p
#you fixed the time interval to an arbitrary range and didn't explore more.

#################################################################





% PHY250 FALL 2021 ==============================
%
% Alex Demirci Nijmeijer
% alex.demirci@digipen.edu
% 14/12/2021
%
% The user selects between two sounds, and the
% prgoram plot the amplitude over the time and over
% the frequency of the original sound
% and do an approximation graphing it
%===================================================


% Questions
%
% 4. Compare your sounds with the sources. What are the differences between your
% signals and the sources?
% - The main difference with the signals I produced are that the original signal can
%   reach lower amplitudes, this is due to the resonance chamber of real instruments
%   that helps to amplify or modulate the sound produced y it.
%   Another difference is that I took a small amount of samples, and hence my 
%   produced signal is not very accurate compared to the original one.
%
% 5. How could you improve the quality of the digitalized sounds?
% - To improve the quality of digitalized sounds we could increase the sample rate, 
%   that is, the Hz per second. If we used a lot more frequencies we could cover the
%   entire (or almost) range of sounds and thus producing much more realistic and
%   accurate sounds.

#INSTRUCTOR: The main difference is that in the real sound the amplitud is changing with the time, to improve your model you should simulate this.
#The second big difference is that in the real sound you have noise, that you are not simulating.
#there is also a shift between the harmonics as the frequency increases, that produces a shift between your signal and the origin sound.
function Sound
  
  
  option = menu('Choose Sound', 'Viola', 'Cello', 'Violin', 'Exit');
  
  % choose the viola sound
  if option == 1
    
    firstFrequency = 130;
    newAmplitudes = [0.05 1 0.6 0.3 0.4 0.3 0.1];
    divideCoefficient = 6.5;
     
     graph('Viola.wav', newAmplitudes, firstFrequency, divideCoefficient, true);
     
  % choose the cello sound
 elseif option == 2
   
    firstFrequency = 230;
    divideCoefficient = 10;
    newAmplitudes = [1 0.75 0.61 0.04 0.03 0 0.02];
    
    graph('Cello.wav', newAmplitudes, firstFrequency, divideCoefficient, true);
   % choose the violin sound
  elseif option == 3
    firstFrequency = 195;
    divideCoefficient = 8.0;
    newAmplitudes = [0.1 1 0.5 0.17 0.03 0.11 0.07];
    
    graph('Violin.wav', newAmplitudes, firstFrequency, divideCoefficient, false);
  elseif
    close;
  endif
 
endfunction


%given a filename, samples of amplitudes, the first frequency and a scale factor, 
% plot the amplitude over the time and over the frequency of the original sound
% and do an approximation graphing it
function graph(audiofile, newAmplitudes, firstFrequency, divideCoefficient, normalize)
  
  % read the file
  [s fs] = audioread(audiofile);
  
  % normalize
  if(normalize)
  s = s/max(abs(s));
  endif

  trans = abs(fft(s));
  L = length(trans);
  spectrum = trans(1:L/2);
  
  Ls = length(spectrum);
  spectrum = spectrum / max(spectrum);
  frequencies = fs * (1:(L / 2)) / L;
  Lf = length(frequencies);
  
  n = length(s);
  t = n / fs;
  Ts = 1 / fs;
  time = [0:Ts:(t - Ts)];


  % plot the amplitudes respect to the time
  subplot(2, 1, 1);
  plot(time, s, 'b');
  axis([1.4 1.5 -0.5 0.5]);
   xlabel("time(s)");
  ylabel("Amplitude");
  hold on;
  axis([0.4 0.5 -0.5 0.5]);
  title("Signal");
  xlabel("time(s)");
  ylabel("Amplitude");
  
  % plot the amplitudes over the frequencies
  subplot(2, 1, 2);
  plot(frequencies, spectrum)
  axis([0 2000 0 1]);
  title("Spectrum");
  xlabel("Frequencies(Hz)");
  ylabel("Amplitude");
  
  
  newFrequencies = linspace(0, 0, length(time));
  
  % compute the wave by adding up the waves using the wave equation
  for index = 1 : length(newAmplitudes)
    
    newFrequencies += newAmplitudes(index).*cos(2.*pi.*index.*firstFrequency.*time);

  endfor
  
  % reduce the scale to match our subplot size
  newFrequencies /= divideCoefficient;
  
  % plot the approximation of the amplitudes over the time
  subplot(2, 1, 1);
  hold on;
  plot(time, newFrequencies,'r');

  
  % plot the approximations of the amplitudes over the frequencies in form of bars
  frequencyArray = linspace(firstFrequency, firstFrequency * 7, 7);
  subplot(2, 1, 2);
  hold on;
  bar(frequencyArray, newAmplitudes,  0.02);
  
 endfunction
