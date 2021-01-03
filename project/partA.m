function partA()
    fprintf('--------------PART A--------------\n');
    %% Design our 1-D input signal
    A=255;
    t = (-1.5*A:1.5*A)';
    inS = (abs(t)<=A).*t;
    
    %% Plot 9 levels of quantization
    %keep in mind that desiredL = 2^R
    figure
    levels=9;
    fancy = ['b','k','r','m'];
    for r=0:levels-1
        newQ = uni_scalar(inS, A/2, 2^r);
        subplot(2, 5, r+1)
        
        P1 = plot(t, inS, '--g');
        hold on
        P2 = plot(t, newQ, fancy(mod(r,4)+1)); %choose color from fancy array
        str = sprintf('Charact. Func. of uni_scalar');
        title(str,'Interpreter','none')
        str = sprintf('Quantized with r=%d', r);
        legend([P1 P2], {'InputSignal',str},'Location',['South','East'])
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
        q = uni_scalar(lena,A,l);
        %calculate mean square errors
        errors(r+1)=immse(lena,q);
        rStr = sprintf('r = %d', r);
        %print
        fprintf('MSE, %s :\t%d\n',rStr, errors(r+1));

        %illustrate the images
        subplot(2,5,r+1)
        imagesc(q)
        colormap gray; colorbar
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

