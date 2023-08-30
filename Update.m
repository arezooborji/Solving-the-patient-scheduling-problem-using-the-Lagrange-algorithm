function [Sol,Cost] = Update(Param,x)
    
    Q = Param.Q;
    AD = Param.AD;
    DD = Param.DD;
    LOS = Param.LOS;
    Age = Param.Age;
    Min_Age = Param.Min_Age;
    Max_Age = Param.Max_Age;
    PRF = Param.PRF;
    RRF = Param.RRF;
    PG = Param.PG;
    RG = Param.RG;
    RRT = Param.RRT;
    PRT = Param.PRT;
    PREQ = Param.PREQ;
    SINGLE = Param.SINGLE;
    PSN = Param.PSN;
    RS = Param.RS;
    SRPref = Param.SRPref;
    PPrefRF = Param.PPrefRF;
    Adm_Plan = Param.Adm_Plan;
    RD = Param.RD;
    pr = Param.pr;
    
    p = Param.p;
    r = Param.r;
    d = Param.d;
    k = Param.k;
    g = Param.g;
    w = Param.w;
    n = Param.n;
    s = Param.s;
     
    pen_sc1 = Param.pen_sc1;
    pen_sc2 = Param.pen_sc2;
    pen_sc3 = Param.pen_sc3;
    pen_sc4 = Param.pen_sc4;
    pen_sc5 = Param.pen_sc5;
    pen_sc6 = Param.pen_sc6;
    pen_sc7 = Param.pen_sc7;
    pen_sc8 = Param.pen_sc8;
    pen_sc9 = Param.pen_sc9;
    
    % variables
    s_sc1_nd = zeros(numel(p),numel(r),numel(n));
    s_sc1_dr = zeros(numel(r),numel(n));
    s_sc2 = zeros(numel(p),numel(r),numel(n));
    UPs_sc2 = zeros(numel(p),numel(r),numel(n));
    LOs_sc2 = zeros(numel(p),numel(r),numel(n));
    UPs_sc2d = zeros(numel(p),numel(r),numel(n),numel(d));
    LOs_sc2d = zeros(numel(p),numel(r),numel(n),numel(d));
    s_sc3 = zeros(numel(p),numel(r),numel(n),numel(k));
    LOs_sc3 = zeros(numel(p),numel(r),numel(n),numel(k));
    s_sc4 = zeros(numel(p),numel(r),numel(n));
    LOs_sc4 = zeros(numel(p),numel(r),numel(n));
    LOs_sc5 = zeros(numel(p),numel(n));
    LOs_sc5w = zeros(numel(p),numel(n));
    s_sc5 = zeros(numel(p),numel(n));
    s_sc6 = zeros(numel(p),numel(r),numel(n));
    s_sc7 = zeros(numel(p),numel(r),numel(n));
    s_sc8 = zeros(numel(p),numel(r),numel(n),numel(k));
    LOs_sc6 = zeros(numel(p),numel(r),numel(n));
    LOs_sc7 = zeros(numel(p),numel(r),numel(n));
    LOs_sc8 = zeros(numel(p),numel(r),numel(n),numel(k));
    t = zeros(numel(p),numel(r),numel(n));
    LOt = zeros(numel(p),numel(r),numel(n));
    y = zeros(numel(r),numel(n));
    InFeasible1 = 0;
    InFeasible2 = 0;
    InFeasible3 = 0;
    InFeasible4 = 0;
    Penalty = 10^20;
   
    for nn = 1:numel(n) 
            for pp = 1:numel(p)
                if Adm_Plan(pp,nn) == 0 && sum(x(pp,:,nn),2) > 0
                   InFeasible1 = 1; 
                end
                
                if Adm_Plan(pp,nn) == 1 && sum(x(pp,:,nn),2) == 0
                   InFeasible2 = 1; 
                end
                
                if sum(x(pp,:,nn),2) > 1
                   InFeasible3 = 1;  
                end
            end
            
            for rr = 1:numel(r)
                if sum(x(:,rr,nn),1) > Q(rr)
                   InFeasible4 = 1;
                end
            end
    end
    
    if InFeasible1 == 0 && InFeasible2 == 0 && InFeasible3 == 0 && InFeasible4 == 0
     
    A = zeros(1,numel(p));
    
    for rr = 1:numel(r)
        for nn = 1:numel(n)
            
           A =  x(:,rr,nn); 
           c2 =  find(A>0);
           y(rr,nn) = 1;
           for pp = c2'
               if PG(pp,1) == 1
                  y(rr,nn) = 0; 
               end
               
           for dd = 1:numel(d)    
           LOs_sc2d(pp,rr,nn,dd) = (Age(pp) - Min_Age(dd)*x(pp,rr,nn))/(Min_Age(dd) - Age(pp));
           UPs_sc2d(pp,rr,nn,dd) = (Age(pp)*x(pp,rr,nn) - Max_Age(dd))/(Age(pp) - Max_Age(dd));
           end
           
           UPs_sc2(pp,rr,nn) = min(UPs_sc2d(pp,rr,nn,:),[],4);
           LOs_sc2(pp,rr,nn) = max(LOs_sc2d(pp,rr,nn,:),[],4);
           s_sc2(pp,rr,nn) = max(0, randi([LOs_sc2(pp,rr,nn) UPs_sc2(pp,rr,nn)]));
           
           for kk = 1:numel(k) 
               LOs_sc3(pp,rr,nn,kk) = PRF(pp,kk)*x(pp,rr,nn) -  RRF(rr,kk);
               s_sc3(pp,rr,nn,kk) = max(0,randi([LOs_sc3(pp,rr,nn,kk) 1])); 
               
               LOs_sc8(pp,rr,nn,kk) = PPrefRF(pp,kk)*x(pp,rr,nn) - RRF(rr,kk);
               s_sc8(pp,rr,nn,kk) = max(0,randi([max(0,LOs_sc8(pp,rr,nn,kk)) 1]));
               
           end
           
           for ww = 1:numel(w)
               LOs_sc5w(pp,rr,nn,ww) = RRT(rr,ww) * x(pp,rr,nn) - PRT(pp,ww);
           end
           
           LOs_sc5(pp,nn) = max(LOs_sc5w(pp,:,nn,:),[],[2 4]);
           s_sc5(pp,nn) = max(0,randi([LOs_sc5(pp,nn) 1]));
           
           LOs_sc4(pp,rr,nn) = PREQ(pp)*x(pp,rr,nn) -  SINGLE(rr);
           s_sc4(pp,rr,nn) = max(0,randi([LOs_sc4(pp,rr,nn) 1]));
           
           for ss = 1:numel(s)
               LOs_sc6(pp,rr,nn) = PSN(pp,ss)*x(pp,rr,nn) - RS(rr,ss); 
               s_sc6(pp,rr,nn) = max(0,randi([LOs_sc6(pp,rr,nn) 1]));
               LOs_sc7(pp,rr,nn) = SRPref(rr,ss)*x(pp,rr,nn) - 1;
               s_sc7(pp,rr,nn) = max(0,randi([LOs_sc7(pp,rr,nn) 1]));
           end
           
           if nn >= 2 && AD(pp) ~= nn
           LOt(pp,rr,nn) = x(pp,rr,nn) - x(pp,rr,nn-1);
           t(pp,rr,nn) = randi([LOt(pp,rr,nn) 1]);
           end
           
           end
           
           s_sc1_dr(rr,nn) = max(x(:,rr,nn),[],1);
           
        end
    end
    
    Sol.s_sc1_nd = s_sc1_nd;
    Sol.s_sc1_dr = s_sc1_dr;
    Sol.s_sc2 = s_sc2;
    Sol.s_sc3 = s_sc3;
    Sol.s_sc4 = s_sc4;
    Sol.s_sc5 = s_sc5;
    Sol.s_sc6 = s_sc6;
    Sol.s_sc7 = s_sc7;
    Sol.s_sc8 = s_sc8;
    Sol.t = t;
    Sol.x = x;
    Sol.y = y;
    
    Cost = CostFCN(Sol,Param);
    else
        Sol.s_sc1_nd = s_sc1_nd;
        Sol.s_sc1_dr = s_sc1_dr;
        Sol.s_sc2 = s_sc2;
        Sol.s_sc3 = s_sc3;
        Sol.s_sc4 = s_sc4;
        Sol.s_sc5 = s_sc5;
        Sol.s_sc6 = s_sc6;
        Sol.s_sc7 = s_sc7;
        Sol.s_sc8 = s_sc8;
        Sol.t = t;
        Sol.x = x;
        Sol.y = y;
        
        Cost = Penalty;
    end
    
    
    
end

