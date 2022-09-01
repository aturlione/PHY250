tx = ty = linspace (-4*pi, 4*pi, 400)';
[xx, yy] = meshgrid (tx, ty);

w=1
t=0
dt=0.1
factor=1
Lx=1
Ly=1
n=3
m=3

for i=1:100
t +=dt



#tz = sin (2*sqrt(xx.^2+yy.^2)-w*t) 
#tz = sin (2*(xx+yy)-w*t)
tz = sin (n*pi*xx/Lx).*sin (m*pi*yy/Lx)*cos(w*t);
S=surf (tx, ty, tz);
title('n=3, m=3')
#view(45, 60)
view(45, 50)

set(S,'edgecolor','none');


axis([-Lx Lx  -Ly Ly -2 2 ]);

filename=sprintf('E:/Digipen/PHY250/2021/2Dwaves/Animation3/%05d.png',i);
print(filename);
  

  
endfor