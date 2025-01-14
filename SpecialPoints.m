function SpecialPoints(x,ysf,ybm)
global Xload Xtick YtickSF YtickBM PSF PBM DistPoly DeciPlace EqRange
Xtick = unique(Xtick);
YtickSF = unique(round(YtickSF, 3, 'significant'));
YtickBM = unique(round(YtickBM, 3, 'significant'));
YtickSF = [YtickSF; Interpolate(x,ysf,Xload)];
YtickBM = [YtickBM; Interpolate(x,ybm,Xload)];

N    = numel(x);
sysf = sign(ysf);
for n = 2:N
    diffsysf = sysf(n) - sysf(n - 1); 
    cond1 = diffsysf == 2 || diffsysf == -2;
    cond2 = sysf(n) == 0 && sysf(n - 1) ~= 0 ;
    if(cond1 || cond2)
        if( cond1 && ~cond2)
            ysfin = 0; 
            xin = interp1(ysf(n - 1:n), x(n - 1:n), ysfin);
            ybmin = interp1(ysf(n - 1:n), ybm(n - 1:n), ysfin);
        elseif (cond2 && ~cond1)
            ysfin = 0; xin = x(n); ybmin = ybm(n);
        end
        if(~ismember(xin,Xtick)) Xtick = [Xtick; xin]; end
        if(~ismember(ysfin,YtickSF)) YtickSF = [YtickSF; ysfin]; end
        if(~ismember(ybmin,YtickBM)) YtickBM = [YtickBM; ybmin]; end
    end
end
sybm = sign(ybm);
for n = 2:N
    diffsybm = sybm(n) - sybm(n - 1); 
    cond1 = diffsybm == 2 || diffsybm == -2;
    cond2 = sybm(n) == 0 && sybm(n - 1) ~= 0 ;
    if(cond1 || cond2)
        if( cond1 && ~cond2)
            ybmin = 0; 
            xin = interp1(ybm(n - 1:n), x(n - 1:n), ybmin);
            ysfin = interp1(ybm(n - 1:n), ysf(n - 1:n), ybmin);
        elseif (cond2 && ~cond1)
            ybmin = 0; xin = x(n); ysfin = ysf(n);
        end
        if(~ismember(xin,Xtick)) Xtick = [Xtick; xin]; end
        if(~ismember(ysfin,YtickSF)) YtickSF = [YtickSF; ysfin]; end
        if(~ismember(ybmin,YtickBM)) YtickBM = [YtickBM; ybmin]; end
    end
end
Xtick = Round(union(Xload,Xtick),DeciPlace); YtickSF = unique(Round([YtickSF; ysf(end)],DeciPlace)); 
YtickBM = unique(Round([YtickBM; ybm(end)],DeciPlace));

PSF  = {};
PBM  = {};
for i = 2:numel(EqRange)
    xm = EqRange(i-1);
    xp = EqRange(i);
    I = 1:numel(x); I = I(x > xm); 
    X = x(I); I = I(X < xp); 
    if(~isempty(I))
        X = x(I); Ysf = ysf(I); Ybm = ybm(I);
        sfdegree = -1;
        n = Nboxed(0.5*(xm + xp));
        if ~isempty(n)
            sfdegree = numel(DistPoly{n}) - 1;
        end
        PSF   = [PSF,{Round(polyfit(X,Ysf,sfdegree + 1),3)}];
        PBM   = [PBM,{Round(polyfit(X,Ybm,sfdegree + 2),3)}];
    end
end

function n = Nboxed(x)
global Dloc 
n = [];
for i = 1:numel(Dloc)
    loc = Dloc{i};
    if loc(1) < x && x < loc(end)
        n = i; break;
    end
end
    
    


        
        

