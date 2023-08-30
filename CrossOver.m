function [x3,x4] = CrossOver(Param,x1,x2)
    
    p = Param.p;
    r = Param.r;
    n = Param.n;
    
    A1 = zeros(numel(p),numel(r));
    A2 = zeros(numel(p),numel(r));
    A3 = zeros(numel(p),numel(r));
    A4 = zeros(numel(p),numel(r));
    type = randi([0 1]);
    x3 = zeros(numel(p),numel(r),numel(n));
    x4 = zeros(numel(p),numel(r),numel(n));    
    
    if type == 1
        t = randi([1 numel(p)]);    
        for nn = 1:numel(n)
           A1 = x1(:,:,nn);
           A2 = x2(:,:,nn);
           A3 = [A1(1:t,:);A2(t+1:end,:)];
           A4 = [A2(1:t,:);A1(t+1:end,:)];
           x3(:,:,nn) = A3;
           x4(:,:,nn) = A4;
           
        end
    else
        t = randi([1 numel(r)]);
        for nn = 1:numel(n)
           A1 = x1(:,:,nn);
           A2 = x2(:,:,nn);
           A3 = [A1(:,1:t) A2(:,t+1:end)];
           A4 = [A2(:,1:t) A1(:,t+1:end)];
           x3(:,:,nn) = A3;
           x4(:,:,nn) = A4;
        end
    end
    

end

