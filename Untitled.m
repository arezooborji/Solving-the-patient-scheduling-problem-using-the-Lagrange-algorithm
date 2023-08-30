clc;
clear;

Param = InputParameter();

[Sol, Cost] = InitialSolution(Param);

    p = Param.p;
    r = Param.r;
    d = Param.d;
    k = Param.k;
    g = Param.g;
    w = Param.w;
    n = Param.n;
    s = Param.s;    

Iter = 1000;
C = zeros(1,Iter);

for ii = 1:Iter
    
    [Sol1, Cost1] = InitialSolution(Param);
    x1 = Sol1.x;
    [x2] = Mutate(Param,x1);
    [Sol2, Cost2] = Update(Param,x2);
    C2(ii) = Cost2;
    
end

Best2 = min(C2,[],[1 2]);


    
    
    
    
    
    
    
    
    