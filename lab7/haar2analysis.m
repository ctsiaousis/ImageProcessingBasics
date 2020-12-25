function imOut = haar2analysis( v )
%HAAR2SYNTHESES Summary of this function goes here
%   Detailed explanation goes here

    col=max(size(v));
    row=min(size(v));
    inp=v;
    op=zeros(col,row);
    while(col>0)
        len=0;
        while(len<2)
            for j=1:row
                for i=0:col/2-1
                    op(j,i+1)=(v(j,2*i+2)+v(j,2*i+1))*.5;
                    op(j,col/2+i+1)=(v(j,2*i+1)-v(j,2*i+2))*.5;
                end
            end
            imOut=op';
            len=len+1;
        end
        col=col/2;
        row=row/2;
        imOut=op';
    end
    imshow(uint8(v));
end

