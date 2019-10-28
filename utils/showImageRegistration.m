function showImageRegistration(image_s, image_t, S_x, S_y,  landmarkimage_s, landmarkimage_t, index)
%showFeatureMatching illustrates the result for image registration.
%%=====================================================================
%% $Author: PhD Student Su ZHANG, supervised by Prof. Cuntai Guan.$
%% $Date: Mon, 28 Oct 2019$
%% $Contact: sorazcn@gmail.com$
%%=====================================================================   
    
    interval = 20;
    whiteInterval = ones(size(image_s,1), interval, size(image_s, 3)); % if not rgb, change 3 to 1
    image = [image_s whiteInterval image_t]; 
    figure;
    imshow(image);set(gca,'Position',[0.0 0 1 1]); hold on ;
    plot(landmarkimage_s(:,1),landmarkimage_s(:,2),'.','color','g','MarkerSize',15);
    plot(landmarkimage_t(:,1) + interval + size(image_s, 2), landmarkimage_t(:,2),'.','color','r','MarkerSize',15); 
    hold off;
    
    I_x = S_x(index,:);
    I_y = S_y(index,:);
    ptsNum = length(index);
    
    source = [I_x(:,2) I_x(:,1) zeros(ptsNum, 1)];
    target = [I_y(:,2) I_y(:,1) zeros(ptsNum, 1)];
    
    image_o = tps_warp(image_s,source,target,'bicubic');
    image_m = immontage(image_t, image_o, 8);
    image = [image_o whiteInterval image_m]; 
    figure;
    imshow(image);set(gca,'Position',[0.0 0 1 1]); hold on ;
    plot(landmarkimage_t(:,1), landmarkimage_t(:,2),'.','color','r','MarkerSize',15); 
    plot(landmarkimage_t(:,1) + interval + size(image_o, 2), landmarkimage_t(:,2),'.','color','r','MarkerSize',15); 
end

