I = rgb2gray(imread('corner_window.jpg'));
edge_detect(I, 'LoG', 5);