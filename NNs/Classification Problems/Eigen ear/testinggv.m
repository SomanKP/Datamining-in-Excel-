load FEA
%Testing
[filename, pathname, filterindex] = uigetfile('*.bmp', 'Pick an BMP-file');
s=imread(strcat(pathname,filename));
s = imresize(s,[50,50],'bilinear');
s=rgb2gray(s);
s=double(s);
s1=reshape(s,1,size(s,1)*size(s,2));
s1=meanvarnorm(s1,md,vd);
F=[];
for j=1:1:6
F=[F sum(s1.*E(:,j)')];
end
S=[sum((FEA{1}-F).^2) sum((FEA{2}-F).^2) sum((FEA{3}-F).^2) sum((FEA{4}-F).^2)];
[P,Q]=min(S);
switch Q
case 1
A=imread('C:\Users\Aravind\Desktop\Eigen ear\Sample Ear photos\ear11.bmp');
A=rgb2gray(A);
g=gray(256);
msgbox('First person','Pattern Recognition','custom',A,g)
case 2
A=imread('C:\Users\Aravind\Desktop\Eigen ear\Sample Ear photos\ear21.bmp');
A=rgb2gray(A);
g=gray(256);
msgbox('Second person','Pattern Recognition','custom',A,g)
case 3
A=imread('C:\Users\Aravind\Desktop\Eigen ear\Sample Ear photos\ear31.bmp');
A=rgb2gray(A);
g=gray(256);
msgbox('Third person','Pattern Recognition','custom',A,g)
case 4
A=imread('C:\Users\Aravind\Desktop\Eigen ear\Sample Ear photos\ear41.bmp');
A=rgb2gray(A);
g=gray(256);
msgbox('Fourth person','Pattern Recognition','custom',A,g)
otherwise
      disp('Unknown person')
end