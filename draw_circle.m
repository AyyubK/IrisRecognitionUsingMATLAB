function result = draw_circle(mst,name)


%mst = input('enter choice for new entry = 1, for checking =2');

%




[FileName,PathName] = uigetfile('*.jpg','Select the MATLAB code file');
%image_rgb1 = fopen(FileName);
image_rgb1 = rgb2gray(imread(FileName));%fgetl(image_rgb1);
% if mst == 1
% 
% name = input('enter Name of user','s');
% 
% end
figure;

imshow(image_rgb1);

% image_rgb2 = rgb2gray(imread('iris_4.jpg'));
% 
% figure;
% 
% imshow(image_rgb2);
% 
% % edge detection
% 
% image_rgb1 = double(imresize(image_rgb1, [256 256]));

Image_edge1 = double(edge(imresize(image_rgb1, [256 256]),'canny'));

figure;

imshow(Image_edge1);

% for second image
% 
% image_rgb1 = double(imresize(image_rgb2, [255 255]));
% 
% Image_edge2 = double(edge(imresize(image_rgb2, [256 256]),'canny'));

% figure;
% 
% imshow(Image_edge2);

% find the outer circle in the eye 

sum_intensity = zeros(size(Image_edge1,1),1);

probable_center_x = [126:130];

probable_center_y = [126:130];

i=1;

check = 0;
for m = 1:size(probable_center_x,2)

    for n = 1:size(probable_center_y,2)
    
xc = probable_center_x(1,m); yc = probable_center_y(1,n);

for j = 10:120 % radius

r= j;

x=1;

          y=r;
          Pk=1-r;
          
          
          i = i+1;
          
          sum_intensity = Plotpoint(xc,yc,x,y,sum_intensity,Image_edge1,i);
          
          while x<y
          
              
              if Pk<0
          
                   x=x+1;
                   Pk=Pk+(2*x)+1;
              
              else
               
                   x=x+1;
                   y=y-1;
                   Pk=Pk+(2*x)-(2*y)+1;
              end
              
              sum_intensity = Plotpoint(xc,yc,x,y,sum_intensity,Image_edge1,i);
          end
end

[C I] = max(sum_intensity);

if check < C
    
   
    check = C;
    
    final_I = I;
    
C
xc
yc

end


sum_intensity = zeros(size(Image_edge1,1),1);

i = 1;

% crop image 



    end
end 

I1_outter_circle = imcrop(Image_edge1,[xc-I yc-I I+I I+I]);  % [xmin ymin width height]

figure;

imshow(I1_outter_circle);

% now for inner circle

check = 5;
final_I = 0;

original_Image = imcrop(image_rgb1,[xc-I yc-I I+I I+I]);

Image_edge1 = double(imresize(I1_outter_circle, [171 171]));


sum_intensity = zeros(size(Image_edge1,1),1);

probable_center_x = [86];%:84];

probable_center_y = [86];%:87];

i=1;

for m = 1:size(probable_center_x,2)

    for n = 1:size(probable_center_y,2)
    
xc = probable_center_x(1,m); yc = probable_center_y(1,n);

for j = 10:32

r= j;

x=1;

          y=r;
          Pk=1-r;
          
          
          i = i+1;
          
          sum_intensity = Plotpoint(xc,yc,x,y,sum_intensity,Image_edge1,i);
          
          while x<y
          
              
              if Pk<0
          
                   x=x+1;
                   Pk=Pk+(2*x)+1;
              
              else
               
                   x=x+1;
                   y=y-1;
                   Pk=Pk+(2*x)-(2*y)+1;
              end
              
              sum_intensity = Plotpoint(xc,yc,x,y,sum_intensity,Image_edge1,i);
          end
end

[C I] = max(sum_intensity);

for h = 1:size(sum_intensity,1)

if check < sum_intensity(h,1)
    
   
    check = C;
    
    final_I = I;
    
    
    
C
xc
yc

%break;

end

