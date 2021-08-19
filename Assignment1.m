function Assignment1(folder)
    clc();
    %% Open and Load the Folder's Depth and RGB Images
    if ~exist('folder','var')
        disp('YOU must specify the folder, where the files are located!');
        disp('We assume some default folder:');
        folder = '.\data\HomeC002\';
    end
    disp('Using data from folder:');
    disp(folder);

    A = load([folder,'\PSLR_C01_120x160.mat']);
    CC = A.CC;
    A = load([folder,'\PSLR_D01_120x160.mat']);
    CR = A.CR;
    
    %% Global Variables
    global GUI; 
    GUI = [];
    GUI.PlayPause = 0;
    GUI.Close = 0;
    GUI.Pitch = 0;
    GUI.Roll = 0;
    GUI.AngleCorrect = 0;
    GUI.DetectUseful = 0;
    
    %% Creating Figures and Handles
    % For Depth and RGB Images
    figure(1); clf();

    % Display Depth Subfigure 
    subplot(211) ; 
    RR = CR.R(:,:,1);
    HandleDepth = imagesc(RR);
    title('Depth');
    colormap gray;
    set(gca(),'xdir','reverse');

    % Display RGB Image
    subplot(212) ;
    HandleRGB = image(CC.C(:,:,:,1));
    title('RGB');
    set(gca(),'xdir','reverse');

    % For Showing 3D Points
    figure(2); clf() ; 
    HandleAxes = axes('position',[0.20,0.1,0.75,0.85]);
    hold on;
    HandleFiltered = plot3(HandleAxes,0,0,0,'.','markersize',2) ; 
    HandleNotFiltered = plot3(HandleAxes,0,0,0,'.','markersize',2) ; 
    
    % Drawing Circle Markers
    t = 0:0.01:2*pi;
    xt = 0.5*cos(t);
    yt = 0.5*sin(t);
    xu = 2*cos(t);
    yu = 2*sin(t);
    z(1:length(xt)) = 0.15;
    plot3(xt,yt,z);
    plot3(xu,yu,z);
    
    % Axis Specifications
    hold off;
    axis([0,3,-1.5,1.5,-0.4,0.9]);
    title('3D');
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
    grid on;
    rotate3d on ;

    %% Control Buttons
    PlayPauseButton = uicontrol('Style','togglebutton');
    set(PlayPauseButton,'String','Play/Pause');
    set(PlayPauseButton,'Position',[10,1,80,20]);
    set(PlayPauseButton,'Callback',{@MyCallBackButton,1});
    
    StopButton = uicontrol('Style','pushbutton');
    set(StopButton,'String','Stop');
    set(StopButton,'Position',[90,1,80,20]);
    set(StopButton,'Callback',{@MyCallBackButton,2});
    
    PitchSlider = uicontrol('Style','slider');
    set(PitchSlider,'Position',[10,250,20,100]);
    set(PitchSlider,'Min',-45);
    set(PitchSlider,'Max',45);
    set(PitchSlider,'Callback',{@MyCallBackSlider,1});
    
    PitchSliderLabel = uicontrol('Style','text');
    set(PitchSliderLabel,'String','Pitch');
    set(PitchSliderLabel,'Position',[30,280,30,30]);
    
    PitchSliderMax = uicontrol('Style','text');
    set(PitchSliderMax,'String','45');
    set(PitchSliderMax,'Position',[30,320,30,30]);
    
    PitchSliderMin = uicontrol('Style','text');
    set(PitchSliderMin,'String','-45');
    set(PitchSliderMin,'Position',[30,240,30,30]);
    
    RollSlider = uicontrol('Style','slider');
    set(RollSlider,'Min',-45);
    set(RollSlider,'Max',45);
    set(RollSlider,'Position',[10,100,20,100]);
    set(RollSlider,'Callback',{@MyCallBackSlider,2});
    
    RollSliderLabel = uicontrol('Style','text');
    set(RollSliderLabel,'String','Roll');
    set(RollSliderLabel,'Position',[30,130,30,30]);
    
    RollSliderMax = uicontrol('Style','text');
    set(RollSliderMax,'String','45');
    set(RollSliderMax,'Position',[30,170,30,30]);
    
    RollSliderMin = uicontrol('Style','text');
    set(RollSliderMin,'String','-45');
    set(RollSliderMin,'Position',[30,90,30,30]);
    
    AngleCheckbox = uicontrol('Style','checkbox');
    set(AngleCheckbox,'String','Angle Correction');
    set(AngleCheckbox,'Position',[20,20,150,30]);
    set(AngleCheckbox,'Callback',{@MyCallBackCheckbox,1});
    
    UsefulCheckbox = uicontrol('Style','checkbox');
    set(UsefulCheckbox,'String','Detect Useful Points');
    set(UsefulCheckbox,'Position',[20,50,150,30]);
    set(UsefulCheckbox,'Callback',{@MyCallBackCheckbox,2});
    
    %% Plotting the 3D Points
    i = 0;
    while 1
        tic
        
        % Stop the Images and 3D Points After Reaching End
        i = i+1;
        if i > CR.N
            break;
        end
        
        % Pause the Images and 3D Points
        while GUI.PlayPause == 1
            pause(0.09);
            % Close the Images and 3D Points While Paused
            if GUI.Close == 1
                close all;
                return;
            end
        end
        
        % Close the Images and 3D Points
        if GUI.Close == 1
                close all;
                return;
        end
        
        % Refreshing Depth and RGB Images
        set(HandleRGB,'cdata',CC.C(:,:,:,i));
        RR = CR.R(:,:,i);
        set(HandleDepth,'cdata',RR);

        %% Processing 3D Points
        
        % Finding Pixels Which Are Not Faulty.
        iinz = find(RR>0);
        
        % Function Converts the Depth Data into 3D Points 
        [x,y,z] = ConvertSelectedDepthsTo3DPoints(single(RR)*0.001,iinz);
        
        % Adding GUI for Angle Correction
        if GUI.AngleCorrect == 0
            % Function Rotates 3D Plot by Corresponding Pitch and Roll
            % Through the Use of Slider
            [x1,y1,z1] = Rotate(x,y,z,GUI.Pitch,GUI.Roll);
        else
            % Function Compensates 10 Degrees of Pitch
            [x1,y1,z1] = Rotate(x,y,z,-10,0);
        end
        
        % Function Compensates for Platform's Height in 3D Plot
        [x2,y2,z2] = Translate(x1,y1,z1,-0.2);
        
        % Function Removes Points of No Interest
        [x3,y3,z3] = Useful(x2,y2,z2,-0.05,1);
        
        % Function Filters Useful Points in a Vertical Cylindrical Ring
        [xr,yr,zr,xb,yb,zb] = Filter(x3,y3,z3,0.5,2,0.15);
        
        %% Displaying the 3D Points
        % Changing the Colour of Useful Points and Updating Plot Handles
        if GUI.DetectUseful == 0
            set(HandleFiltered,'xdata',xr,'ydata',yr,'zdata',zr,'Color','b');
        else
            set(HandleFiltered,'xdata',xr,'ydata',yr,'zdata',zr,'Color','r');
        end
        set(HandleNotFiltered,'xdata',xb,'ydata',yb,'zdata',zb,'Color','b');
        
        % Freeze for About 0.093 seconds to Attain a Refresh Rate of 10 Hz
        pause(0.093);
        toc
    end
