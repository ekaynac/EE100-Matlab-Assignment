%% Question 2
X= [2 4 5;4 7 6;9 8 9];
Y= [6 4 3;3 5 2;4 5 1];

%(i) Matrix Multiplication
X*Y
%(ii) Elementwise Multiplication
X.*Y
%(iii) Matrix Addition
X+Y
%(iv) Scalar Addition
X+1
%(v) Matrix Multiplication (Self)
X^2
%(vi) Elementwise Squaring
X.^2
%(vii) Inverse of X
inv(X)
%(viii) (Elementwise) Scalar Multiplication
X.^(-1)

W =[X;Y]

Z =[X Y]

R = X(2,:)

E = X(1,2)