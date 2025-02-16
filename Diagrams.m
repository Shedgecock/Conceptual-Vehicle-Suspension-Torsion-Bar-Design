function [f1, f2] = Diagrams(x,sf,bm)
close all
clc
global Name nc nd nm Cload Dload Mload Xload Cloc Dloc Mloc Xtick YtickSF ....
       YtickBM PSF PBM DeciPlace TypeF TypeM TypeD EqRange ForceUnit LengthUnit

%% Display Information Processing
Loads = [];
for m = 1:numel(Cload)
    Loads = [Loads, Cload{m}];
end

for m = 1:numel(Dload)
    Loads = [Loads,Dload{m}];
end

% Factors needed for proper units so Matlab axis is not adjusted after creation
Xfactor     = 10^floor(log10(max(abs(x))));
SFfactor    = 10^floor(log10(max(abs(sf))));
BMfactor    = 10^floor(log10(max(abs(bm))));

% Tick Points and Values
Xtick   = unique(Round(Xtick,DeciPlace));
YtickSF = unique(Round(YtickSF,DeciPlace));
YtickBM = unique(Round(YtickBM,DeciPlace));
XTICK   = {};
YTICKSF = {};
YTICKBM = {};
XLOAD   = {};
format  = ['%.', num2str(DeciPlace), 'f'];
for n = 1:numel(Xtick)
    XTICK{n} = num2str(Xtick(n)/Xfactor, format);
end

for n = 1:numel(Xload)
    XLOAD{n} = num2str(Xload(n)/Xfactor, format);
end

for n = 1:numel(YtickSF)
    YTICKSF{n} = num2str(YtickSF(n)/SFfactor,format);
end

for n = 1:numel(YtickBM)
    YTICKBM{n} = num2str(YtickBM(n)/BMfactor,format);
end


%% Creating Freebody Diagram and Equation Figure
h1 = figure(Color = 'w');
set(h1,'units','normalized','outerposition',[0.01 0.05 0.647 0.95])
ax2 = axes('Position',[0.02,0.520,0.96,0.450],'Visible','off');
ax3 = axes('Position',[0.02,0.020,0.96,0.480],'Visible','off');
axes(ax2)
fill(5*[0,0,1,1],0.05*[-1,1,1,-1],'b','LineWidth',1.5, 'FaceAlpha', 0.5)
axis([-0.5, 5.5, -1, 1]); axis equal; hold on
PlotHandles = []; PlotNames   = {};
Arrowhead = [0.05, 0.1];
% Concentrated Forces
nca = 0; ncr = 0;
for n   = 1:nc
    xl  = Cloc{n}*5/x(end);
    yl = sign(-Cload{n})*[0.6, 0.05];
    text(xl,1.1*yl(1), num2str(abs(Cload{n}),'%.2f') + ForceUnit, 'FontWeight','bold', 'HorizontalAlignment','center', 'interpreter','latex')
    
    if TypeF(n) == 'a'
        if (nca == 0)
            nca = 1;
            hca = DrawArrow(xl,yl, Arrowhead,'linewidth', 2,'color','k');
            PlotHandles = [PlotHandles; hca]; PlotNames = [PlotNames;{'Applied Concentrated Force'}];
        else
            DrawArrow(xl,yl,Arrowhead,'linewidth',2,'color','k');
        end
    else
        if (ncr == 0)
            ncr = 1;
            hcr = DrawArrow(xl,yl,Arrowhead,'linewidth',2,'color','k','linestyle','-.');
            PlotHandles = [PlotHandles; hcr];  PlotNames = [PlotNames;{'Reacting Concentrated Force'}];
        else
            DrawArrow(xl,yl,Arrowhead,'linewidth',2,'color','k','linestyle','-.');
        end
    end
end

