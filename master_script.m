%=========================================================================%
% MASTER SCRIPT          : ME354 FINAL PROJECT, AUT 2013
%=========================================================================%

%=========================================================================%
% REPOSITORY INFORMATION

% Developers             : David Manosalvas & Mehul Oswal
% Organization           : Stanford University
% Objective              : Image retrieval, sharpness metric, test metric
% Contact information    : deman@stanford.edu & moswal@stanford.edu
%=========================================================================%

%=========================================================================%
% INPUT OPTIONS
% 
%                      
%
% 
%                        
%
% 
% 
%=========================================================================%

%% Clear previous cache
clear all; close all; clc;

global gauss_size_factor disk_size_factor motion_size_factor
global gaussian_sigma

%% User Specified inputs

% Additive noise parameters
add_noise           = 'yes';
mean_n              =  0   ;
var_n               = 1e-5 ;


%% Images that this code is trained and tested with

nimages = 4;

% Test image 1: peppers.png
im1 = imread('peppers.png');

% Test image 2: lina.jpg
% Copyright of the PlayBoy magazine. Free redistribution cautioned.
im2 = imread('lena.tiff'); 

% Test image 3: cameraman.tif
im3 = imread('cameraman.tif');

% Test image 4: ssphere.jpg
im4 = imread('ssphere.jpg');

%% Make the images gray scale (reduces computational workload and within
% scope of this project). Also intensities are normalized to between [0,1]

for i = 1:nimages
    if nimages > 4
        error(...
        'no. of images must be checked again. If not, comment this out')
    else
        switch i
            case 1                
                Im1 = mat2gray(rgb2gray(im2double(im1)));
                im_size1 = size(Im1);
                lower_dimension(1) = min(im_size1);
            case 2                
                Im2 = mat2gray(rgb2gray(im2double(im2)));
                im_size2 = size(Im2);
                lower_dimension(2) = min(im_size2);
            case 3                
                Im3 = mat2gray(im2double(im3));
                im_size3 = size(Im3);
                lower_dimension(3) = min(im_size3);
            case 4                
                Im4 = mat2gray(im2double(im4));
                im_size4 = size(Im4);
                lower_dimension(4) = min(im_size4);
            otherwise
                error(...
            'User needs to intervene here in converting images gray scale')
        end
    end
end
%% Size of the PSF as a percentage of the lower dimension
PSF_factor = 0.01; % 4% of the lower dimension
for i = 1:nimages
    PSF_size(i) = ceil(PSF_factor*lower_dimension(i));
end

%% Now that we have the blur sizes, lets get the blur PSF + noise set up

% 1     : Gaussian PSF
% 2     : Disk PSF
% 3     : Motion PSF

% Additional factors can be set to 1 for consistency amongst blur types
% These factors are introduced because PSF_size = 1% was not significatn
gauss_size_factor    = 2;
gaussian_sigma       = 5;
disk_size_factor     = 1;
motion_size_factor   = 2;

