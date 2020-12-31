function OUT_IMAGE = haar2anal( imIn, level )
    [rows,columns] = size(imIn);
    assert((rows>1 && columns>1),'please input an image');
    OUT_IMAGE = double(imIn);

%% this section wiil apply for the upper left subband of previous level
    for lvl=1:level
        %lvl=1 applies to whole image
        % bigger levels apply to image/2^(level-1)
        
        %first rows
        for i=1:rows/(2^(lvl-1))
            tmp = OUT_IMAGE(i, 1:columns/(2^(lvl-1)));
            OUT_IMAGE(i, 1:columns/(2^(lvl-1))) = haar1analysis(tmp,1);
        end
        %then columns, notice the transpose signs (')
        for l=1:columns/(2^(lvl-1))
            tmp = OUT_IMAGE(1:rows/(2^(lvl-1)), l)';
            OUT_IMAGE(1:rows/(2^(lvl-1)), l) = haar1analysis(tmp,1)';
        end
    end
    
%% this commented section wiil apply for the whole image per level
%     for dummy=1:level
%         for i=1:rows
%             tmp = OUT_IMAGE(i,:);
%             OUT_IMAGE(i,:) = analysis(tmp,1);
%         end
%         for l=1:columns
%             tmp = OUT_IMAGE(:,l)';
%             OUT_IMAGE(:,l) = analysis(tmp,1)';
%         end
%     end
end
