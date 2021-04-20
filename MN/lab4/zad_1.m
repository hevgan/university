clear 
clc
Index = 175854;
N0 = mod(Index,10);
N1 = mod(N0-1,4)+1; %N1 = 4
%ex1
params = [1,60000,10^-3];

[bisec_xvect,   bisec_xdif,     bisec_fx,   bisec_it_cnt]   = bisectionMethod(params,@function1_1);
[secant_xvect2, secant_xdif2,   secant_fx2, secant_it_cnt2] = secantMethod(params,@function1_1);

%fprintf("bisectionMethod %d iterations\n", bisec_it_cnt);
%fprintf("secantMethod %d iterations\n", secant_it_cnt2);
fprintf("max parameter count ≈ %f \n", (bisec_xvect(end)));
plot(bisec_xdif);
exportgraphics(gcf, 'plots\1.png')
plot(secant_xdif2);
exportgraphics(gcf, 'plots\2.png')

plot(bisec_fx);
exportgraphics(gcf, 'plots\3.png')

plot(secant_fx2);
exportgraphics(gcf, 'plots\4.png')

%ex2
params = [1,50,10^-12];

%rename the variables
[a,b,c,d] =  bisectionMethod(params,@function1_2);
[e,f,g,h] =  secantMethod(params,@function1_2);
%fprintf("bisectionMethod %d iterations\n", d);
%fprintf("secantMethod %d iterations\n", h);
fprintf("angular frequency ≈ %f[rad/s] \n", (a(end)));


plot(b);
exportgraphics(gcf, 'plots\5.png')

plot(f);
exportgraphics(gcf, 'plots\6.png')

plot(c);
exportgraphics(gcf, 'plots\7.png')
plot(g);
exportgraphics(gcf, 'plots\8.png')



%ex3
params = [0,50,10^-12];

[i,j,k,l] =  bisectionMethod(params,@function1_3);
[m,n,o,p] =  secantMethod(params,@function1_3);
%fprintf("bisectionMethod %d iterations\n", l);
%fprintf("secantMethod %d iterations\n", p);
fprintf("time to reach 750m/s ≈ %f[s] \n", (i(end)));




plot(j);
exportgraphics(gcf, 'plots\9.png')

exportgraphics(gcf, 'plots\10.png')
plot(n);

exportgraphics(gcf, 'plots\11.png')
plot(k);
exportgraphics(gcf, 'plots\12.png')
plot(o);



function result=function1_1(params)
    
    treshold = 5000;
    N = params(1);
    result = (N^1.43+N^1.14)/1000 -treshold;

end

function result=function1_2(params)

    expected_result = 75;
    omega = params(1);
    R = 725;
    C = 8*10^-5;
    L = 2;
    denominator = ((1/R^2)+(omega*C - 1/(omega*L))^2)^(1/2);
    result =  1/denominator-expected_result;

end

function result=function1_3(params)
    
    g = 3.7;
    v = 750;
    m0 = 150000;
    q = 2700;
    u = 2000;
    t = params(1);
    ins_log = m0/(m0-q*t);
    result = u*log(ins_log)-g*t-v;

end


function [xvect,xdif,fx,it_cnt]=bisectionMethod(params,func)
    l = params(1);
    r = params(2);
    eps = params(3);
    xvect = [];
    xdif = [];
    fx = [];
    it_cnt = 0; 
    
    while(true)
        it_cnt = it_cnt + 1;
        c = (l + r) /2;
        xvect = [xvect; c];
        fx(it_cnt) = feval(func,c);
        if length(xvect)>1
            xdif = [xdif; abs(xvect(end)-xvect(end-1))];
        end 
        if(abs(feval(func,c))<eps || abs(l-r)<eps)
            result = c;
            break;
        elseif (feval(func,l)*feval(func,c) < 0)
            r = c;
        else
            l = c;
        end
    end
    
end

function [xvect,xdif,fx,it_cnt]=secantMethod(params,func)
    l = params(1);
    r = params(2);
    eps = params(3);
    xvect = [l;r];
    fx = [feval(func,l); feval(func,r)];
    xdif = [];
    it_cnt = 0; 
    
    while (true)
        it_cnt = it_cnt+1;
        c = xvect(end) - (fx(end)*(xvect(end)-xvect(end-1))) / (fx(end)-fx(end-1));    
        xvect = [xvect ; c];
        if length(xvect) > 1
            xdif = [xdif; abs(xvect(end)-xvect(end-1))];
        end
        fx = [fx; feval(func, c)];
        if(abs(feval(func,c))<eps || abs(l-r)<eps)
            break;
        end
    end
    
end

%legend
%• xvect - wektor kolejnych wartości przybliżonego rozwiązania,
%• xdif - wektor różnić pomiędzy kolejnymi wartościami przybliżonego rozwiązania,
%np. xdif(1) = abs(xvect(2)-xvect(1));
%• fx - wektor wartości funkcji dla kolejnych elementów wektora xvect,
%• it_cnt - liczba iteracji wykonanych przy poszukiwaniu miejsca zerowego.