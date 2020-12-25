% function to convolute an image with a filter
function B = convolution_bonus(padded, k);

    [m n] = size(k)        %dimentions of filter
    [pL pC] = size(padded); %dimentions of padded image
    lFilter = floor(m/2);
    cFilter = floor(n/2);
    l = pL-2*lFilter;       %lines of output
    c = pC-2*cFilter;       %columns of output
    
    
    lines = zeros( l , c );

    %convolute
    j=1;
    for i = 1 : l
        for j = 1 : c
            temp1 = padded(i:i, j:j+2*cFilter) .* k;
            lines(i,j) = sum(sum(temp1));
        end
    end
    %rotate 90*2=180 degrees, so up is down and left is right
    h = rot90(k, 1); 
    
    columns = zeros( l , c );

    %convolute
    j=1;
    for i = 1 : l
        for j = 1 : c
            temp1 = padded(i:i+2*lFilter, j:j) .* h;
            columns(i,j) = sum(sum(temp1));
        end
    end
    B = lines + columns;
    %fill the output array with zeros

end