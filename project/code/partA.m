function partA()
    fprintf('--------------PART A--------------\n');
    %% Design our 1-D input signal
    A=255;
    fx = (-A:0.1:A)';

    %% Plot 9 levels of quantization
    %keep in mind that desiredL = 2^R
    figure
    levels=9;
    fancy = ['b','k','r','m'];
    for r=0:levels-1
        fxQ = uni_scalar(fx, A/2, 2^r);
        subplot(2, 5, r+1)
        plot(fx, fxQ, fancy(mod(r,4)+1)); %choose color from fancy array
        str = sprintf('Char. Func. of uni_scalar');
        title(str,'Interpreter','none')
        str = sprintf('r=%d', r);
        legend(str,'Location',['South','East'])
        ylabel('$$\tilde{f}(x)$$', 'Interpreter', 'LaTeX');
        xlabel('$$f(x)$$', 'Interpreter', 'LaTeX');
        grid on
    end


    %% Quantize `lena_gray_512.tif`
    figure
    lena= double( imread('lena_gray_512.tif') );

    levels = 9;
    A = max(max(lena)); % to have correct map, see partC for details
    errors = zeros(levels,1);
    for r=0:levels-1
        l = 2^r;
        q = uni_scalar(lena,A/2,l);
        %calculate mean square errors
        errors(r+1)=immse(lena,q);
        rStr = sprintf('r = %d', r);
        %print
        fprintf('MSE, %s :\t%d\n',rStr, errors(r+1));

        %illustrate the images
        subplot(2,5,r+1)
        imagesc(q)
        colormap gray; colorbar; caxis([0 255])
        title(rStr)
        grid on
    end

    %% plot rate-distortion curve
    figure;
    semilogy([0:8],errors)
    ylabel('MSE Value compared to original')
    xlabel('R Value on quantization')
    title('rate-distortion curve D(R)')
    grid on

    fprintf('----------------------------------\n');
end

