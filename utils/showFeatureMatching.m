function showFeatureMatching(Is, It, S_x, S_y, TruePos, FalsePos, TrueNeg, FalseNeg)
%showFeatureMatching illustrates the result for feature matching.
%%=====================================================================
%% $Author: PhD Student Su ZHANG, supervised by Prof. Cuntai Guan. $
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================    
    NumPlot = 100;
    
    NumPos = length(TruePos)+length(FalsePos)+length(FalseNeg);
    if NumPos > NumPlot
        t_p = length(TruePos)/NumPos;
        n1 = round(t_p*NumPlot);
        f_p = length(FalsePos)/NumPos;
        n2 = round(f_p*NumPlot);
        f_n = length(FalseNeg)/NumPos;
        n3 = round(f_n*NumPlot);
    else
        n1 = length(TruePos);
        n2 = length(FalsePos);
        n3 = length(FalseNeg);
    end

    per = randperm(length(TruePos)); TruePos = TruePos(per(1:n1));
    per = randperm(length(FalsePos)); FalsePos = FalsePos(per(1:n2));
    per = randperm(length(FalseNeg)); FalseNeg = FalseNeg(per(1:n3));

    interval = 20;
    whiteInterval = ones(size(Is,1), interval, size(Is, 3)); 
    figure;
    I = [Is whiteInterval It]; 
    imshow(I);set(gca,'Position',[0.0 0 1 1]);
    hold on ;

    line([S_x(FalseNeg,1)'; S_y(FalseNeg,1)'+size(Is,2)+interval], [S_x(FalseNeg,2)' ;  S_y(FalseNeg,2)'],'linewidth', 1, 'color', 'g') ;%'g'
    line([S_x(FalsePos,1)'; S_y(FalsePos,1)'+size(Is,2)+interval], [S_x(FalsePos,2)' ;  S_y(FalsePos,2)'],'linewidth', 1, 'color','r') ;%  [0.8,0.1,0]
    line([S_x(TruePos,1)'; S_y(TruePos,1)'+size(Is,2)+interval], [S_x(TruePos,2)' ;  S_y(TruePos,2)'],'linewidth', 1, 'color','b' ) ;%[0,0.5,0.8]
    axis equal ;axis off  ; 
    hold off
    drawnow;
    
    siz = size(Is); k = 0;
    figure;
    quiver(S_x(FalseNeg, 1), siz(1)-S_x(FalseNeg, 2), (S_y(FalseNeg, 1)-S_x(FalseNeg, 1)), (-S_y(FalseNeg, 2)+S_x(FalseNeg, 2)), k, 'g'), hold on
    quiver(S_x(FalsePos, 1), siz(1)-S_x(FalsePos, 2), (S_y(FalsePos, 1)-S_x(FalsePos, 1)), (-S_y(FalsePos, 2)+S_x(FalsePos, 2)), k, 'r'), hold on
    quiver(S_x(TrueNeg, 1), siz(1)-S_x(TrueNeg, 2), (S_y(TrueNeg, 1)-S_x(TrueNeg, 1)), (-S_y(TrueNeg, 2)+S_x(TrueNeg, 2)), k, 'k'), hold on
    quiver(S_x(TruePos, 1), siz(1)-S_x(TruePos, 2), (S_y(TruePos, 1)-S_x(TruePos, 1)), (-S_y(TruePos, 2)+S_x(TruePos, 2)), k, 'b'), hold on

    axis equal
    axis([0 siz(2) 0 siz(1)]);
    set(gca,'XTick',-2:1:-1)
    set(gca,'YTick',-2:1:-1)
end

