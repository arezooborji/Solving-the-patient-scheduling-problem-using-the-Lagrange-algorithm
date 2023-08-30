function [Cost] = CostFCN(Sol,Param)
    
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
    
    s_sc1_nd = Sol.s_sc1_nd;
    s_sc1_dr = Sol.s_sc1_dr;
    s_sc2 = Sol.s_sc2;
    s_sc3 = Sol.s_sc3;
    s_sc4 = Sol.s_sc4;
    s_sc5 = Sol.s_sc5;
    s_sc6 = Sol.s_sc6;
    s_sc7 = Sol.s_sc7;
    s_sc8 = Sol.s_sc8;
    t = Sol.t;
    x = Sol.x;
    y = Sol.y;
    
    S1 = zeros(numel(p),numel(n),numel(r));
    S2 = zeros(numel(p),numel(r),numel(n));
    S3 = zeros(numel(p),numel(r),numel(n),numel(k));
    S4 = zeros(numel(p),numel(r),numel(n));
    S5 = zeros(numel(p),numel(n));
    S6 = zeros(numel(p),numel(r),numel(n));
    S7 = zeros(numel(p),numel(r),numel(n));
    S8 = zeros(numel(p),numel(r),numel(n),numel(k));
    S9 = zeros(numel(p),numel(r),numel(n));
    s_sc1_nd11 = zeros(numel(r),numel(n));
    S11 = zeros(numel(r),numel(n));
    
    for pp = 1:numel(p)
        s_sc1_nd11(:,:) = zeros(numel(r),numel(n));
        S11(:,:) = zeros(numel(r),numel(n));
        s_sc1_nd11(:,:) = s_sc1_nd(pp,:,:);
        S11(:,:) = pen_sc1 * (s_sc1_nd11(:,:) + s_sc1_dr(:,:));
        S1(pp,:,:) = S11(:,:); 
    end
    
    S2 = pen_sc2 .* s_sc2;
    S3 = pen_sc3 .* s_sc3;
    S4 = pen_sc4 .* s_sc4;
    S5 = pen_sc5 .* s_sc5;
    S6 = pen_sc6 .* s_sc6;
    S7 = pen_sc7 .* s_sc7;
    S8 = pen_sc8 .* s_sc8;
    S9 = pen_sc9 .* t ;
    
    S1 = sum(S2,[1 2 3 4]);
    S2 = sum(S2,[1 2 3 4]);
    S3 = sum(S3,[1 2 3 4]);
    S4 = sum(S4,[1 2 3 4]);
    S5 = sum(S5,[1 2 3 4]);
    S6 = sum(S6,[1 2 3 4]);
    S7 = sum(S7,[1 2 3 4]);
    S8 = sum(S8,[1 2 3 4]);
    S9 = sum(S9,[1 2 3 4]);
    
    Cost = S1 + S2 + S3 +S4 +S5 +S6 + S7 +S8 + S9;
    
end

