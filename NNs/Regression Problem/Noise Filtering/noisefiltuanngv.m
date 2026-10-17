%Noise filtering using ANN
A=wavread('audio1.wav');
B=A(:,2);
B=B(6001:1:6500,1);
B=B';

% Done for smoothning
B=(B+1)/2;

% Filter coefficient
H=[0.7071 -0.7071];

% Convolving with the above mentioned filter coefficients
% to get the noisy signal
C=conv(H,B);

%Collections
INPUTVECTOR=[ ];
OUTPUTVECTOR=[ ];

for i=1:1:500
x=round(rand*(100-12))+1;
INPUTVECTOR=[INPUTVECTOR;C(x:1:x+10)];
OUTPUTVECTOR=[OUTPUTVECTOR;B((x+11))];
end

Combined  = [INPUTVECTOR OUTPUTVECTOR]
% For obtaining feature values to excel we use xlswrite
xlswrite('Trainingdata',Combined);