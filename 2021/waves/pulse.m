function y=pulse(t,w,v)
x=linspace(-pi*(v/w)+v*t,pi*(v/w)+v*t,500)
y=sin((w/v)*x-w*t)
endfunction
