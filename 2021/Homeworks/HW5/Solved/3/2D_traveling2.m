factor=5;
tx = ty = linspace (-factor*pi, factor*pi, 100)';
[xx, yy] = meshgrid (tx, ty);

w=1
t=0
dt=0.1


for i=1:200
t +=dt



tz = sin (2*sqrt(xx.^2+(yy-5).^2)-w*t)+ sin (2*sqrt(xx.^2+(yy+5).^2)-w*t)
#tz = sin (2*(xx+yy)-w*t)
#tz = sin (2*(xx)-w*t)
S=surf (tx, ty, tz);

#view(45, 60)
view(0, 90)

set(S,'edgecolor','none');


axis([-factor*pi factor*pi  -factor*pi factor*pi -2 2 ]);

filename=sprintf('E:/Digipen/PHY250/2021/2Dwaves/traveling2/%05d.png',i);
print(filename);
  

  
endfor