% Assignment 1 documentation
% This file documents how the RGB/D camera data is defined
% It also describes the "API_Help3d.p" functions YOU NEED TO IMPLEMENT
% For more information you can view the structs manually in "Asst1Example.m"

% Struct that contains RGB data
struct CC (RGB data):
	N: 	 823 int32 				%	number of images taken
	C: 	 [120×160×3×823 uint8]	%	dim1 = row/vertical pixel
                                %   dim2 = col/horizontal pixel
								%   dim3 = R, G, B intensities, respectively
								%   dim4 = image number
                                    %   values in C represent colour intensities
									%   e.g. "CC.C(:,:,1,i)" contains R intensity for image #i
	t64: [1×823 uint64]			%	sample times: 1 unit = 1 microsecond

% Struct that contains Depth data
struct CR (Depth data):
	N: 	 823 int32 				%	number of images taken	
	R: 	 [120×160x823 uint8]	%	dim1 = row/vertical pixel
								%   dim2 = col/horizontal pixel
								%   dim3 = image number
                                    %   values in R represent depth values, 1 unit = 1 mm
									%   e.g. "CR.R(:,:,i)" contains the depth values for image #i
	t64: [1×823 uint64]			%	sample times: 1 unit = 1 microsecond

% NOTE: the number of images taken may vary for different data samples

% Struct for GUI controls
struct CCC (flags for GUI control):
	flagPause: double           %   non-zero to pause animation, zero otherwise

% "API_Help3d.p" - functions YOU need to replace
% Converts depth values to 3d points
Function: [x, y, z] = ConvertSelectedDepthsTo3DPoints(R,ii)
	- R (2d matrix): depth image of size 120x160
	- ii (vector): the linear indices of the pixels of interest
		- If "ii" is empty, then all the pixels are calculated
    - x, y, z (vectors): 3d points

% Rotates x and y points CCW about the origin by 'a' degrees
% You will need to implement a similar function for 3D rotations
% For more information see "Appendix 3.pdf"
Function: [xx, yy] = Rotate2D(x,y,a); 
	- x, y (vectors): original 3d points
	- a: angle to rotate CCW in degrees
    - xx, yy (vectors): rotated 3d points
