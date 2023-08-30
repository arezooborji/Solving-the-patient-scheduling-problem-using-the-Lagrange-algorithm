function [x2] = Mutate(Param,x1)
    
    p = Param.p;
    r = Param.r;
    n = Param.n;
    rev = numel(r):-1:1;
    A1 = zeros(numel(p),numel(r));
    A2 = zeros(numel(p),numel(r));
    A1p = zeros(1,numel(r));
    A2p = zeros(1,numel(r));
    x2 = zeros(numel(p),numel(r),numel(n));
    
    type = randi([0 1]);
    
    if type == 0
        for nn = 1:numel(n)
            A1 = x1(:,:,nn);
            A2 = A1(:,rev);
            x2(:,:,nn) = A2(:,:);
        end
    else
        for nn = 1:numel(n)
            pstar = randi([1 numel(p)]);
            A1p(:) = x1(pstar,:,nn);
            A2p(:) = A1p(rev);
            x2(pstar,:,nn) = A2p(:);
        end
    end
    
end