end
sum_intensity = zeros(size(Image_edge1,1),1);

i = 1;

% crop image 

if final_I >0
    
    %break;
end
    

end
    
if final_I >0
    
   % break;
end

end 

II1_inner_circle = imcrop(Image_edge1,[xc-I yc-I I+I I+I]);  % [xmin ymin width height]

figure;

imshow(II1_inner_circle);

% seperate the image from the original

store_iris = zeros(1,xc-I);

col_count = 1;

row_count = 1;

for i = 1:size(original_Image,1)
    
    for j = 1:size(original_Image,2)
        
        
        xmin = xc-I;
        
        ymin = yc-I;
        
        xmax = xc+I;
        
        ymax = yc+I;


           
        if i < xmin || j < ymin || i > xmax || j > ymax
        
            store_iris(row_count,col_count) = original_Image(i,j);
            
        original_Image(i,j) = 1;
        
        col_count = col_count +1;
        
        else 

            original_Image(i,j) = 0;
        end
        
        if col_count > xmin
            
            col_count = 1;
            
            row_count = row_count + 1;
            
            store_iris = vertcat(store_iris,zeros(1,xc-I));
            
            
        end
        
    end
    
    
end

figure;

imshow(original_Image);

figure;

imshow(int8(store_iris));

%---------discrete wavelet transform-------

nbcol = 255;%size(map,1);

cA1 = store_iris;

for i = 1:4

[cA1,cH1,cV1,cD1] = dwt2(cA1,'db1');

% Images coding. 
%cod_X = wcodemat(store_iris,nbcol); 

    cA1
cod_cA1 = wcodemat(cA1,nbcol); 


cod_cH1 = wcodemat(cH1,nbcol); 


    
cod_cV1 = wcodemat(cV1,nbcol); 
cod_cD1 = wcodemat(cD1,nbcol);
end
%------second time-------------


store_value = horzcat(cod_cD1,cod_cV1,cod_cH1);

store_value = mean(store_value,2);



[num11,txt11,raw1] = xlsread('iris_dataset.xls');



i = size(raw1,1)+1;

if mst == 1

    raw1{i,1} = name;
    
    for j=2:size(store_value,1)
    
    raw1{i,j} = store_value(j-1,1);
    
    end
    
xlswrite('iris_dataset.xls', raw1, 1, 'E1');

result = 'Successfully Enter';
else
    
    
    for i=2:size(raw1,1)
        
        count =0;
    for j=2:15%size(raw1,2)
    
        if store_value(j-1,1) == raw1{i,j}
           
            count = count + 1;
        
            if count >12
            break;
            end
        end
   
        
    end
    
    if count >12
            break;
           
    end
    
    end
    
    if count >=12
    
        disp('-------Image match--------');
        
        result = raw1{i,1};
        
        
        
    else
       disp('-------Image NOT match--------');
         
    result = 'Not Match';
    end
    
    
end
end

function sum_intensity = Plotpoint(xc,yc,x,y,sum_intensity,Image_edge1,i)
%i = 1;
sum_intensity(i,1) = sum_intensity(i,1) + Image_edge1(xc+x,yc+y);   
        
       sum_intensity(i,1) = sum_intensity(i,1) + Image_edge1(xc+y,yc+x); 
       
      sum_intensity(i,1) = sum_intensity(i,1) + Image_edge1(xc-y,yc+x);   
       
       sum_intensity(i,1) = sum_intensity(i,1) + Image_edge1(xc-x,yc+y);   
       
       sum_intensity(i,1) = sum_intensity(i,1) + Image_edge1(xc-x,yc-y);
       
       sum_intensity(i,1) = sum_intensity(i,1) + Image_edge1(xc-y,yc-x);   
       
       sum_intensity(i,1) = sum_intensity(i,1) + Image_edge1(xc+y,yc-x);   
       
       sum_intensity(i,1) = sum_intensity(i,1) + Image_edge1(xc+x,yc-y);   
       


end