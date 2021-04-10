clc
close all
clear all

outer_name = 'F:\nnfl_Project\EmoDB\wav\' ;
mini_len = 1000000000 ;
max_len = 0 ;
files = dir(outer_name) ;

%Read max and min length of audio file
for i=3:length(files)
    f_name = files(i).name ; 
    [y,fs] = audioread(strcat(outer_name,f_name)) ;
    
    if(length(y) < mini_len)
        mini_len = length(y) ;
        
    end
    
    if(length(y) > max_len)
        max_len = length(y) ;
        mxfile = files(i).name ;
    end
end

Y = zeros(mini_len,length(files)-2);

%Cut down all files to same time length (i.e. min length) 
for i=3:length(files)
    f_name = files(i).name ;
    [y,fs] = audioread(strcat(outer_name,f_name)) ;
    
    mid = round(length(y)/2) ;
    up = mid + mini_len/2 ;
    down = mid - mini_len/2 ;
    y = y(down+1:up) ;
    
    Y(:,i-2) = y';
end

%Save spectogram of all audio files with same name as audio file
nsc = 256;
N = 256;
overlap = 128;
maxfreq = 8000;
alpha = 0.1;

for i=3:length(files)
%for i=3:4
    f_name = files(i).name;
    phasespec(Y(:,i-2),fs,nsc,N,overlap,maxfreq,alpha);
    set(gca,'XTick',[], 'YTick', []);
    set(gca,'LooseInset',get(gca,'TightInset'));
    saveas(gcf, strcat(f_name(1:end-4),'.jpg'));
end