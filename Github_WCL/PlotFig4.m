clear;clc;

%%
Generate_parameter

P_F_set = db2pow(2)/10^3;
D_set = 2.^[4:0.25:5.5];

len_x = length(P_F_set); len_y = length(D_set); 

%% Different Scheme
scheme = 6;
for ik = 1:scheme
    eval(['Rate_total',num2str(ik),'=','zeros(len_x,len_y)',';']); 
    eval(['x_set',num2str(ik),'=','zeros(len_x,len_y)',';']); 
end

%% Optimization
for iy = 1:len_y   
     param.x_BU = D_set(iy);
for ix = 1:len_x
     param.P_F = P_F_set(ix); 
     
     [Rate_total1(ix,iy),x_set1(ix,iy),eta1(ix,iy)] = Deployment_TAPR_a(param);
     [Rate_total2(ix,iy),x_set2(ix,iy),eta2(ix,iy)] = Deployment_TPAR_b(param);       
     [Rate_total3(ix,iy),x_set3(ix,iy)] = Deployment_Double_passive(param);     
     [Rate_total4(ix,iy),x_set4(ix,iy),eta4(ix,iy)] = Deployment_Single_Hybrid(param);    
     [Rate_total5(ix,iy),x_set5(ix,iy)] = Deployment_Single_Active(param);
     [Rate_total6(ix,iy),x_set6(ix,iy)] = Deployment_Single_passive(param);
       
end
end



%% plot
flog1 =0;
if flog1   
   
    %%    distance
    marker = {'o','diamond','*','^','pentagram'};
    lineColors = lines(7); lineColors = [lineColors;[96, 96, 96]/255;]; %% gray
    
    close;
    P_F_set1 = pow2db(P_F_set*10^3);
    ix = 1; iiy = 1:len_y; D_set1 = log2(D_set);
    
    plot(D_set1, Rate_total1(ix,iiy),'-pentagram','LineWidth',2,'MarkerSize',8); hold on
    plot(D_set1, Rate_total2(ix,iiy),'-diamond','LineWidth',2,'MarkerSize',8); hold on
    
    plot(D_set1, Rate_total3(ix,iiy),'--o','LineWidth',2,'MarkerSize',8); hold on
    plot(D_set1, Rate_total4(ix,iiy),'--s','LineWidth',2,'MarkerSize',8); hold on
    
    plot(D_set1, Rate_total5(ix,iiy),'-.^','LineWidth',2,'MarkerSize',8); hold on
    plot(D_set1, Rate_total6(ix,iiy),'-.o','LineWidth',2,'MarkerSize',8); hold on
    
    grid on;
    set(gca,'GridLineStyle','--','GridColor','k', 'GridAlpha',0.2);
    h11 = legend('a) TAPR scheme','b) TPAR scheme','Double PIRSs',...
       'Single hybrid IRS ','Single AIRS','Single PIRS','interpreter','latex');
    set(h11,'FontSize',13,'FontName','Times New Roman');
    xlim([D_set1(1) D_set1(end)]) 
    xticks(D_set1)
    ylim([0 18])
    yticks([0:2:18])
    
    xlabel('Tx-Rx distance, $\log_2(D)$','interpreter','latex','FontSize',15,'FontName','Times New Roman');
    ylabel('Achievable rate (bps/Hz)','interpreter','latex','FontSize',15,'FontName','Times New Roman');
    
    saveas(gcf,'Distance-rate.fig');
end
