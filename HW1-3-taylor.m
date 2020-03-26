%Question 3-B

x = linspace(-0.50,0.50);

exact = log((1+x)./(1-x));
apprx = 2*x;
miss = abs(exact-apprx);
i = 1;

while(any(miss > 10^-3))
    apprx = apprx + 2/(2*i+1)*(x.^(2*i+1));
    miss = abs(exact-apprx);
    i = i+1;
end

i