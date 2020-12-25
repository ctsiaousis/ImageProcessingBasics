% function to convolute an image with a filter
function B = convolution(padded, k);

    [m n] = size(k);        %dimentions of filter
    [pL pC] = size(padded); %dimentions of padded image
    lFilter = floor(m/2);
    cFilter = floor(n/2);
    l = pL-2*lFilter;       %lines of output
    c = pC-2*cFilter;       %columns of output
    
    %rotate 90*2=180 degrees, so up is down and left is right
    h = rot90(k, 2); 
    
    %fill the output array with zeros
    B = zeros( l , c );

    %convolute
    for i = 1 : l
        for j = 1 : c
            temp = padded(i:i+2*lFilter, j:j+2*cFilter) .* h;
            B(i,j) = sum(sum(temp));
        end
    end
end