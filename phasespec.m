function phasespec(x,Fs,wlen,N,overlap,maxfreq,alpha)

h = hamming(wlen);
stp = wlen - overlap;
offset = [1:stp:length(x)-wlen];		%starting of each window

n = [1:size(x,1)]';
y = n.*x;


X = zeros(wlen,length(offset));		%length(offset) = number of windows
for i=1:length(offset)
    X(1:wlen,i) = x(offset(i):offset(i)+wlen-1).*h;
end

Y = zeros(wlen,length(offset));
for i=1:length(offset)
    Y(1:wlen,i) = y(offset(i):offset(i)+wlen-1).*h;
end


X_k = fft(X,N)/N;		%why /N
Y_k = fft(Y,N)/N;


tau = (real(X_k).* real(Y_k) + imag(X_k).*imag(Y_k))./(abs(X_k).^2);	%group delay
tau_modified = (tau./(abs(tau))).*(abs(tau).^alpha);                    %modified group delay

%relative_phase = angle(X_k) + 
%Convert to cepstrum
c = dct2(tau);

%maxfreq to see in STFT
hlf = round(N/2);
c = c(1:hlf,:);
f = [0:hlf-1]*Fs/N;
t = offset/Fs;

STFTmag = c(2:N*maxfreq/Fs,:);
%STFTmag = STFTmag/max(max(STFTmag)); % normalize so max magnitude will be 0 db
%STFTmag = max(STFTmag, 10^(-80/10)); % clip everything below -80 dB

pcolor( f(2:N*maxfreq/Fs),t,STFTmag');
%pcolor( f(2:N*maxfreq/Fs),t,zeros(size(STFTmag')));

axis xy;
colormap default; %colorbar(jet);
shading flat;

% surf(t, f(2:N*maxfreq/Fs), STFTmag);
% axis xy; view(20,84);
% colormap(jet);
% shading interp;
% set(gca,'visible','off')
% set(gca,'position',[0 0 1 1],'units','normalized')
% colorbar

end