% Distributed Forces
nda = 0; ndr = 0;
for n  = 1:nd
    xl     = Dloc{n}*5/x(end);
    num    = ceil((xl(end) - xl(1))/0.13);
    xdist  = linspace(xl(1),xl(end),num);
    ps     = polyfit(xl,Dload{n}*0.3/max(abs(Dload{n})),numel(xl)-1);
    ydist1 = polyval(ps,xdist); 
    ydist2 = 0.05*sign(-ydist1);
    ydist1 = -ydist1 + ydist2;
    ydist = [ydist1; ydist2];
    text(xdist(1),1.1*ydist1(1), num2str(abs(Dload{n}(1)),'%.2f') + ForceUnit + "/" + LengthUnit ,'FontWeight','bold', 'HorizontalAlignment','center', 'interpreter','latex')
    text(xdist(end),1.1*ydist1(end), num2str(abs(Dload{n}(end)),'%.2f') + ForceUnit + "/" + LengthUnit ,'FontWeight','bold', 'HorizontalAlignment','center', 'interpreter','latex')
     
    if TypeD(n) == 'a'
        for m = 1:num
            if (nda == 0)
                nda = 1;
                hda = DrawArrow(xdist(m), ydist(:,m),Arrowhead,'linewidth',1.5,'color','m');
                PlotHandles = [PlotHandles; hda];  PlotNames = [PlotNames;{'Applied Distributed Force'}];
            else
                DrawArrow(xdist(m),ydist(:,m),Arrowhead,'linewidth',1.5,'color','m');
            end
        end
    else
        for m = 1:num
            if (ndr == 0)
                ndr = 1;
                hdr = DrawArrow(xdist(m),ydist(:,m),Arrowhead,'linewidth',1.5,'color','m','LineStyle','-.');
                PlotHandles = [PlotHandles; hdr];  PlotNames = [PlotNames;{'Reacting Distributed Force'}];
            else
                DrawArrow(xdist(m),ydist(:,m),Arrowhead, 'linewidth',1.5,'color','m','LineStyle','-.');
            end
        end
    end
    plot(xdist,ydist1,'m','linewidth',1.5)
end

% Moments
nma = 0; nmr = 0;
for n = 1:nm
    radius = 0.2;
    t      = sign(Mload{n})*[-3*pi/4,3*pi/4];
    t1     = t(1);
    t2     = t(2);
    text(Mloc{n}*5/x(end),0.3*sign(Mload{n}), num2str(abs(Mload{n}),'%.2f') + ForceUnit + "-" + LengthUnit, 'FontWeight','bold', 'HorizontalAlignment','center', 'interpreter','latex')
    
    if TypeM(n) == 'a'
        if(nma == 0)
            nma = 1;
            hma = MomentArrow(radius,t1,t2,[Mloc{n}*5/x(end),0],'r', 2);
            PlotHandles = [PlotHandles; hma];  PlotNames = [PlotNames;{'Applied Torque'}];
        else
            MomentArrow(radius,t1,t2,[Mloc{n}*5/x(end),0],'r', 2);
        end
        plot(Mloc{n}*5/x(end),0,'or','markersize',5,'markerfacecolor','r')
    else
        if(nmr == 0)
            nmr = 1;
            MomentArrow(radius,t1,t2,[Mloc{n}*5/x(end),0],'-.r', 2);
            hmr = MomentArrow(radius,t1,t2,[Mloc{n}*5/x(end),0],'-.r', 2);
            PlotHandles = [PlotHandles; hmr];  PlotNames = [PlotNames;{'Reacting Torque'}];
        else
            MomentArrow(radius,t1,t2,[Mloc{n}*5/x(end),0],'-.r', 2);
        end
        plot(Mloc{n}*5/x(end),0,'ok','markersize',15,'markerfacecolor','r')
    end
end
title('$Free~Body~Diagram~with~Reactions$', 'interpreter','latex')
Xload = unique(Xload);
ax2.YTick = []; ax2.XTick = Xload*5/x(end);
ax2.XTickLabel = Xload; ax2.TickLabelInterpreter = 'Latex';
xlabel("$" + LengthUnit + "$", 'Interpreter','latex');
plot(ax2, [Xload; Xload]*5/x(end),[0;-1]*ones(size(Xload)),...
                    'LineStyle','--', 'Color','k');
axis([-0.5, 5.5, -1, 1]); hold off; 
legend(PlotHandles,PlotNames, 'FontSize',10,'interpreter', 'latex')


% Equations
Range = {'$Range$'};
Equa1 = {'$ Equations~of~Shear~Force: $'};
Equa2 = {'$ Equations~of~Bending~Moment: $'};

if numel(Xtick) > (numel(PSF)  + 1)
    Rangex = max(Xtick) - min(Xtick);
    dx = Rangex/50;
    ind = 0;
    for i = 1:numel(Xtick)
        if(any(abs(Xtick(i)-Xload)<dx))
            ind = i; TobeRemoved = 1;
            break;
        end
    end 
    while(TobeRemoved)
        Xtick(ind) = []; 
        TobeRemoved = 0;
        for i = 1:numel(Xtick)
            if(any(abs(Xtick(i)-Xload)<dx))
                ind = i; TobeRemoved = 1;
                break; 
            end
        end 
    end
