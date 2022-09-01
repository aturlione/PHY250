tx = ty = linspace (-10*pi, 10*pi, 1000)';
[xx, yy] = meshgrid (tx, ty);

w=1
t=0
dt=0.1
factor=10
vx=1

for i=1:2
t +=dt;

xx -=vx*dt;

for j=0:5
  disp(j)
  tz +=0.01*sin (1*sqrt((xx).^2+(yy+8*j-40).^2)-w*t);
endfor

S=surf (tx, ty, tz);

#view(45, 60)
view(0, 90)

set(S,'edgecolor','none');


axis([-factor*pi factor*pi  -factor*pi factor*pi -30 30 ]);

filename=sprintf('E:\\Digipen\\PHY250\\2021\\Homeworks\\Final_project\\Difraction\\Animation\\%05d.png',i);
print(filename);
  

  
endfor