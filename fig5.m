close all;
brownX =[2 3 4 5 6 7 10 12.5 19.5 23 31 35.7];
brownY =[1.75 1.98 1.98 2 1.92 1.85 1.62 1.32 1 0.7 0.3 0];
brownLX=[3.5 35];
brownLY=[2 0];
limeX=[3 4 6 7 8 9 10 12 20 24 30.3 35 39.5];
limeY=[1.85 1.95 2.1 2.09 2.05 2.07 2 1.83 1.3 1 0.55 .3 0];
limeLX=[9.5 40.5];
limeLY=[2 0];
orangeX=[3 5 6 7 10 12 14 18.5 23 26.3 33 38 43];
orangeY=[1.88 2.09 2.2 2.27 2.2 2.1 2.02 1.7 1.41 1.11 0.7 0.31 0];
orangeLX=[13.98 44.7];
orangeLY=[2 0];
cyanX=[4 13 20 25 37 44 48 67];
cyanY=[-0.23 -0.22 -0.5 -0.99 -1.7 -1.9 -1.95 -1.98];
cyanLX=[2 67];
cyanLY=[-0.5 -2.9];
blueX=[4 13 20 25 37 44 48 67];
blueY=[-0.05 -0.05 -0.15 -0.5 -1.4 -1.6 -1.85 -1.95];
blueLX=[2 67];
blueLY=[0.15 -2.71];
grnX=[4 13 20 25 30 37 44 48 67];
grnY=[-0.05 -0.04 -0.1 -0.2 -0.5 -0.9 -1.5 -1.7 -2];
grnLX=[2 67];
grnLY=[0.8 -2.68];

cyanY = normalize(cyanY, "range", [0 max(brownY)]);
blueY = normalize(blueY, "range", [0 max(brownY)]);
grnY = normalize(grnY, "range", [0 max(brownY)]);
cyanLY = [2.5 -1];
blueLY = [3 -1];
grnLY = [3.5 -1];
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
%saveas(gcf, "3.9.eps", 'epsc')