end
Xtick = union(Xtick, Xload);

for n = 2:numel(EqRange)
    range = ['$',num2str(EqRange(n - 1)), '~to~',num2str(EqRange(n)),'$'];
    equa1 = ['$',makeequation(PSF{n - 1}),'$'];
    equa2 = ['$',makeequation(PBM{n - 1}),'$'];
    Range = [Range;{range}]; Equa1 = [Equa1;{equa1}]; Equa2 = [Equa2;{equa2}]; 
end
axes(ax3)
text(0.02, 0.90, Range, 'VerticalAlignment', 'cap', 'FontSize', 12, 'interpreter', 'latex')
text(0.15, 0.90, Equa1, 'VerticalAlignment', 'cap', 'FontSize', 12, 'interpreter', 'latex')
text(0.50, 0.90, Equa2, 'VerticalAlignment', 'cap', 'FontSize', 12, 'interpreter', 'latex')
f1 = getframe(gcf);
%%
h2 = figure(Color = 'w');
set(h2,'units','normalized','outerposition',[0.65 0.05 0.35 0.95]);
y = zeros(size(x)); % To be used for fill
Xmin = -0.05*x(end); Xmax = 1.05*x(end);
% Shear Force
subplot(2,1,1);
fill([x;flipud(x)],[y;flipud(sf)],'b','facealpha',0.15,'edgecolor','none');hold on
plot(x,sf,'b','Linewidth',2);
offset = 0.01 + 0.05*(max(sf) - min(sf));
Vmin = min(sf) - offset; Vmax = max(sf) + offset;
axis([Xmin, Xmax, Vmin, Vmax]);
plot([Xmin, Xmax], [0,0], 'k'); hold off
% Latex Formatting
ax4 = gca;
ax4.YTick = unique(round(YtickSF, 3, 'significant'));
ax4.XTick= unique(round(Xtick, 3, 'significant'));
ax4.TickLabelInterpreter = 'latex';

ylabel("$V(" + ForceUnit + ")$", 'Interpreter','latex');
xlabel("$" + LengthUnit + "$", 'Interpreter','latex');
title('$Shear~Force~Diagram$','FontSize',12, 'interpreter','latex')

%%
subplot(2,1,2);
fill([x;flipud(x)],[y;flipud(bm)],'b','facealpha',0.15,'edgecolor','none');hold on
plot(x,bm,'b','Linewidth',2);
offset = 0.01 + 0.05*(max(bm) - min(bm));
Mmin = min(bm) - offset; Mmax = max(bm) + offset;
axis([Xmin, Xmax, Mmin, Mmax]);
plot([Xmin, Xmax], [0,0], 'k'); hold off
% Latex Formatting
ax5 = gca;
ax5.YTick = unique(round(YtickBM, 3, 'significant'));
ax5.XTick = unique(round(Xtick, 3, 'significant'));
ax5.TickLabelInterpreter = 'latex';

ylabel("$M(" + ForceUnit + "-" + LengthUnit + ")$", 'Interpreter','latex');
xlabel("$" + LengthUnit + "$", 'Interpreter','latex');
title('$Bending~Moment~Diagram$','FontSize',12, 'interpreter','latex')

%% annotation
[xa1, ya1] = ConvertCoordinates(ax4, Xtick,repmat(Vmax,size(Xtick)));
[xb1, yb1] = ConvertCoordinates(ax4, zeros(size(YtickSF)),YtickSF);
[xc1, yc1] = ConvertCoordinates(ax4, repmat(x(end),size(YtickSF)),YtickSF);

[xa2, ya2] = ConvertCoordinates(ax5, Xtick,repmat(Mmin,size(Xtick)));
[xb2, yb2] = ConvertCoordinates(ax5, zeros(size(YtickBM)),YtickBM);
[xc2, yc2] = ConvertCoordinates(ax5, repmat(x(end),size(YtickBM)),YtickBM);

for n = 1:numel(Xtick)
    h4 = annotation('line',[xa1(n) xa2(n)],[ya1(n) ya2(n)],'Tag' , 'connect1');
    set(h4,'LineStyle','--'); set(h4,'Color','b'); 
