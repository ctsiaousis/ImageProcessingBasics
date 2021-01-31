function outGray = partB( input_str )
    fprintf('--------------PART B--------------\n');
    vidX=VideoReader(input_str);
    figure;
    currAxes = axes;
    numOfFr = 0;
    fps = vidX.FrameRate;
    dur = vidX.Duration;
    while hasFrame(vidX)
        vidFrame = readFrame(vidX);
        image(vidFrame, 'Parent', currAxes);
        numOfFr = numOfFr + 1;
        pause(1/fps);
    end

    info = sprintf('The total number of frames is %d\n', numOfFr);
    info = sprintf('%sThe frameRate of the video is %d\n',info, fps);
    info = sprintf('%sEach frame is %dx%d\n',info, vidX.Width, vidX.Height);
    info = sprintf('%sThe duration of the video is %d',info, dur);
    disp(info);

    vidX = VideoReader(input_str);
    inIm = read(vidX,50);
    outGray = rgb2gray(inIm);
    figure
    subplot(1,2,1); imshow(inIm); title('50^{th} frame in RGB')
    subplot(1,2,2); imshow(outGray); title('50^{th} frame in GRAY')

    fprintf('----------------------------------\n');
end

