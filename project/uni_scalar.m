% mid-tread quantizer
function D = uni_scalar(iSignal, inA, desiredL)
    assert(desiredL<=2^8,'input signal must be in [-255,255] range')
    
    step = (2*inA)/desiredL;
    
%     assert(step==,'input signal must be in [-255,255] range')
    [m, n] = size(iSignal);
    if( n == 1 ) %signal is 1-D
        D=zeros(m,n);
        for i=1:m
            roundVal = floor( (abs(iSignal(i))/step) + (1/2));
            D(i)= step * sign(iSignal(i)) * roundVal;
        end
        
    else %signal is 2-D
        D=zeros(m,n);
        for j=1:m
            for k=1:n
                roundVal = floor( (abs(iSignal(j,k))/step) + (1/2) );
                D(j,k)= step * sign(iSignal(j,k)) * roundVal;
            end
        end
        
    end
end


% function y = adc_NU(x, R, B)
% level = [0:R/(2^B):R-R/(2^B)];
% temp = [-Inf,(level(2:end)-R/(2^(B+1))),Inf];
% y = zeros(1,length(x));
% for i = 1:length(level)
% y = y + (x >= temp(i)).*(x < temp(i+1)).*level(i);
% end