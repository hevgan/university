clear
clc

Index = 175854;
N0 = mod(Index, 10);
N1 = mod(N0-1,4)+1;

K = [4,8,14,38];
ex1(K);

a = 5;
b = 45;
ex2(a,b);



function ex1(K)


    for idx = 1:numel(K)

    %generate terrain (sample placement)
    [x,y,f, xp, yp] = lazik(K(idx));

    %generate rover routee
    [XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));

    %create fig
    ex1(idx) = figure('Position', [0, 0, 1800, 900]);

    %plot rover route
    subplot(2,2,1);
    plot(xp,yp,'-o','linewidth',1);
    title("rover route");
    ylabel("y [m]");
    xlabel("x [m]");

    %plot sample placement
    subplot(2,2,2);
    plot3(x,y,f,'o');
    title("values from collected samples");
    ylabel("y [m]");
    xlabel("m [m]");
    zlabel("measured radiation value [Sv]");

    %trygonmetric interpolation
    [p]=trygfit2d(x,y,f);
    [FF]=trygval2d(XX,YY,p);
    subplot(2,2,3);
    surf(XX,YY,FF)
    title('trygonometric interpolation');
    ylabel("y [m]");
    xlabel("x [m]");
    zlabel("interpolated radiation value [Sv]");

    %plynomial interpolation
    [p]=polyfit2d(x,y,f);
    [FF]=polyval2d(XX,YY,p);
    subplot(2,2,4);
    surf(XX,YY,FF)
    title('polynomial interpolation');
    ylabel("y [m]");
    xlabel("x [m]");
    zlabel("interpolated radiation value [Sv]");
    
    %export plots
    exportgraphics(gcf, strcat('ex1_', string(K(idx)), '.png') , 'Resolution', 300);

    end

end

function ex2(a,b)

    steps = b-a+1;
    
    K = linspace(a,b,steps);
    DivK_polynomial = linspace(0,0,steps);
    DivK_trigonometric = linspace(0,0,steps);

    for idx = 1:numel(K)
        
        %generate route and samples
        [x,y,f] = lazik(K(idx));

        %generate rover route
        [XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));

        if(idx == 1)
            FF_prev_P = 0;
            FF_prev_T = 0;
        else 
            FF_prev_P = FF_P;
            FF_prev_T = FF_T;
        end

        %generate poly
        [p]=polyfit2d(x,y,f);
        [FF_P]=polyval2d(XX,YY,p);

        %calc div with function
        DivK_polynomial(idx) = Div_K(FF_P, FF_prev_P); 

        %generate trigo
        [p]=trygfit2d(x,y,f);
        [FF_T]=trygval2d(XX,YY,p);

        %calc div with function
        DivK_trigonometric(idx) = Div_K(FF_T, FF_prev_T); 
    end

    %create fig
    ex2 = figure('Position', [0, 0, 1200, 600]);
    
    %trigonometric diff
    subplot(2,1,1);
    plot(a:b, DivK_trigonometric);
    title("Convergence for trigonometric interpolation");
    ylabel("max difference in value");
    xlabel("number of measurement points - K ");

    %polynomial diff
    subplot(2,1,2);
    plot(a:b, DivK_polynomial);
    title("Convergence for polynomial interpolation");
    ylabel("max difference in value");
    xlabel("number of measurement points - K ");

    %title and saving
    sgtitle('Convergence comparision between polynomial and trigonometrical interpolation')
    exportgraphics(ex2, 'ex2.png' , 'Resolution', 300);

end

function max_div = Div_K(FF,FF_prev)
    max_div = max(max(abs(FF-FF_prev)));
end
