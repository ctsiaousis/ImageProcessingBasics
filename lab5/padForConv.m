% function to convolute an image with a 3x3 filter
function B = padForConv(A, k, str);
    
    [l c] = size(A); %lines and columns of image
    [m n] = size(k); %lines and columns of filter

    errorMsg = 'only square filters are accepted in func padForConv(A, k, str).';
    assert( m == n , errorMsg); %assert the filter is squared
    
    
    padSize = floor(m/2); %extra pixels in each dimetion
    
    %fill with zeros the output array
    B = zeros(l + (2*padSize), c + (2*padSize));
    
    if str == 'zero'
        %zero padding with forLoop
        for x = 1 + padSize : l + padSize
            for y = 1 + padSize : c + padSize
                B(x,y) = A(x - padSize, y - padSize);
            end
        end
    elseif str == 'fill'
        %fill padding using function padarray
        B = padarray(A, [padSize padSize], 'replicate','post');
        B = padarray(B, [padSize padSize], 'replicate','pre');
    else
        %only two methods implemented for now
        error('str can be "zero" or "fill"')
    end
    
end