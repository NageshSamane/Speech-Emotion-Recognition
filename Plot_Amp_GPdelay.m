clc
close all
clear all

outer_name_p = 'C:\Users\DELL\Desktop\Group_Delay\' ;
files_p = dir(outer_name_p);

outer_name_a = 'C:\Users\DELL\Desktop\Amplitude\' ;
files_a = dir(outer_name_a);

%outer_name_t = 'C:\Users\DELL\Desktop\Amp_GP Delay\' ;
%files_t = dir(outer_name_a);

for i=3:length(files_a)
%for i=3:4
    f_name_a = files_a(i).name ; 
    amp = imread(strcat(outer_name_a,f_name_a));
    
   
    f_name_p = files_p(i).name ; 
    ph = imread(strcat(outer_name_p,f_name_p));
    %a = (f_name_a==f_name_p)
     
    total = [amp,ph];
    image(total);
    set(gca,'XTick',[], 'YTick', []);
    set(gca,'LooseInset',get(gca,'TightInset'));
    saveas(gcf, strcat(f_name_a(1:end-4),'.jpg'));
    
end