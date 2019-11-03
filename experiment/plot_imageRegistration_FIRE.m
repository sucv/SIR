close all;
clear;

result=load('FIRE_result');result=result.FIRE_result;
num=size(result,1);
pc=0.1;
err=[0:pc:30];

fig1=figure;
[N,edges] = histcounts(result(:,1),err);
sucess=cumsum(N)./num;
plot(err(2:end), sucess,'-k','linewidth',4); hold on;
v1=sum(pc*sucess)/30;
disp(['SIR: ' num2str(v1)]);

r1=sprintf('%.4f', v1);
s1=['SIR: ' r1];

lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =25;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','20','40','60','80','100'));
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
num=14;
[N,edges] = histcounts(result(1:14,1),err);
sucess=cumsum(N)./num;
plot(err(2:end), sucess,'-k','linewidth',4); hold on;
v1=sum(pc*sucess)/30;
disp(['SIR: ' num2str(v1)]);


r1=sprintf('%.4f', v1);
s1=['SIR: ' r1];

lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =25;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','20','40','60','80','100'));
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
num=49;
[N,edges] = histcounts(result(15:63,1),err);
sucess=cumsum(N)./num;
plot(err(2:end), sucess,'-k','linewidth',4); hold on;
v1=sum(pc*sucess)/30;
disp(['SIR: ' num2str(v1)]);

r1=sprintf('%.4f', v1);
s1=['SIR: ' r1];

lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =25;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','20','40','60','80','100'));
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

fig4=figure;
num=71;
[N,edges] = histcounts(result(64:end,1),err);
sucess=cumsum(N)./num;
plot(err(2:end), sucess,'-k','linewidth',4); hold on;
v1=sum(pc*sucess)/30;
disp(['SIR: ' num2str(v1)]);



r1=sprintf('%.4f', v1);
s1=['SIR: ' r1];

lgd=legend(s1,'Orientation','vertical','Location','south');
legend('boxoff');
lgd.FontSize =25;
set(gca, 'FontSize', 18,'fontweight','bold');
set(gca,'YTickLabel',str2mat('0','20','40','60','80','100'));
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