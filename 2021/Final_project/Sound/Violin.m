
 fs=44100;  % Sampling frequency---define the time step
  t=0:1/fs:10;  % Time vector of 10 second
n=1;

w=zeros(1,16);
A=zeros(1,16);
dB=zeros(1,16);
f=zeros(1,16);

signal=0

dB(1)=-50.7
dB(2)=-50.2
dB(3)=-59.8
dB(4)=-45.6
dB(5)=-56.2
dB(6)=-59.8
dB(7)=-60.6
dB(8)=-48.9
dB(9)=-48.4
dB(10)=-77.4
dB(11)=-69.8
dB(12)=-65.3
dB(13)=-62.2
dB(14)=-53.2
dB(15)=-62.2
dB(16)=-50.1



f=440

for i=1:16



w(i)=2*pi*i*f;

A(i)=(1/i)*sqrt(10^(dB(i)/10)/(10^(dB(1)/10)))


signal +=A(i)*cos(w(i)*t);

end



 audiowrite('Y:/PHY250/Final_project/Sound/violin.wav', signal,fs);
 

 
 t2=linspace(1,1.005,200);
 

 signal2=0
 
for i=1:16

signal2=A(i)*cos(w(i)*t2)+signal2;
end 



% plot(t2,signal2);
 
% hold on
 
% plot(t2,A(1)*cos(w(1)*t2))
 
 freq=w/(2*pi)
 
 bar(freq,A,0.1)
  hold on