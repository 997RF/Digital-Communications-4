% Pacman image and variable init
image = [ 1, 1, 1, 0, 0, 1, 1, 1;
          1, 1, 0, 0, 0, 0, 1, 1;
          1, 0, 0, 0, 1, 0, 0, 1;
          0, 0, 0, 0, 0, 0, 1, 1;
          0, 0, 0, 0, 0, 1, 1, 1;
          1, 0, 0, 0, 0, 0, 0, 1;
          1, 1, 0, 0, 0, 0, 1, 1;
          1, 1, 1, 0, 0, 1, 1, 1 ];
N=8*8;
bit_stream = [];
plott = [];
plottt = [];

% Generate the bitstream from the pacman
for j = 1:8 
bit_stream = [bit_stream image(j,:)]; 
end
graph = zeros(64,80);
for z=1:64 
    a = bit_stream(z);
     for x = 1:80
           y(x) = -((-1)^(a-1))*sin(2*pi*x/10);
     end
     graph(z,:)=y;
            
end

%
for k = 1:64
    plott = [plott graph(k,:)]; 
end

%Mixing a sine wave in
for q = 1:5120
       w(q) = sin(2*pi*q/10);
       plottt(1,q) = plott(1,q)*w(1,q);
end

%Filtering the mixed signal
b = fir1(100,0.2);
filtered_value = filter(b,1,plottt);
plot(filtered_value);

%Demodualating the filtered signal
demodulated = [];
for r=1:64
     if filtered_value(80*r)<0
         demodulated(r)=1;
     else
         demodulated(r)=0;
     end
end

%Changing the array to matrix format for imshow
image2=vec2mat(demodulated,8);

%Plotting all the graphs and images
subplot(5,1,1);
plot(plott);
title('BPSK original signal');
xlabel ("Samples");
ylabel ("BPSK signal");
subplot(5,1,2);
plot(plottt);
title('BPSK mixed signal with sine wave');
xlabel ("Samples");
subplot(5,1,3);
plot(filtered_value);
title('Filtered BPSK mixed signal');
xlabel ("Samples");
subplot(5,1,4);
imshow(image);
title('Original image');
subplot(5,1,5);
imshow(image2);
title('Demodulated image');