for i = 1:nimages
    if nimages > 4
        error(...
        'no. of images must be checked again. If not, comment this out')
    else
        switch i
            case 1
                PSF_11 = fspecial('gaussian', ...
                    gauss_size_factor*PSF_size(i),...
                    gaussian_sigma);
                blurred_11 = imfilter(Im1, PSF_11, 'conv', 'circular');
                
                PSF_12 = fspecial('disk', disk_size_factor*PSF_size(i));
                blurred_12 = imfilter(Im1, PSF_12, 'conv', 'circular');
                
                PSF_13 = fspecial('motion', ...
                    motion_size_factor*PSF_size(i),...
                    motion_size_factor*PSF_size(i));
                blurred_13 = imfilter(Im1, PSF_13, 'conv', 'circular');
                
                switch add_noise
                    case 'yes'
                        blurred_11 = imnoise(blurred_11, 'gaussian', ...
                        mean_n, var_n);
                        blurred_12 = imnoise(blurred_12, 'gaussian', ...
                        mean_n, var_n);
                        blurred_13 = imnoise(blurred_13, 'gaussian', ...
                        mean_n, var_n);
                    case 'no'
                        disp('Train images only blurred, no noise added')
                    otherwise
                        error('Wrong "add_noise" input choice')
                end
            case 2
                PSF_21 = fspecial('gaussian', ...
                    gauss_size_factor*PSF_size(i), ...
                    gaussian_sigma);
                blurred_21 = imfilter(Im2, PSF_21, 'conv', 'circular');
                
                PSF_22 = fspecial('disk', disk_size_factor*PSF_size(i));
                blurred_22 = imfilter(Im2, PSF_22, 'conv', 'circular');
                
                PSF_23 = fspecial('motion', ...
                    motion_size_factor*PSF_size(i), ...
                    motion_size_factor*PSF_size(i));
                blurred_23 = imfilter(Im2, PSF_23, 'conv', 'circular');
                
                switch add_noise
                    case 'yes'
                        blurred_21 = imnoise(blurred_21, 'gaussian', ...
                        mean_n, var_n);
                        blurred_22 = imnoise(blurred_22, 'gaussian', ...
                        mean_n, var_n);
                        blurred_23 = imnoise(blurred_23, 'gaussian', ...
                        mean_n, var_n);
                    case 'no'
                        disp('Train images only blurred, no noise added')
                    otherwise
                        error('Wrong "add_noise" input choice')
                end
                
            case 3
                PSF_31 = fspecial('gaussian', ...
                    gauss_size_factor*PSF_size(i), ...
                    gaussian_sigma);
                blurred_31 = imfilter(Im3, PSF_31, 'conv', 'circular');
                
                PSF_32 = fspecial('disk', disk_size_factor*PSF_size(i));
                blurred_32 = imfilter(Im3, PSF_32, 'conv', 'circular');
                
                PSF_33 = fspecial('motion', ...
                    motion_size_factor*PSF_size(i), ...
                    motion_size_factor*PSF_size(i));
                blurred_33 = imfilter(Im3, PSF_33, 'conv', 'circular'); 
                
                switch add_noise
                    case 'yes'
                        blurred_31 = imnoise(blurred_31, 'gaussian', ...
                        mean_n, var_n);
                        blurred_32 = imnoise(blurred_32, 'gaussian', ...
                        mean_n, var_n);
                        blurred_33 = imnoise(blurred_33, 'gaussian', ...
                        mean_n, var_n);
                    case 'no'
                        disp('Train images only blurred, no noise added')
                    otherwise
                        error('Wrong "add_noise" input choice')
                end
                
            case 4
                PSF_41 = fspecial('gaussian', ...
                    gauss_size_factor*PSF_size(i), ...
                    gaussian_sigma);
                blurred_41 = imfilter(Im4, PSF_41, 'conv', 'circular');
                
                PSF_42 = fspecial('disk', disk_size_factor*PSF_size(i));
                blurred_42 = imfilter(Im4, PSF_42, 'conv', 'circular');
                
                PSF_43 = fspecial('motion', ...
                    motion_size_factor*PSF_size(i), ...
                    motion_size_factor*PSF_size(i));
                blurred_43 = imfilter(Im4, PSF_43, 'conv', 'circular'); 
                
                switch add_noise
                    case 'yes'
                        blurred_41 = imnoise(blurred_41, 'gaussian', ...
                        mean_n, var_n);
                        blurred_42 = imnoise(blurred_42, 'gaussian', ...
                        mean_n, var_n);
                        blurred_43 = imnoise(blurred_43, 'gaussian', ...
                        mean_n, var_n);
                    case 'no'
                        disp('Train images only blurred, no noise added')
                    otherwise
                        error('Wrong "add_noise" input choice')
                end
                
            otherwise
                error(...
            'User needs to intervene here in setting up image PSFs')
        end
    end
end

%% And testing different filters 
% For all test images w or w/o noise
% Using im_filter.m script created for this



% Index read guide
% u_221: 2nd image, disk blur, filter index

