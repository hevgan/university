clear 
clc
Index = 175854;
N0 = mod(Index,10);
N1 = mod(N0-1,4)+1; 

[title_approx,title_diffs,x_label,y_label,bis_suffix,sec_suffix,file_path] = nameSetup();


ex1(title_approx,title_diffs,x_label,y_label,bis_suffix,sec_suffix,file_path);
ex2(title_approx,title_diffs,x_label,y_label,bis_suffix,sec_suffix,file_path);
ex3(title_approx,title_diffs,x_label,y_label,bis_suffix,sec_suffix,file_path);




function ex1(title_approx,title_diffs,x_label,y_label,bis_suffix,sec_suffix,file_path)

params = [1,60000,10^-3];

[bis_x_vect,   bis_x_dif,     bis_fx,   bis_it_cnt] = bisectionMethod(params,@function1_1);
[sec_x_vect, sec_x_dif,   sec_fx, sec_it_cnt] = secantMethod(params,@function1_1);

fprintf("max parameter count ≈ %f \n", (bis_x_vect(end)));

shortPlot(bis_x_dif, title_diffs, bis_suffix, x_label, y_label, gcf, file_path, '1_1.png');
shortPlot(sec_x_dif, title_diffs, sec_suffix, x_label, y_label, gcf, file_path, '1_2.png');
shortPlot(bis_fx, title_approx, bis_suffix, x_label, y_label, gcf, file_path, '1_3.png');
shortPlot(sec_fx, title_approx, sec_suffix, x_label, y_label, gcf, file_path, '1_4.png');


end

function ex2 (title_approx,title_diffs,x_label,y_label,bis_suffix,sec_suffix,file_path)

params = [1,50,10^-12];

[bis_x_vect_2,   bis_x_dif_2,     bis_fx_2,   bis_it_cnt_2] =  bisectionMethod(params,@function1_2);
[sec_x_vect_2, sec_x_dif_2,   sec_fx_2, sec_it_cnt_2] =  secantMethod(params,@function1_2);

fprintf("angular frequency ≈ %f[rad/s] \n", (bis_x_vect_2(end)));

shortPlot(bis_x_dif_2, title_diffs, bis_suffix, x_label, y_label, gcf, file_path, '2_1.png');
shortPlot(sec_x_dif_2, title_diffs, sec_suffix, x_label, y_label, gcf, file_path, '2_2.png');
shortPlot(bis_fx_2, title_approx, bis_suffix, x_label, y_label, gcf, file_path, '2_3.png');
shortPlot(sec_fx_2, title_approx, sec_suffix, x_label, y_label, gcf, file_path, '2_4.png');

end

function ex3 (title_approx,title_diffs,x_label,y_label,bis_suffix,sec_suffix,file_path)

params = [0,50,10^-12];

[bis_x_vect_3,   bis_x_dif_3,     bis_fx_3,   bis_it_cnt_3] =  bisectionMethod(params,@function1_3);
[sec_x_vect_3, sec_x_dif_3,   sec_fx_3, sec_it_cnt_3] =  secantMethod(params,@function1_3);
fprintf("time to reach 750m/s ≈ %f[s] \n", (bis_x_vect_3(end)));

shortPlot(bis_x_dif_3, title_diffs, bis_suffix, x_label, y_label, gcf, file_path, '3_1.png');
shortPlot(sec_x_dif_3, title_diffs, sec_suffix, x_label, y_label, gcf, file_path, '3_2.png');
shortPlot(bis_fx_3, title_approx, bis_suffix, x_label, y_label, gcf, file_path, '3_3.png');
shortPlot(sec_fx_3, title_approx, sec_suffix, x_label, y_label, gcf, file_path, '3_4.png');

end

function shortPlot(data, title_diffs, sec_suffix, x_label, y_label, gcf, file_path, name)

set(gcf,'Position',[10 100 900 600])
plot(data);
title(title_diffs + sec_suffix);
xlabel(x_label);
ylabel(y_label);
full_file_path = strcat(file_path, name);
exportgraphics(gcf, full_file_path);


end

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
%xvect - wektor kolejnych wartości przybliżonego rozwiązania,
%xdif - wektor różnić pomiędzy kolejnymi wartościami przybliżonego rozwiązania,
%fx - wektor wartości funkcji dla kolejnych elementów wektora xvect,
%it_cnt - liczba iteracji wykonanych przy poszukiwaniu miejsca zerowego.

function [title_approx,title_diffs,x_label,y_label,bis_suffix,sec_suffix,file_path ]=nameSetup()
title_approx = "value of approximation in corelation to iteration count ";
title_diffs = "difference between subsequent x values in corelation to iteration count ";
x_label = "iteration no. ";
y_label = "difference in value ";
bis_suffix = " for bisection method";
sec_suffix = "for secant-based method";
file_path = "plots/";
end