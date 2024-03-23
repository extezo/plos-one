function [y, u, v] = yuvReadFrame(fid, width, height, iFrame, y_only)
%This function read a designated frame of yuv420p files 
%   vid: video file name
%   width, height: width and height of the video
%   iFrame: read the iFrameth frame.
    length = 1.5 * width * height;  % Length of a single frame

    fseek(fid, (iFrame-1)*length, 'bof');
    y = fread(fid, [width, height], 'uint8=>uint8')';
    if ~y_only
        u = fread(fid, [width/2, height/2], 'uint8=>uint8')';
        v = fread(fid, [width/2, height/2], 'uint8=>uint8')';
    else 
        u = 0;
        v = 0;
    end
end

