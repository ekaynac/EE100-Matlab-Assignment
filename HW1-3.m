%Question 3-A

x = linspace(-0.50,0.50)

exact = log((1+x)./(1-x))

apprx = 2*x + 2/3*x.^3 + 2/5*x.^5 + 2/7*x.^7 +2/9*x.^9

hold;
plot(exact,"-")
plot(apprx,"--")
legend("exact values","approximation");
hold;

miss = abs(exact-apprx)

max(miss)
mean(miss)
