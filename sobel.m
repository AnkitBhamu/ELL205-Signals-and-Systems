
img=imread("mm.jpg");
img1=img;
% STEP-1;
%*********************Steps to GrayImage********************************
A=img(:,:,1);
B=img(:,:,2);
C=img(:,:,3);
re=zeros(size(img,1),size(img,2));
for i=1:size(A,1)
 for j=1:size(A,2)
 A=double(A);
 B=double(B);
 C=double(C);
 re=double(re);
     f=0.2989 *A(i,j) + 0.5870 *B(i,j) + 0.1140 *C(i,j); 
     re(i,j)=round(f);

        
  end

 end
%img2=imgaussfilt(img,1);
img2=re;
%imshow(uint8(img2));


%***************************END_OF_GRAYSCALE_CONVERTING**************************************


%**************************KERNAL FOR GAUSIAN FORMING STEP******************
kernal=zeros(5,5);

for i=1:size(kernal,1)
    for j=1:size(kernal,2)
    sigma=0.5;
    normal=1/(2.0*pi*sigma^2);
    kernal(i,j)=exp(-(((i-3)^2+(j-3)^2)/(2.0*sigma^2)))*normal;
    
    end
end
%***********************************************************************




%**************************GAUSIAN-BLURR TO REMOVE NOISE****************************************************

gausian_kernal=kernal;
B=zeros(5);
temp_matrix=zeros(size(img2,1)-4,size(img2,2)-4);

for i=1:size(img2,1)
 for j=1:size(img2,2)
  x=i+4;
  y=j+4;
  if(x>size(img2,1)||y>size(img2,2))
     continue;
  else
   B(1:5,1:5)=img2(i:x,j:y);
   temp2=gausian_kernal.*B;
   sum_a=sum(temp2(:));
   temp_matrix(i,j)=sum_a;
  end
 end
end 

img3=temp_matrix;
img_blurr=img3;
%********************************END_OF_GUASIAN_BLURR*****************************************


%***********************SOBEL(INTENSITY GRADIENT CALCULATION)*****************************
A=zeros(3);
double(A);
gx=[-1 0 1;-2 0 2;-1 0 1];
gy=[1 2 1;0 0 0;-1 -2 -1];
gx=double(gx);
gy=double(gy);
resultant_matrix=zeros(size(img3,1)-2,size(img3,2)-2);
for i=1:size(img3,1)
 for j=1:size(img3,2)
  x=i+2;
  y=j+2;
  if(x>size(img3,1)||y>size(img3,2))
     continue;
  else
   A(1:3,1:3)=img3(i:x,j:y);
  % disp(A);
   sumx=gx.*A;
   sumy=gy.*A;
   ssx=sum(sumx(:));
   ssy=sum(sumy(:));
   M=sqrt(ssx^2+ssy^2);
   resultant_matrix(i,j)=M;
  end
 end
end 

img4=(resultant_matrix);
img_nt=img4;

%*************************SOBEL_END*******************************

%***************************Thresolding*************************

for i=1:size(img4,1)
 for j=1:size(img4,2)

     if(img4(i,j)>220)
         img4(i,j)=255;
     end

if(img4(i,j)<25)
         img4(i,j)=0;
     end


end
end


 img2=uint8(img2);
 img3=uint8(img3);
 img4=uint8(img4);
 img_blurr=uint8(img_blurr);
 img_nt=uint8(img_nt);
% subplot(2,2,1);imshow(img1);title("Original Image");
%subplot(2,2,2);imshow(img2);title("Gray Image");
%subplot(2,2,3);imshow(img3);title("Blurred Image");
%subplot(2,2,4);imshow(img4);title("Edge Detected Image");

figure,imshow(img1);title("Original Image");
figure,imshow(img4);title("Edge Detected Image");

 












 
 
 
 
 














