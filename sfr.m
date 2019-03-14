%
% File: sfr.m
%
% Input arguments : 
%     pic_name
%     roi_x
%     roi_y
%     roi_w
%     roi_h
%
pkg load image

function lpph = calc_mtf50p(gray_line, pic_w, pic_h)
  dbg = 0;
  w = size(gray_line)(2);
  for i=1:(w-1)
    slope(i) = gray_line(i+1) - gray_line(i);
  end
  Y = fft(slope);
  p2 = abs(Y/(w-1));
  p1 = p2(1:(w-1)/2+1);
  p1(2:end) = p1(2:end)*2;
  
  if dbg == 1
    plot(gray_line);
    waitforbuttonpress;
    plot(slope);
    waitforbuttonpress;
    plot(p1);
    waitforbuttonpress;
  endif
  peak=max(p1);
  half=peak/2;
  mtf50p_idx=2;
  for i = 2:(w-1)/2
    if (p1(i) > half) && (p1(i+1) < half)
      mtf50p_idx = i;
      break
    end
  end
  if mtf50p_idx > 2
    lpph = (mtf50p_idx - 1) * pic_h/w;
  else
    lpph = 0;
  endif
endfunction

RGB   = imread(pic_name);
gray  = zeros(1, roi_w);
slope = zeros(1, (roi_w-1));
  
col = [roi_x : (roi_x + roi_w - 1)];
p50 = zeros(roi_h, 1);
for j=1:roi_h  
  row(1:roi_w) = roi_y + j - 1;
  pixels = impixel(RGB, col, row);
  for i=1:roi_w
    gray(i) = 0.2989*pixels(i, 1) + 0.5870*pixels(i, 2) + 0.1140*pixels(i, 3);
  endfor
  gray_all(j,:)     = gray;
  pixels_roi(:,:,j) = pixels;
  p50(j) = calc_mtf50p(gray_all(j,:), size(RGB)(1), size(RGB)(2));
endfor
  
nz_cnt  = 0;
p50_sum = 0;
for i=1:roi_h
  if p50(i)!=0
    nz_cnt++;
    p50_sum += p50(i);
  endif
endfor
if nz_cnt != 0
  av = p50_sum/nz_cnt;
else
  av = 0;
endif
  
str_cell = { char(pic_name), ' ' , num2str(av) };
result = strcat("Result :", str_cell(1), str_cell(2), str_cell(3));
display(char(result));
