clear all;
close all;
clc;
O_im=imread('image1.jpg');
figure
imshow(O_im); title('original image');
%redChannel = imshow(:,:,1); % Red channel
%greenChannel = imshow(:,:,2); % Green channel
%blueChannel = imshow(:,:,3); % Blue channel
C_im=imcrop(O_im,[80 80 15 15]); 
%gray_im=rgb2gray(O_im); title('fully gray scale image');
%figure
%imshow(gray_im);
figure
imshow(C_im); title('cropped image');
gray_im_crop=rgb2gray(C_im);
figure
imshow(gray_im_crop); title('cropped gray scale image');

%quantization
[Width,Length]=size(C_im);
thresh = multithresh(gray_im_crop,7); % quntied levels 0-7:3bits
valuesMax = [thresh max(gray_im_crop(:))]; %
[quant8_I, index]= imquantize(gray_im_crop,thresh, valuesMax);%index:8 to 0 quantized_T: scaled values
%quant8_I = imquantize (gray_im_crop,thresh); %index:8 to 0
figure
imshow(quant8_I,[]); title('quontized cropped image');

%probabilities

[g,~,intencity_val]=grp2idx(quant8_I(:));
frequency = accumarray(g,1);% frequencies of thresholds 

[intencity_val frequency];
probability = frequency./262144 ;
T = table(intencity_val,frequency,probability);%table(element | count| prob
T(1:length(frequency),:);

%haffman

T1=sortrows(T,'probability');
M0 =table2array(T1(:,3));
I0=table2array(T1(:,1));
F0=table2array(T1(:,2));
M1 = sort(M0);
%val1= M1(1,1)+M1(2,1) ;
%M2 = sort([M1(3:8);val1]);
%val2=M2(1,1)+M2(2,1);
%M3 =sort( [M2(3:7);val2]);
%val3=M3(1,1)+M5(2,1);

%sort and creat the table
for i= 1:6
    %M1 = sort(M0);
    genvarname('val',  num2str(i));
    genvarname('M',  num2str(i));
    genvarname('N',  num2str(i));
    eval(['M' num2str(0)  '=table2array(T(:,3))']);
    eval(['M' num2str(1)  '=sort(M' num2str(0) ')']);
    eval(['val' num2str(i) '=M' num2str(i) '(1,1)+ M' num2str(i) '(2,1)']);
    %val(i)=M'i-1'(1,1)+M'i-1'(2,1) ;
    eval(['M',  num2str(i+1) '=sort([M' num2str(i) '(3:9-i); val' num2str(i) '])']);
    %M(i)= [M(i-1)(3:9-i);val(i)];
    genvarname('T',  num2str(i));
    r= zeros(8,1);
    eval(['T' num2str(i+1) '=[M' num2str(i+1) '; r(1:i)]']);
    eval(['k = val' num2str(i) ])
    eval([ 't= [T' num2str(i+1) ']'])
    t(1)
    %identyfy at which place the added elements are now
    for n= 1:8
        if t(n)== k
            eval([ 'N' num2str(i+1) '= n' ])
        end
    end
            
    
end

%colums of the table
val=[val1,val2,val3,val4,val5,val6];
tt1= table (I0,F0,M1,T2,T3,T4,T5,T6,T7);
t1=[M1(1:8)];t7=[T7(1:2)];t6=[T6(1:3)];t5=[T5(1:4)];t4=[T4(1:5)];t3=[T3(1:6)];t2=[T2(1:7)];


I=eye(8)
genvarname('I',  num2str(i));
m=sort(table2array(T(:,3)))
I(:,9)=m
eval(['I' num2str(1) '= I'])
   for i=1:6
      genvarname('valf',  num2str(i));
      eval(['valf' num2str(i) '= I' num2str(i) '(1,:)+I' num2str(i) '(2,:)'])
      eval([ 'I' num2str(i+1) '= sortrows([I' num2str(i) '(3:9-i,:);valf' num2str(i) '],9)'])
   end
   %arrangimg rows 
  eval(['i1 = [I' num2str(1) '(1:2,1)  I' num2str(2) '(1:2,1)  I' num2str(3) '(1:2,1)  I' num2str(4) '(1:2,1)  I' num2str(5) '(1:2,1)  I' num2str(6) '(1:2,1)  I' num2str(7) '(1:2,1)]']);
 i1( :, ~any(i1,1) ) = []; 
 eval(['i2 = [I' num2str(1) '(1:2,2)  I' num2str(2) '(1:2,2)  I' num2str(3) '(1:2,2)  I' num2str(4) '(1:2,2)  I' num2str(5) '(1:2,2)  I' num2str(6) '(1:2,2)  I' num2str(7) '(1:2,2)]']);
 i2( :, ~any(i2,1) ) = []; 
 eval(['i3 = [I' num2str(1) '(1:2,3)  I' num2str(2) '(1:2,3)  I' num2str(3) '(1:2,3)  I' num2str(4) '(1:2,3)  I' num2str(5) '(1:2,3)  I' num2str(6) '(1:2,3)  I' num2str(7) '(1:2,3)]']);
 i3( :, ~any(i3,1) ) = []; 
 eval(['i4 = [I' num2str(1) '(1:2,4)  I' num2str(2) '(1:2,4)  I' num2str(3) '(1:2,4)  I' num2str(4) '(1:2,4)  I' num2str(5) '(1:2,4)  I' num2str(6) '(1:2,4)  I' num2str(7) '(1:2,4)]']);
 i4( :, ~any(i4,1) ) = []; 
 eval(['i5 = [I' num2str(1) '(1:2,5)  I' num2str(2) '(1:2,5)  I' num2str(3) '(1:2,5)  I' num2str(4) '(1:2,5)  I' num2str(5) '(1:2,5)  I' num2str(6) '(1:2,5)  I' num2str(7) '(1:2,5)]']);
 i5( :, ~any(i5,1) ) = []; 
 eval(['i6 = [I' num2str(1) '(1:2,6)  I' num2str(2) '(1:2,6)  I' num2str(3) '(1:2,6)  I' num2str(4) '(1:2,6)  I' num2str(5) '(1:2,6)  I' num2str(6) '(1:2,6)  I' num2str(7) '(1:2,6)]']);
 i6( :, ~any(i6,1) ) = []; 
 eval(['i7 = [I' num2str(1) '(1:2,7)  I' num2str(2) '(1:2,7)  I' num2str(3) '(1:2,7)  I' num2str(4) '(1:2,7)  I' num2str(5) '(1:2,7)  I' num2str(6) '(1:2,7)  I' num2str(7) '(1:2,7)]']);
 i7( :, ~any(i7,1) ) = []; 
 eval(['i8 = [I' num2str(1) '(1:2,8)  I' num2str(2) '(1:2,8)  I' num2str(3) '(1:2,8)  I' num2str(4) '(1:2,8)  I' num2str(5) '(1:2,8)  I' num2str(6) '(1:2,8)  I' num2str(7) '(1:2,8)]']);
 i8( :, ~any(i8,1) ) = []; 
 
 
for l=1:8
    for j= 1: eval ([' length(i' num2str(l) ')'])
     for k= 1:2
        if eval(['i' num2str(l) '(k,j) ==1'])
            if k==1
                p= eval(['length(i' num2str(l) ')'])
                o= p +1 -j
               
                A(o)=1
            else
               eval([ '0==A((length(i' num2str(l) ')+1-j))'])
            end
        end
     end
    end
end