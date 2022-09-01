
a=0.4; %circle radious
v0=10; %limit velocity
N=15; % number of points in the grid
l=-2.5; % lower limit in space interval
u=2.5;  % uper limit in space interval
lz=l;

Np=1  %number of lines of particles

scale_factor = 0.02; %velocity scale fator

%------------Mesh grid------------
xx=linspace(l,u,N); 

zz=linspace(lz,u,N);

[x,z]=meshgrid(xx,zz);

%------------Velocity field------------

vx=-(3*v0*a^3/2)*z.*x./sqrt(x.^2+z.^2).^5;
vz=v0+(v0*a^3/2)*(1 ./sqrt(x.^2+z.^2).^3-2*(z.^2)./sqrt(x.^2+z.^2).^5);


for i=1:N
  for j=1:N
    cond= sqrt(x(i,j)^2+z(i,j)^2);
    if (cond<a)
      vx(i,j)=0;
      vz(i,j)=0;
    endif
   endfor
endfor

%------------Particles Initial Position------------

xp=zeros(Np,N);
zp=zeros(Np,N);



for i=1:Np
  for j=1:N
    xp(i,j)=l + ((u-l)/N)*j;
    zp(i,j)=lz+(i-1)*((u-lz)/(2.8*Np))+2;
  endfor
endfor


%------------------------time loop----------------

dt=0.2 % time step

for i=1:100
  for k=1:Np
    disp ("--------line---------"), disp( k),disp("--------------------")
    for j=1:N
      
      
      %velocity interpolation
      vxp = interp2 (x, z, vx, xp(k,j), zp(k,j),'spline');
      vzp = interp2 (x, z, vz, xp(k,j), zp(k,j),'spline');
      
      
      %actualize particle position
      xp(k,j) +=scale_factor*vxp*dt;
      zp(k,j) +=scale_factor*vzp*dt;
      
      %Collision with central object
      cond= sqrt(xp(k,j)^2+zp(k,j)^2)
      
 
      if(cond<a)
      
        A=(scale_factor*vxp_prev)^2+(scale_factor*vzp_prev)^2;
        B=2*(xp_prev*vxp_prev*scale_factor+zp_prev*vzp_prev*scale_factor);
        C=xp_prev^2+zp_prev^2-a^2;
        
        
        dt_new2_a=(-B+sqrt(B^2-4*A*C))/(2*A);
        dt_new2_b=(-B-sqrt(B^2-4*A*C))/(2*A);
        
        
        dt_new2=dt_new2_a
        
      
        xp(k,j) = xp_prev+scale_factor*vxp_prev*dt_new2;
        zp(k,j) =zp_prev+scale_factor*vzp_prev*dt_new2;

      
     endif
     
     xp_prev=scale_factor*vxp*dt;
     zp_prev=scale_factor*vzp*dt;
     vxp_prev=vxp;
     vzp_prev=vzp;

    endfor
endfor
  
    %------------------------Plot particles position----------------
    plot(xp,zp,'ko');
      
    %------------------------Plot axis properties-------------------
    title ({"Fluid Simulation";"Non viscosity - Non rotational"},"fontsize", 12);
    xlabel ("x ","fontsize", 16);
    ylabel ("y ","fontsize", 16);


    daspect ([1 1])
    axis([l u lz u])
      
    hold on
  %--------------Plot obstacle--------------------
  t = linspace(0,2*pi,100)'; 

  xc=a*cos(t);
  zc=a*sin(t);

  plot(xc,zc);
  %---------------Plot vectorial field
  h = quiver (x,  z, vx*scale_factor, vz*scale_factor,'AutoScale','off');
  hold off
  %--------------Print plot
  filename=sprintf('E:/Digipen/PHY250/2021/Fluid_simulation/vectorialfield/animation/%05d.png',i);
  print(filename);
endfor



