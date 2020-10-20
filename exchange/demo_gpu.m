n = 2048;
a = rand(n, 'double');
b = rand(n, 1 , 'double');

t= tic;
x = a\b;
