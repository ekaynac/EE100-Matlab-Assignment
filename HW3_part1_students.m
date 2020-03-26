clear all; close all;


%% Set some paremeters (block length, threshold) used in the 4 procesing steps below 
% block length for transformation (i.e. dimension of coordinate system)
B = 2 ; 
% Threshold value used to set samples in transformed domain ((i.e. new
% coordinate system) to zero. Samples less than threshold will be set to 0
% for data reduction (i.e compression)
Threshold = 5 ;


%% Step 1 : Data in original domain (coordinate system)
load mydata.mat;
% form block data using blocks of B=2 successive samples
for i=1:length(mydata)/B
   block_data(:,i) = mydata((i-1)*B+1:i*B)' ; 
end
% plot data from every block
oddsamples  = block_data(1,:);
evensamples = block_data(2,:);
figure, plot(oddsamples,evensamples,'.'); set(gca,'XLim',[-100 100],'YLim',[-100 100]); grid minor;
title('Scatter (x-y) plot of every 2 samples'); xlabel('Odd samples'); ylabel('Even samples');
% count number of nonzeros samples in data
num_nonzero_samples = sum(  abs(mydata(:)) > 0  ); 


%% Step 2 : Transform data into new domain (coordinate system)
% get (coordinate) transformation matrix T
load Transform2x2.mat ;
% apply (coordinate) transformation to every block of B=2 successive samples
for i=1:size(block_data,2)
   transformed_block_data(:,i) = T * block_data(:,i) ; 
end
% plot transformed data from every block
transformed_oddsamples  = transformed_block_data(1,:);
transformed_evensamples = transformed_block_data(2,:);
figure, plot(transformed_oddsamples,transformed_evensamples,'.'); set(gca,'XLim',[-100 100],'YLim',[-100 100]); grid minor;
title('Scatter plot of every 2 samples after transformation (i.e. in new coordinate system)'); 
xlabel('Transformed Odd samples'); ylabel('Transformed Even samples');


%% Step 3 : Reduce data samples in new domain because error due to data reduction will small in this domain (think : why?)
% apply data reduction (i.e. compression) to transformed data by setting
% small amplitude samples from every transformed block (i.e. with absolute vale less than a threshold) to zero
transformed_block_data_reduced = transformed_block_data;
transformed_block_data_reduced( abs(transformed_block_data) < Threshold ) = 0 ;
% count number of nonzeros samples in data after transformation and data reduction
num_nonzero_samples_after_transformation_datareduction = sum(  abs(transformed_block_data_reduced(:)) > 0  ); 
% plot transformed data from every block after sample reduction
transformed_oddsamples_reduced  = transformed_block_data_reduced(1,:);
transformed_evensamples_reduced = transformed_block_data_reduced(2,:);
figure, plot(transformed_oddsamples_reduced,transformed_evensamples_reduced,'.'); set(gca,'XLim',[-100 100],'YLim',[-100 100]); grid minor;
title('Scatter plot of every 2 samples after transformation (i.e. in new coordinate system) and sample reduction'); 
xlabel('Transformed Odd samples after sample reduction'); ylabel('Transformed Even samples after sample reduction');


%% Step 4 : Transform (or map) back the reduced data to original domain (coordinate system)
% map transformed and reduced data back to original (coordinate system) domain
invT = inv(T) ;
for i=1:size(block_data,2)
   original_domain_approximate_block_data(:,i) = invT * transformed_block_data_reduced(:,i) ; 
end
% plot data after mapping back to original domain (coordinate system)
original_domain_approximate_block_data_oddsamples   = original_domain_approximate_block_data(1,:);
original_domain_approximate_block_data_evensamples  = original_domain_approximate_block_data(2,:);
figure, plot(original_domain_approximate_block_data_oddsamples,original_domain_approximate_block_data_evensamples,'.'); 
set(gca,'XLim',[-100 100],'YLim',[-100 100]); grid minor;
title('Scatter plot of every 2 samples after data reduction in transform domain and mapping back to original domain (coordinate system)'); 
xlabel('Odd samples'); ylabel('Even samples');