% Filter index
    % 1: inverse
    % 2: wiener
    % 3: geo_mean
    % 4: least_squares
    % 5: ED+filt
    

% For Disk type blur in Lena
v               = blurred_22;
PSF_type        = 'disk';
filter_type     = 'wiener';
PSF_dim         = PSF_size(2);
factor          = 'global';
psf             = PSF_gen(PSF_type,PSF_dim,factor);
[u_222,G_222]   = im_filter(v,filter_type,psf,var_n);
figure, imshow(u_222)
title(['Lena blurred by ', PSF_type ' image recovered using',filter_type])


v               = blurred_22;
PSF_type        = 'disk';
filter_type     = 'geo_mean';
PSF_dim         = PSF_size(2);
factor          = 'global';
psf             = PSF_gen(PSF_type,PSF_dim,factor);
[u_223,G_223]   = im_filter(v,filter_type,psf,var_n);
figure, imshow(u_223)
title(['Lena blurred by ', PSF_type ' image recovered using',filter_type])

% v               = blurred_22;
% PSF_type        = 'disk';
% filter_type     = 'ED+filt';
% PSF_dim         = PSF_size(2);
% factor          = 'global';
% [u_225,G_225] = im_filter(v,filter_type,PSF_type,PSF_dim,var_n,factor);
% figure, imshow(u_225)
% title(['Lena blurred by ', PSF_type ' image recovered using',filter_type])

clear v psf 

% For Gaussian blur in Cameraman
v               = blurred_31;
PSF_type        = 'gaussian';
filter_type     = 'wiener';
PSF_dim         = PSF_size(3);
factor          = 'global';
psf             = PSF_gen(PSF_type,PSF_dim,factor);
[u_312,G_312]   = im_filter(v,filter_type,psf,var_n);
figure, imshow(u_312) 
title(['Cameraman blurred by ', PSF_type ' image recovered using',filter_type])

v               = blurred_31;
PSF_type        = 'gaussian';
filter_type     = 'geo_mean';
PSF_dim         = PSF_size(3);
factor          = 'global';
psf             = PSF_gen(PSF_type,PSF_dim,factor);
[u_313,G_313]   = im_filter(v,filter_type,psf,var_n);
figure, imshow(u_313)
title(['Cameraman blurred by ', PSF_type ' image recovered using',filter_type])

% v               = blurred_31;
% PSF_type        = 'gaussian';
% filter_type     = 'ED+filt';
% PSF_dim         = PSF_size(3);
% factor          = 'global';
% [u_315,G_315] = im_filter(v,filter_type,PSF_type,PSF_dim,var_n,factor);
% figure, imshow(u_315)
% title(['Cameraman blurred by ', PSF_type ' image recovered using',filter_type])

clear v psf

% For motion blur in the sphere
v               = blurred_43;
PSF_type        = 'motion';
filter_type     = 'wiener';
PSF_dim         = PSF_size(4);
factor          = 'global';
psf             = PSF_gen(PSF_type,PSF_dim,factor);
[u_432,G_432]   = im_filter(v,filter_type,psf,var_n);
figure, imshow(u_432)
title(['Sphere blurred by ', PSF_type ' image recovered using',filter_type])

v               = blurred_43;
PSF_type        = 'motion';
filter_type     = 'geo_mean';
PSF_dim         = PSF_size(4);
factor          = 'global';
psf             = PSF_gen(PSF_type,PSF_dim,factor);
[u_433,G_433]   = im_filter(v,filter_type,psf,var_n);
figure, imshow(u_433) 
title(['Sphere blurred by ', PSF_type ' image recovered using',filter_type])

% v               = blurred_43;
% PSF_type        = 'motion';
% filter_type     = 'ED+filt';
% PSF_dim         = PSF_size(4);
% factor          = 'global';
% [u_435,G_435] = im_filter(v,filter_type,PSF_type,PSF_dim,var_n,factor);
% figure, imshow(u_435)
% title(['Sphere blurred by ', PSF_type ' image recovered using',filter_type])

clear v psf

%%

