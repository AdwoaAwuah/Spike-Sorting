% Start of Project
%% Load Original Data

close all
load('C:\Users\use\Desktop\Neural Engineering Projects\Matlab code\01.mat') %load waveform
figure, plot(time, wave) %plot spike waveforms
hold on;

%% Spike Detection
% Separating Spikes from Background noise by setting a threshold

vari_wave = std(wave); %find the standard deviation of the wave.

threshold = 4*vari_wave; % Set Threshold

yline(threshold, 'r',"LineWidth",1.8) %plot horizontal line to indicate threshold

[PKS,LOCS]= findpeaks(wave, 'MinPeakHeight',threshold, 'MinPeakDistance',30); %find peaks above threshold

plot(time(LOCS), PKS, '*g'); %plot locations of peaks


N= numel(LOCS);  %Number or lenght of Locations
for k = 1:N
    AP(:,k) = (wave(LOCS(k)-30 : LOCS(k) +30)); %Sort the action potential waveforms
end

figure, plot(AP);



%% Feature Extraction
% Principal Component Analysis and K-means Clustering.
% Feature coefficients that best separate the spikes are identified.

[~, scores] = pca(AP'); %find the principal component analysis 

[idx,C] = kmeans(AP', 3); %group the reduced data into 3 clusters using kmeans clustering

figure,

scatter3(scores(:,1),scores(:,2),scores(:,3),1, idx ) %display the clusters using the output of PCA and Scatter3


%% Spike Sorting 
% Using the original AP matrix, plot the waveforms of the three clusters

N= numel(LOCS); 
for k = 1:N
    AP(:,k) = (wave(LOCS(k)-30 : LOCS(k) +30)); %Sort the action potential waveforms
end

hold on; 


%% Using the output of Kmeans, plot the waveforms of the three clusters with different colors.

figure, plot(AP(:,idx==1),'b');
hold on;

plot(AP(:,idx==2),'r');
hold on;

plot(AP(:,idx==3),'g');

% End of Project