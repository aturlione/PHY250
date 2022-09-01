function [frequencies_sim,signal]=simulation(A,f,fs,n)
  
#  fs=44100;  % Sampling frequency---define the time step
#  t=0:1/fs:10;  % Time vector of 10 second
t=n/fs;
Ts=1/fs;
t=[0:Ts:(t-Ts)];
  n=1;

  w=zeros(1,7);
#  A=zeros(1,6);
#  f=zeros(1,6);

  signal=0
#{
  A(1)=0.4
  A(2)=1
  A(3)=0.55
  A(4)=0.57
  A(5)=0.3
  A(6)=0.25


  f=200
#}
  for i=1:7

  w(i)=2*pi*i*f;

  signal +=A(i)*cos(w(i)*t);

  end

  signal=signal/20;
  frequencies_sim=w/(2*pi)

#audiowrite('E:\\Digipen\\PHY250\\2021\\Final_project\\Sound\\cello.wav', signal,fs);
 
endfunction
