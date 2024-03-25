close all;
clear;
load("Results\fig5.mat")
figure(Position=[100, 100, 800, 500])
hold on;
plot(brownX,brownY,'-o', Color = [0, 0, 1])
plot(brownLX,brownLY,"--", Color = [0, 0, 1])
plot(limeX,limeY,'-o', Color = [0, 0, 0.75])
plot(limeLX,limeLY,'--', Color = [0, 0, 0.75])
plot(orangeX,orangeY,'-o', Color = [0, 0, .5])
plot(orangeLX,orangeLY,'--', Color = [0, 0, .5])
plot(cyanX,cyanY,'-o', Color = [1, 0, 0])
plot(cyanLX,cyanLY,'--', Color = [1, 0, 0])
plot(blueX,blueY,'-o', Color = [0.75, 0, 0])
plot(blueLX,blueLY,'--', Color = [0.75, 0, 0])
plot(grnX,grnY,'-o', Color = [0.5, 0, 0])
plot(grnLX,grnLY,'--', Color = [0.5, 0, 0])
hold off;
set(gca, "FontSize", 16)
set(gca, "FontName", "Times New Roman")
grid()
xlim([0 60])
ylim([0 3])
ylabel("Contrast Threshold, log(s)")
xlabel("Temporal Frequency (Hz)")
lgd = legend(["2.", "", "1.57", "", "1.", "", "1.73", "", "1.3", "", "0.87", ""]);
title(lgd,'I (log Td)')