
fs=44100;  % Sampling frequency---define the time step
t=0:1/fs:10;  % Time vector of 10 second
n=1;

w=zeros(1,7);
A=zeros(1,7);
dB=zeros(1,7);
f=zeros(1,7);

signal=0

A(1)=0.4
A(2)=1
A(3)=0.55
A(4)=0.57
A(5)=0.3
A(6)=0.25
A(7)=0.03


f=200

for i=1:7

w(i)=2*pi*i*f;

signal +=A(i)*cos(w(i)*t);

end

#signal=signal/10;


audiowrite('E:\\Digipen\\PHY250\\2021\\Homeworks\\Final_project\\Sound\\violin.wav', signal,fs);


subplot(2,1,1)
plot(t,signal,'b');
axis([0.4 0.45 -10 10])
hold off
title(['Signal']);
xlabel('time(s)')
ylabel('Amplitude')

subplot(2,1,2)

freq=w/(2*pi)
bar(freq,A,0.01)
axis([0 1000 0 1])
hold off
title(['Spectrum']);
xlabel('Frequencies (HZ)')
ylabel('Amplitude')

