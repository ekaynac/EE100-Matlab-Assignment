% Question 1 
X = rand(1,80);
Z = 60*rand(12,12);

% A
max(X)
max(max(Z))

% B
min(X)
min(min(Z))

% C
sum(X)
sum(sum(Z))

% D
mean(X)
mean(mean(Z))

clear all; close all;
% Question 2
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


clear all; close all;
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


clear all; close all;
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


clear all; close all;
%Question 4

[x,y] = meshgrid(linspace(-5,5));

func = sin(2*x)/pi./x.*sin(3*y)/pi./y;

mesh(x,y,func)



clear all; close all;
%Question 5
for i=1:6
    road_quston = [0 1 0 0 1 1;
               1 0 1 0 0 1;
               0 1 0 1 0 1;
               0 0 1 0 1 1;
               1 0 0 1 0 1;
               1 1 1 1 1 0];
    while(any(road_quston(i,:)))
        chosen = 1;
        road_quston(i,chosen) = 0;
        
        while(road_quston(i,chosen) == 0)
            chosen = random('Poisson',3);
            while(chosen == 0)
                chosen = random('Poisson',3);
            end
        end
    
        if(road_quston(i,chosen) == 1)
            road_quston(i,chosen) = 0;
        end
         i = chosen;
    end
end



clear all; close all;

%% Set some paremeters (block length, threshold) used in the 4 procesing steps below 
% block length for transformation (i.e. dimension of coordinate system)
B = 512 ; 
% Threshold value used to set samples in transformed domain ((i.e. new
% coordinate system) to zero. Samples less than threshold will be set to 0
% for data reduction (i.e compression)
Threshold = 1 * 2 * 10^(-1) ;


%% Get audio data and hear it and display it
[y,Fs] = audioread('handel.wav');
info = audioinfo('handel.wav') ;
y = y(1:B*floor(length(y)/B));
sound(y,Fs);
t = 0:1/Fs:(length(y)/Fs);
t = t(1:end-1);
figure, plot(t,y); title('Original sound signal');
xlabel('Time')
ylabel('Audio Signal');
set(gca,'YLim',[-1 1]); grid minor;


%% Step 1 : Data in original domain (coordinate system)
mydata = y ;
% form block data using blocks of B successive samples

for i=1:length(mydata)/B
   block_data(:,i) = mydata((i-1)*B+1:i*B)' ; 
end

% count number of nonzeros samples in mydata
num_nonzero_samples = sum(  abs(mydata(:)) > 0  ); 


%% Step 2 : Transform data into new domain (coordinate system)
% get (coordinate) transformation matrix T
T = dctmtx(B) ;
% apply (coordinate) transformation to every block of B=512 successive samples

for i=1:size(block_data,2)
   transformed_block_data(:,i) = T * block_data(:,i) ; 
end


%% Step 3 : Reduce data samples in new domain because error due to data reduction will small in this domain (think : why?)
% apply data reduction (i.e. compression) to transformed data by setting
% small amplitude samples from every transformed block (i.e. with absolute value less than Threshold) to zero

transformed_block_data_reduced = transformed_block_data;
transformed_block_data_reduced( abs(transformed_block_data) < Threshold ) = 0 ;

% count number of nonzeros samples in data after transformation and data reduction
num_nonzero_samples_after_transformation_datareduction =  sum(  abs(transformed_block_data_reduced(:)) > 0  );

%% Step 4 : Transform (or map) back the reduced data to original domain (coordinate system)
% map transformed and reduced data back to original (coordinate system) domain
invT = inv(T);

for i=1:size(block_data,2)
   original_domain_approximate_block_data(:,i) = invT * transformed_block_data_reduced(:,i) ; 
end

pause(10); % wait 10 seconds until original sound finishes playing, then play approximate sound. i.e. the sound signal obtained after 4th step
% listen to the reduced (i.e. compressed) sound data and plot it again
sound(mydata, Fs);
figure, plot(t, mydata); 
title('Sound signal  after transformation, data reduction and inverse transformation to original domain (coordinate system)')
xlabel('Time')
ylabel('Audio Signal');
set(gca,'YLim',[-1 1]); grid minor;



%% part-c : Plot a block of data after each of the 4 steps.
M = 50;
figure,
subplot(4,1,1); plot(block_data(:,M));         set(gca,'YLim',[-2 2]); grid minor; title('Mth block of data (sound samples)')
subplot(4,1,2); plot(transformed_block_data(:,M));         set(gca,'YLim',[-2 2]); grid minor; title('Transformed samples of Mth block of data');
subplot(4,1,3); plot(transformed_block_data_reduced(:,M));         set(gca,'YLim',[-2 2]); grid minor; title('Reduced Transformed samples of Mth block of data');
subplot(4,1,4); plot(original_domain_approximate_block_data(:,M));         set(gca,'YLim',[-2 2]); grid minor; title('Approximation of Mth block of data from reduced Transformed samples of Mth block of data');



