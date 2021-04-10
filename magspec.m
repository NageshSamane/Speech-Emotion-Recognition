function magspec(x,Fs,nsc,N,overlap,maxfreq)

h = hamming(nsc);       %nsc window length
stp = nsc - overlap;
offset = [1:stp:length(x)-nsc];  % array of starting points of all windows
n = [1:size(x,1)]'; 
    
y = n.*x;

X = zeros(nsc,length(offset));

for i=1:length(offset)
    X(1:nsc,i) = x(offset(i):offset(i)+nsc-1).*h;
end

c = abs(fft(X,N));

%maxfreq to see in STFT
hlf = round(N/2);
c = c(1:hlf,:);
f = [0:hlf-1]*Fs/N;
t = offset/Fs;

STFTmag = c(2:N*maxfreq/Fs,:);

%STFTmag = STFTmag/max(max(STFTmag)); % normalize so max magnitude will be 0 db
%STFTmag = max(STFTmag, 10^(-80/10)); % clip everything below -80 dB

pcolor(f(2:N*maxfreq/Fs),t, [20*log10(STFTmag)]');
% set(gca,'visible','off')

axis xy;
colormap default; %colorbar(jet);
shading flat;
% colorbar
% surf(t, f(2:N*maxfreq/Fs), 20*log10(STFTmag));
% axis xy; view(20,84);
% colormap(jet);
% shading interp;
% set(gca,'visible','off')
% set(gca,'position',[0 0 1 1],'units','normalized')
end