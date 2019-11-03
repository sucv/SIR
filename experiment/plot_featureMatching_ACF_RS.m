close all;
clear;
load('FM_ACF_result.mat');
result=FM_ACF_result;

num=size(result,1)*10;
err=linspace(0,1,40);

r1=result(:,1);r1=sort(r1); 
p1=result(:,2);p1=sort(p1); 
f1=result(:,3);f1=sort(f1); 

fig1=figure;
[N,edges] = histcounts(r1,err);
sucess=cumsum(N)./num;
plot(err', r1,'-ks','MarkerSize',10,'linewidth',1.5); hold on;


r1=round(mean(result(:,1)),4); r1=sprintf('%.4f', r1); s1=['SIR:' ' ' r1];

lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =24;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XMinorTick','on','YMinorTick','on');
grid(gca,'minor')
grid on;
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

fig2=figure;
[N,edges] = histcounts(p1,err);
sucess=cumsum(N)./num;
plot(err', p1,'-ks','MarkerSize',10,'linewidth',1.5); hold on;


p1=round(mean(result(:,2)),4);
p1=sprintf('%.4f', p1);
s1=['SIR:' ' ' p1];


lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =24;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XMinorTick','on','YMinorTick','on');
grid(gca,'minor')
grid on;
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

fig3=figure;
[N,edges] = histcounts(f1,err);
sucess=cumsum(N)./num;
plot(err', f1,'-ks','MarkerSize',10,'linewidth',1.5); hold on;


f1=round(mean(result(:,3)),4);
f1=sprintf('%.4f', f1);
s1=['SIR:' ' ' f1];

lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =24;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XMinorTick','on','YMinorTick','on');
grid(gca,'minor')
grid on;
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

load FM_RS_result;
result=FM_RS_result;


num=size(result,1)*10;
err=linspace(0,1,40);

r1=result(:,1);r1=sort(r1); 
p1=result(:,2);p1=sort(p1); 
f1=result(:,3);f1=sort(f1); 



fig4=figure;
[N,edges] = histcounts(r1,err);
sucess=cumsum(N)./num;
plot(err', r1,'-ks','MarkerSize',10,'linewidth',1.5); hold on;
ylim([0, 1]);

r1=round(mean(result(:,1)),4);
r1=sprintf('%.4f', r1);


s1=['SIR:' ' ' r1];


lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =24;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XMinorTick','on','YMinorTick','on');
grid(gca,'minor')
grid on;
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

fig5=figure;
[N,edges] = histcounts(p1,err);
sucess=cumsum(N)./num;
plot(err', p1,'-ks','MarkerSize',10,'linewidth',1.5); hold on;
ylim([0, 1]);

p1=round(mean(result(:,2)),4);
p1=sprintf('%.4f', p1);

s1=['SIR:' ' ' p1];

lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =24;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XMinorTick','on','YMinorTick','on');
grid(gca,'minor')
grid on;
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

fig6=figure;
[N,edges] = histcounts(f1,err);
sucess=cumsum(N)./num;
plot(err', f1,'-ks','MarkerSize',10,'linewidth',1.5); hold on;
ylim([0, 1]);

f1=round(mean(result(:,3)),4);
f1=sprintf('%.4f', f1);

s1=['SIR:' ' ' f1];

lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =24;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XTickLabel',str2mat('0','0.2','0.4','0.6','0.8','1.0'));
set(gca,'XMinorTick','on','YMinorTick','on');
grid(gca,'minor')
grid on;
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];