clear;clc;
%%
Generate_parameter

P_F_set = db2pow([0:2:18])/10^3;
N_set = [600] + param.N_act;

len_x = length(P_F_set); len_y = length(N_set); 

%% Different Scheme
scheme = 7;
for ik = 1:scheme
    eval(['Rate_total',num2str(ik),'=','zeros(len_x,len_y)',';']); 
    eval(['x_set',num2str(ik),'=','zeros(len_x,len_y)',';']); 
end

%% Optimization
for iy = 1:len_y   
     param.N = N_set(iy); 
for ix = 1:len_x
   
     param.P_F = P_F_set(ix); 
    
     [Rate_total1(ix,iy),x_set1(ix,iy),eta1(ix,iy)] = Deployment_TPAR_b(param);       
     [Rate_total2(ix,iy),x_set2(ix,iy),eta2(ix,iy)] = Deployment_TAPR_a(param);
     [Rate_total3(ix,iy)] = -ComputingRate_TPAR_b(param,x_BU/2);
     [Rate_total4(ix,iy)] = -ComputingRate_TPAR_b(param,x_BU);
     [Rate_total5(ix,iy)] = -ComputingRate_TAPR_a(param,x_BU/2);
     [Rate_total6(ix,iy)] = -ComputingRate_TAPR_a(param,0);
     [Rate_total7(ix,iy),x_set7(ix,iy)] = Deployment_Double_passive(param);    
     
    
     [Rate_total8(ix,iy),x_set8(ix,iy),x_bound8(ix,iy)] = Deployment_Suboptimal_TPAR_b(param);
     [Rate_total9(ix,iy),x_set9(ix,iy),x_bound9(ix,iy)] = Deployment_Suboptimal_TAPR_a(param);
       
end
end



%% plot
flog1 =0;
if flog1   
    line_marker = {'b-o','r--','b-V','r-.';'g-o','r-.','g-V','k-.'};
    close;
    P_F_set1 = pow2db(P_F_set*10^3);
    iy = 1;
    
    plot(P_F_set1, x_set1(:,iy),line_marker{1,1},'LineWidth',2,'MarkerSize',8); hold on
    plot(P_F_set1, x_set8(:,iy),line_marker{1,2},'LineWidth',2,'MarkerSize',10); hold on
    plot(P_F_set1, x_set2(:,iy),line_marker{1,3},'LineWidth',2,'MarkerSize',8); hold on
    plot(P_F_set1, x_set9(:,iy),line_marker{1,4},'LineWidth',2,'MarkerSize',10); hold on
    
    grid on;
    set(gca,'GridLineStyle','--','GridColor','k', 'GridAlpha',0.2);  
    h11 = legend('b)TPAR scheme: optimal','b)TPAR scheme: suboptimal',...
    'a)TAPR scheme: optimal','a)TAPR scheme: suboptimal','interpreter','latex');
    set(h11,'FontSize',15);
    xlim([P_F_set1(1) P_F_set1(end)])
    xticks(P_F_set1)
    xlabel('Amplification power of AIRS, $P_{F}$ (dBm)','interpreter','latex','FontSize',15);
    ylabel('Tx-AIRS horizontal distance (m)','interpreter','latex','FontSize',15);
    
    saveas(gcf,'power-distance.fig');
%%    
    close;
    P_F_set1 = pow2db(P_F_set*10^3);
    iiy = 1;
    
    plot(P_F_set1, Rate_total2(:,iiy),'r-o','LineWidth',2,'MarkerSize',8); hold on
    plot(P_F_set1, Rate_total1(:,iiy),'b-^','LineWidth',2,'MarkerSize',8); hold on
  
    plot(P_F_set1, Rate_total5(:,iiy),'g--o','LineWidth',2,'MarkerSize',8); hold on
    plot(P_F_set1, Rate_total6(:,iiy),'g-.s','LineWidth',2,'MarkerSize',8); hold on
    
    plot(P_F_set1, Rate_total3(:,iiy),'k--s','LineWidth',2,'MarkerSize',8); hold on
    plot(P_F_set1, Rate_total4(:,iiy),'k-.^','LineWidth',2,'MarkerSize',8); hold on
    
    
    plot(P_F_set1, Rate_total7(:,iiy),'k-.','LineWidth',2,'MarkerSize',8); hold on
    grid on;
    set(gca,'GridLineStyle','--','GridColor','k', 'GridAlpha',0.2);
    h11 = legend('a) TAPR scheme: Optimal','b) TPAR scheme: Optimal',...
       'a) TAPR scheme: Middle','a) TAPR scheme: Tx',...
       'b) TPAR scheme: Middle','b) TPAR scheme: Rx',...
   'Double PIRSs','interpreter','latex');
    set(h11,'FontSize',13);
    xlim([P_F_set1(1) P_F_set1(end)])
    xticks(P_F_set1)
    yticks([6:2:18])
    
    xlabel('Amplification power of AIRS, $P_{F}$ (dBm)','interpreter','latex','FontSize',15);
    ylabel('Achievable rate (bps/Hz)','interpreter','latex','FontSize',15);
    
    saveas(gcf,'P_F-rate.fig');
   
    
  end