end

%% Callback Function Definitions
function MyCallBackButton(~,~,x)
    % Callback Function for Buttons
    global GUI;
    
    % Play/Pause Button
    if x == 1
       GUI.PlayPause = ~GUI.PlayPause;
       disp("Playback Status:");
       if GUI.PlayPause == 1
           disp("Paused")
       else
           disp("Playing")
       end
    end
    
    % Close Button
    if x == 2
        GUI.Close = 1;
        disp('Closing Program!');
    end
    return;
end

function MyCallBackSlider(a,~,x)
    % Callback Function for Sliders
    global GUI;  
    
    % Pitch Slider
    if x == 1
        disp("Pitch:");
        GUI.Pitch = get(a,'Value');
        disp(GUI.Pitch);
    end
    
    % Roll Slider
    if x == 2
        disp("Roll:");
        GUI.Roll = get(a,'Value');
        disp(GUI.Roll);
    end 
    return;    
end

function MyCallBackCheckbox(a,~,x)
    % Callback Function for Checkboxes
    global GUI; 
    
    % Angle Correction Checkbox
    if x == 1
        disp("Angle Correction:");
        GUI.AngleCorrect = get(a,'value');
       if GUI.AngleCorrect == 1
           disp("On");
       else
           disp("Off");
       end
    end
    
    % Detect Useful Points Checkbox
    if x == 2
        disp("Detect Useful Points:");
        GUI.DetectUseful = get(a,'value');
        if GUI.DetectUseful == 1
           disp("On");
       else
           disp("Off");
       end
    end
    return;    
end

%% Converting and Processing Functions Definitions
function [x,y,z] = ConvertSelectedDepthsTo3DPoints(R,ii)
    % Function Converts the Depth Image into 3D Coordinates Through a
    % Parameter Calibration Approximation
    [row,col] = ind2sub(size(R),ii);
    Depth = R(ii);
    
    x = Depth;
    y = Depth.*((col-80)*4/594);
    z = -Depth.*((row-60)*4/592);
end

function [xx,yy,zz] = Rotate(x,y,z,Pitch,Roll)
    % Function Rotates the 3D Points by Multiplying the Coordinates with a
    % Rotation Matrix which has its Pitch and Roll Defined
    FirstRow = [cosd(Pitch),sind(Roll)*sind(Pitch),cosd(Roll)*sind(Pitch)];
    SecondRow = [0,cosd(Roll),-sind(Roll)];
    ThirdRow = [-sind(Pitch),sind(Roll)*cosd(Pitch),cosd(Roll)*cosd(Pitch)];
    RotationMatrix = [FirstRow;SecondRow;ThirdRow];
    
    Rotated = [x,y,z]*RotationMatrix;
    xx = Rotated(:,1);
    yy = Rotated(:,2);
    zz = Rotated(:,3);
end

function [xx,yy,zz] = Translate(x,y,z,Height)
    % Function Moves the Graph Up and Down by the Corresponding Height
    xx = x;
    yy = y;
    zz = z - Height;
end

function [xx,yy,zz] = Useful(x,y,z,MinHeight,MaxHeight)
    % Function Keeps Points Greater than MinHeight and Less than MaxHeight
    zlogic = z >= MinHeight & z <= MaxHeight;
    xx = x(zlogic);
    yy = y(zlogic);
    zz = z(zlogic);
end

function [xin,yin,zin,xout,yout,zout] = Filter(x,y,z,MinRadius,MaxRadius,MinHeight)
    % Function Sorts the Points into Two Categories. The First Category 
    % Includes Points that are within the Min Radius and Max Radius while 
    % also Greater than the Min Height, while the Points in the Second
    % Category are Outside this Range
    xyzlogic = x.^2+y.^2 > MinRadius^2 & x.^2+y.^2 < MaxRadius^2 & z > MinHeight;
    xin = x(xyzlogic);
    yin = y(xyzlogic);
    zin = z(xyzlogic);
    xout = x(~xyzlogic);
    yout = y(~xyzlogic);
    zout = z(~xyzlogic);
end