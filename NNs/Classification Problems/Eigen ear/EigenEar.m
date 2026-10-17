clear all;close all;
k=1;md=117;vd=139;

for i=1:1:10 
        % read all 10 ear images-->normalize them-->then plot those.
        earImage=strcat('C:\SampleEarPhotos\1\','ear',num2str(1),num2str(i),'.bmp'); 
        new = imread(earImage); 
        rzEarImage = imresize(new,[50,50],'bilinear'); 
        rzEarImage=rgb2gray(rzEarImage); 
        temp2= rzEarImage; 
        temp1=reshape(rzEarImage,1, size(rzEarImage,1)*size(rzEarImage,2));
        temp1=double(temp1);
        temp1=meanvarnorm(temp1,md,vd);
        final{k}=temp1;
        figure(1);
        normEarImageMat=reshape(temp1,50,50);
        subplot(2,5,i);
        colormap(gray);
        imagesc(normEarImageMat);
        k=k+1;
end

f=cell2mat(final');
f=double(f);
% Find the covariance matrix.It actually give covariance between the 10 images that is read
c=cov(f);
% Find the first 6 eigenvalues and corresponding eigen vectors
[E,V]=eigs(c);

%plot the eigen vectors
for i=1:1:6 
    figure(2);
    F=reshape(E(:,i),50,50);
    subplot(2,3,i);
    colormap(gray);
    imagesc(F);
end

for i=1:1:10
    earImage=strcat('C:\SampleEarPhotos\2\','ear',num2str(1),num2str(i),'.bmp');
    earImage=imread(earImage);
    earImage = imresize(earImage,[50,50],'bilinear');
    earImage=rgb2gray(earImage);
    earImage=double(earImage);
    s1=reshape(earImage,1,size(earImage,1)*size(earImage,2));
    s1=meanvarnorm(s1,md,vd);
    
    FeatureArray=[];
    % Find scalar product of the eigenvectors with the mean.
    for j=1:1:6
        FeatureArray=[FeatureArray sum(s1.*E(:,j)')];
    end
    FEA{i}=FeatureArray;
end

% Save the features as a file if required.
save FEA FEA E md vd
for i=1:10
    FinalFeatureArray(i,:) = FEA{i};    
end
% For obtaining feature values to excel we use xlswrite
xlswrite('FeatureValues',FinalFeatureArray);