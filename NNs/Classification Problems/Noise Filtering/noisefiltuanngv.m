%Noise filtering using ANN
A=wavread('audio1.wav');
B=A(:,2);
B=B(6001:1:6500,1);
B=B';
B=(B+1)/2;
H=[0.7071 -0.7071];
C=conv(H,B);
%Collections
INPUTVECTOR=[ ];
OUTPUTVECTOR=[ ];
for i=1:1:500
x=round(rand*(100-12))+1;
INPUTVECTOR=[INPUTVECTOR;C(x:1:x+10)];
OUTPUTVECTOR=[OUTPUTVECTOR;B((x+11))];
end
W1=rand(5,11);
B1=rand(5,1);
W2=rand(1,5);
B2=rand(1,1);
nntwarn off
[W1,B1,W2,B2]=trainbpx(W1,B1,'logsig',W2,B2,'logsig',INPUTVECTOR',OUTPUTVECTOR',[250 100000 0.02 0.01]);
save WEIGHTSNOISEFILT W1 B1 W2 B2
D=blkproc(C,[1 1],[0 5],'dofilter(x)');
D=(D-0.5)*2;
figure
subplot(3,1,1)
plot(B)
title('Original signal')
subplot(3,1,2)
plot(C)
title('Corrupted signal')
subplot(3,1,3)
plot(D)
title('Retrieved signal')