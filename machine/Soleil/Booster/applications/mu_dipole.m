% test effet mu 1000 à 50000

Imax=500;
L=330;
g=22;

I=1:1:500;
B=2*(12.56)*12*I/(g)*1e-4;
db=-L/g./(1000+5000*I/Imax) + 0.0005./B;

plot(db(20 : 500))