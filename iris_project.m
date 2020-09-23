function iris_project()


image_rgb1 = rgb2gray(imread('iris_1.jpg'));

figure;

imshow(image_rgb1);

image_rgb2 = rgb2gray(imread('iris_4.jpg'));

figure;

imshow(image_rgb2);

% edge detection

image_rgb1 = double(imresize(image_rgb1, [256 256]));

Image_edge1 = double(edge(imresize(image_rgb1, [256 256]),'canny'));

figure;

imshow(Image_edge1);

% for second image

image_rgb1 = double(imresize(image_rgb2, [255 255]));

Image_edge2 = double(edge(imresize(image_rgb2, [256 256]),'canny'));

figure;

imshow(Image_edge2);

% find the outer circle in the eye 

sum_intensity = zeros(size(Image_edge1,1),1);

middle = 128;

start = 1;

for i = start+1:120%:255
i
    for j = 1:3
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge1(middle,middle+i+j);   
        
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge1(middle,middle-i+j); 
       
      sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge1(middle+i+j,middle+i+j);   
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge1(middle-i+j,middle+i+j);   
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge1(middle+i+j,middle);
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge1(middle-i+j,middle);   
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge1(middle+i+j,middle-i+j);   
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge1(middle-i+j,middle-i+j);   
       
    end
      
end

[C I] = max(sum_intensity);

% crop image 

I2 = imcrop(Image_edge1,[middle-I middle-I I+I I+I]);  % [xmin ymin width height]

figure;

imshow(I2);


% find the outer circle in the eye 

sum_intensity = zeros(size(Image_edge2,1),1);

middle = 128;

start =1;

for i = start+1:120%:255
i
    for j = 1:3
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge2(middle,middle+i+j);   
        
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge2(middle,middle-i+j); 
       
      sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge2(middle+i+j,middle+i+j);   
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge2(middle-i+j,middle+i+j);   
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge2(middle+i+j,middle);
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge2(middle-i+j,middle);   
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge2(middle+i+j,middle-i+j);   
       
       sum_intensity(i-start,1) = sum_intensity(i-start,1) + Image_edge2(middle-i+j,middle-i+j);   
       
    end
      
end

[C I] = max(sum_intensity);

% crop image 

I2 = imcrop(Image_edge2,[middle-I middle-I I+I I+I]);  % [xmin ymin width height]

figure;

imshow(I2);


end

