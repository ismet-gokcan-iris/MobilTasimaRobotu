clc
clear all

a=arduino('COM4','uno');
vid=videoinput('winvideo',1,'YUY2_1280x720');
set(vid, 'FramesPerTrigger',Inf);
set(vid, 'ReturnedColorspace','rgb');
vid.FrameGrabInterval= 5;

while(1)
start (vid)
while (vid.FramesAcquired<=200)
    flushdata(vid);   

data = getsnapshot(vid);

[y, x, c]= size (data);
x = 1280;
x1= x/2;

x2=x1-100;
x3=x1+100;
x4=x1-400;
x5=x1+400;
p1=x1-370;
p2=x1+370;
x6=x1-635;
x7=x1+620;

%RED
diff_im1 = imsubtract(data(:,:,1), rgb2gray(data));
diff_im1 = medfilt2(diff_im1, [3 3]);
diff_im1 = im2bw(diff_im1,0.18);
diff_im1 = bwareaopen(diff_im1,200);
%GREEN
diff_im2 = imsubtract(data(:,:,2), rgb2gray(data));
diff_im2 = medfilt2(diff_im2, [3 3]);
diff_im2 = im2bw(diff_im2,0.18);
diff_im2 = bwareaopen(diff_im2,200);
%BLUE
diff_im3 = imsubtract(data(:,:,3), rgb2gray(data));
diff_im3 = medfilt2(diff_im3, [3 3]);
diff_im3 = im2bw(diff_im3,0.18);
diff_im3 = bwareaopen(diff_im3,200);

bw =bwlabel(diff_im1, 8);
bw2 =bwlabel(diff_im2, 8);
bw3 =bwlabel(diff_im3, 8);

stats = regionprops(bw, 'all');
stats2 = regionprops(bw2, 'all');
stats3 = regionprops(bw3, 'all');

imshow(data)
hold on
%This is a loop to bound the red objects in a rectangular box.


for object = 1:length(stats)
bb = stats(object).BoundingBox;
bc = stats(object).Centroid;



rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
plot(bc(1),bc(2), '-m+')
flushdata(vid);
%a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), ' Y: ',
num2str(round(bc(2)));

if ((bb(1)>x2) && (bb(1)<x3))
    disp(' x1')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

else if (bb(1)<x4) && (bb(1)>x6)
        disp(' x4')
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',1);
writeDigitalPin(a,'D9',1);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',1);
writeDigitalPin(a,'D12',0);

 
else if (bb(1)>x3 && bb(1)<p2)
disp(' x3')

writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',1);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',1);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',1);

else if (bb(1)<x2 && bb(1)> p1)
        
        disp(' x2')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',1);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',1);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',1);

else if (bb(1)>x5) && (bb(1)<x7)
disp(' x5')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',1);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',1);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',1);
writeDigitalPin(a,'D12',0);

else if (bb(1)>p2) && (bb(1)<x5)
disp(' p2')
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

else if (bb(1)<p1) && (bb(1)>x4)
%isp(' p1')
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

else if  (bb(1)<x6)
        disp(' x6')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

else if  (bb(1)>x7)
disp(' x7')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

    end
    end
    end
    end
end
end
end
end
end

end

for object2 = 1:length(stats2)

aa = stats2(object2).BoundingBox;
ab = stats2(object2).Centroid;
rectangle('Position',aa,'EdgeColor','r','LineWidth',2)
plot(ab(1),ab(2), '-m+')
flushdata(vid);
%a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), ' Y: ',
num2str(round(ab(2)));

if ((aa(1)>x2) && (aa(1)<x3))
    disp(' x1')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

else if (aa(1)<x2 && aa(1)> p1)
        disp(' x2')
writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',1);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);
 
else if (aa(1)>x3 && aa(1)<p2)
disp(' x3')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',1);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

else if (aa(1)<x4) && (aa(1)>x6)
        disp(' x4')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',1);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',1);
writeDigitalPin(a,'D12',0);

else if (aa(1)>x5) && (aa(1)<x7)
disp(' x5')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',1);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',1);

else if (aa(1)>p2) && (aa(1)<x5)
disp(' p2')
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

else if (aa(1)<p1) && (aa(1)>x4)
%isp(' p1')
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

else if  (aa(1)<x6)
        disp(' x6')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

else if  (aa(1)>x7)
disp(' x7')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);

    end
    end
    end
    end
end
end
end
end
end

end

for object3 = 1:length(stats3)

cc = stats3(object3).BoundingBox;
ca= stats3(object3).Centroid;
rectangle('Position',cc,'EdgeColor','r','LineWidth',2)
plot(ca(1),ca(2), '-m+')
flushdata(vid);
%a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), ' Y: ',
num2str(round(ca(2)));

if ((cc(1)>x2) && (cc(1)<x3))
    disp(' x1')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);
writeDigitalPin(a,'D8',0);

else if (cc(1)<x2 && cc(1)> p1)
        disp(' x2')
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',1);
writeDigitalPin(a,'D9',1);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',1);
writeDigitalPin(a,'D8',0);
 
else if (cc(1)>x3 && cc(1)<x7)
disp(' x3')

writeDigitalPin(a,'D8',1);


else if (cc(1)<x4) && (cc(1)>x6)
        disp(' x4')

writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',1);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',1);
writeDigitalPin(a,'D11',1);
writeDigitalPin(a,'D12',0);
writeDigitalPin(a,'D8',0);

else if (cc(1)>x7)
disp(' x7')
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);
writeDigitalPin(a,'D8',0);

else if (cc(1)<p1) && (cc(1)>x4)
%disp(' p1')
writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);
writeDigitalPin(a,'D8',0);

else if  (cc(1)<x6)
        disp(' x6')

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D6',0);
writeDigitalPin(a,'D9',0);
writeDigitalPin(a,'D10',0);
writeDigitalPin(a,'D11',0);
writeDigitalPin(a,'D12',0);
writeDigitalPin(a,'D8',0);
    
    end
    end
end
end
end
end
end

end

hold off
stop(vid);
flushdata(vid);
end
end