function Iout=immontage(Ia,Ib,N)
%immontage overlays the reference image with the
%       transformed image forming a check-board.

n=size(Ia,1);
m=size(Ia,2);
stepn=round(n/N);
stepm=round(m/N);
dim = size(Ia, 3);
Iout=zeros(n,m,dim);
    for i=1:N 
        for j=1:N 
            ns=(i-1)*stepn+1;
            if i*stepn<n
                ne=i*stepn;
            else
                ne=n;
            end               
            ms=(j-1)*stepm+1;
            
            if j*stepm<m
                me=j*stepm;
            else
                me=m;
            end
            if mod(i+j,2)==0   
                Iout(ns:ne,ms:me,:)=Ia(ns:ne,ms:me,:);
            else
%                 Iout(ns:ne,ms:me)=Ib(ns:ne,ms:me);
                Iout(ns:ne,ms:me,:)=Ib(ns:ne,ms:me,:);
            end
        end        
    end
    imshow(Iout,'border','tight','initialmagnification','fit');
    set (gcf,'Position',[0,0,m,n]);
    axis normal;
end