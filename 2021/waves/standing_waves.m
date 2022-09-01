

l=10
dt=0.01
t=0
v=2


xp=5;
xp1=0;
b=1;
c=1;
n=10;

w=2*pi*n*v/(2*l)



k=w/v;
A=0.5;


k=w/v;

x=linspace(0,2*pi/k,500);


f1 =@(x,v,w,t) A*sin((w/v)*x-w*t);
f2 =@(x,v,w,t) -A*sin((w/v)*(x)+w*(t+v*l));







for i=1:300


t +=dt;

y1=f1(x,v,w,t);
y2=f2(x,v,w,t);


plot(x,y1,'--b');
hold on

plot(x,y2,'--r')



plot(x,y1+y2,'k')
axis([0 2*pi/k  -1 1]);

hold off

filename=sprintf('E:/Digipen/PHY250/2021/waves/Animation2/%05d.png',i);
print(filename);
  
  
  
endfor