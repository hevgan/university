clear 
clc

%ex1
eps = 10^-3;
l = 1;
r = 60000;

[bisec_xvect,   bisec_xdif,     bisec_fx,   bisec_it_cnt]   = bisectionMethod(l,r,eps,@function1_1);
[secant_xvect2, secant_xdif2,   secant_fx2, secant_it_cnt2] = secantMethod(l,r,eps,@function1_1);

fprintf("bisectionMethod %d iterations\n", bisec_it_cnt);
fprintf("secantMethod %d iterations\n", secant_it_cnt2);

%ex2
expected_result = 75;
R = 725;
C = 8*10^-5;
L = 2;
l = 0;
r = 50;
eps = 10^-12;

%[a,b,c,d] =  bisectionMethod(l,r,eps,@function1_2);
%[e,f,g,h] =  secantMethod(l,r,eps,@function1_2);

function result=function1_1(N)
    
    result = (N^1.43+N^1.14)/1000 -5000;

end

function result=function1_2(omega, R, C, L )
    
    denominator = ((1/R^2)+(omega*C - 1/(omega*L))^2)^1/2;
    result =  1/denominator-725;

end

function [xvect,xdif,fx,it_cnt]=bisectionMethod(l,r,eps,func)

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

function [xvect,xdif,fx,it_cnt]=secantMethod(l,r,eps,func)

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