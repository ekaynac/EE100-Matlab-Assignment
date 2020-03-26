%Question 4

[x,y] = meshgrid(linspace(-5,5));

func = sin(2*x)/pi./x.*sin(3*y)/pi./y;

mesh(x,y,func)