end

for n = 1:numel(YtickSF)
    h4 = annotation('line',[xb1(n) xc1(n)],[yb1(n) yc1(n)],'Tag' , 'connect1');
    set(h4,'LineStyle','--'); set(h4,'Color','b'); 
end

for n = 1:numel(YtickBM)
    h4 = annotation('line',[xb2(n) xc2(n)],[yb2(n) yc2(n)],'Tag' , 'connect1');
    set(h4,'LineStyle','--'); set(h4,'Color','b'); 
end
f2 = getframe(gcf);

function [Xt,Yt, Xr, Yr] = makesupport1(Node, t, n)
t    = 0.7*t; y = 4*t; x = t*cos(pi/6)*5.5/1.5;
t1   = linspace(5*pi/6, pi/6, 50); angle = n*pi/2;
XYpt = [t*cos(t1), x, -x; t*sin(t1),-y,-y];
XYpr = [1.2*x, 1.2*x, -1.2*x, -1.2*x; -y, -1.2*y, -1.2*y, -y];
XYt  = [cos(angle), -sin(angle); sin(angle), cos(angle)]*XYpt;
XYr  = [cos(angle), -sin(angle); sin(angle), cos(angle)]*XYpr;
Xt   = Node(1) + XYt(1,:);    Yt     = Node(2) + XYt(2,:);
Xr   = Node(1) + XYr(1,:);    Yr     = Node(2) + XYr(2,:);

function [Xt,Yt, Xr, Yr, Xl, Yl, Xc, Yc] = makesupport2(Node, t, n)
t    = 0.7*t; y = 3*t; x = t*cos(pi/6)*4.5/1.5;
t1   = linspace(5*pi/6, pi/6, 50); angle = n*pi/2;
XYpt = [t*cos(t1), x, -x; t*sin(t1),-y,-y];
y2   = 4*t; x2 = t*cos(pi/6)*5.5/1.5;
XYpl = [x2, -x2; -y, -y];
XYpr = [1.2*x2, 1.2*x2, -1.2*x2, -1.2*x2; -y2, -1.2*y2, -1.2*y2, -y2];
XYt  = [cos(angle), -sin(angle); sin(angle), cos(angle)]*XYpt;
XYr  = [cos(angle), -sin(angle); sin(angle), cos(angle)]*XYpr;
XYl  = [cos(angle), -sin(angle); sin(angle), cos(angle)]*XYpl;
Xt   = Node(1) + XYt(1,:);    Yt     = Node(2) + XYt(2,:);
Xr   = Node(1) + XYr(1,:);    Yr     = Node(2) + XYr(2,:);
Xl   = Node(1) + XYl(1,:);    Yl     = Node(2) + XYl(2,:);
Xc   = []; Yc = [];
for n = 1:6
    xc = (-3.5 + n)*t + 0.5*t*cos(linspace(0,2*pi,100));
    yc = -3.5*t + 0.5*t*sin(linspace(0,2*pi,100));
    XYpc = [xc;yc];
    XYc  = [cos(angle), -sin(angle); sin(angle), cos(angle)]*XYpc;
    Xc   = [Xc; Node(1) + XYc(1,:)] ;
    Yc   = [Yc; Node(2) + XYc(2,:)] ;
end

function equation = makeequation(p)
    equation = [];
    for m = 1:numel(p)
        vv = p(m); power = numel(p) - m;
        avv = abs(vv);
        vvstr = [];
        if (avv ~= 0)
            if (avv == 1) 
                if(isempty(equation))
                    if(vv < 0)
                        if power == 0
                            vvstr = ' - 1';
                        else
                            vvstr = ' - ';
                        end
                    else
                        if power == 0
                            vvstr = ' 1';
                        end
                    end
                else
                    if(vv < 0)
                        vvstr = ' - ';
                    else
                        vvstr = ' + ';
                    end
                end
            else
                if(isempty(equation))
                    vvstr = num2str(vv);
                else
                    if(vv < 0)
                        vvstr = num2str(vv);
                    else
                        vvstr = [' + ',num2str(vv)];
                    end
                end
            end
            if (power > 0)
                if (power > 1) vvstr = [vvstr,'x^',num2str(power)];
                else vvstr = [vvstr,'x'];
                end
            end
        end
        equation = [equation, vvstr];
    end
    if(isempty(equation))
        equation = '0';
    end