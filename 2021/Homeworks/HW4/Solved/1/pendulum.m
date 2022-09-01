N=300; % N+1 nodes
s=0.05; % stepsize

t=linspace(0,5,N+1); % mesh of nodes
THETA=zeros(1,N+1);
PHI=zeros(1,N+1);

THETAs=zeros(1,N+1);
PHIs=zeros(1,N+1);

g=9.8
a=0.
l=2.

THETA(1)=1.; % initial condition
PHI(1)=0.;

THETAs(1)=1.; % initial condition
PHIs(1)=0.;


for i=1:N % application of Euler method
  #Explicit
  THETA(i+1)=THETA(i)+s*PHI(i);
  PHI(i+1)=PHI(i)-s*(g./l)*sin(THETA(i));
  
  x=l*sin(THETA(i+1));
  y=l*cos(THETA(i+1));
  

  
  #Semi Implicit
  
  PHIs(i+1)=PHIs(i)-s*(g./l)*sin(THETAs(i));
  THETAs(i+1)=THETAs(i)+s*PHIs(i+1);
  
  xsi=l*sin(THETAs(i+1));
  ysi=l*cos(THETAs(i+1));
  
  lengsi=sqrt(xsi^2+ysi^2)


  plot(x,y,'*b')
  axis('ij');
  hold on
  plot(xsi,ysi,'*r')
  plot([0 x], [0 y],'b')
  plot([0 xsi], [0 ysi],'r')
  hold off

  axis([-2.2 2.2 -2.2 2.2]);
filename=sprintf('E:\\Digipen\\PHY250\\2021\\Homeworks\\HW4\\Solved\\1\\Animation\\%05d.jpg',i);
xlabel("x","fontsize", 16);
ylabel("y","fontsize", 16);
legend ("Explicit", "Semi Implicit");
print(filename);
end

#plot(t,THETA,'ko') 


#hold on


