function varargout = AssignmentTest(varargin)
%AssignmentTest MATLAB code file for AssignmentTest.fig
%      AssignmentTest, by itself, creates a new AssignmentTest or raises the existing
%      singleton*.
%
%      H = AssignmentTest returns the handle to a new AssignmentTest or the handle to
%      the existing singleton*.
%
%      AssignmentTest('Property','Value',...) creates a new AssignmentTest using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to AssignmentTest_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      AssignmentTest('CALLBACK') and AssignmentTest('CALLBACK',hObject,...) call the
%      local function named CALLBACK in AssignmentTest.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AssignmentTest

% Last Modified by GUIDE v2.5 11-Oct-2019 22:03:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AssignmentTest_OpeningFcn, ...
                   'gui_OutputFcn',  @AssignmentTest_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

% --- Executes just before AssignmentTest is made visible.
function AssignmentTest_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   unrecognized PropertyName/PropertyValue pairs from the
    %            command line (see VARARGIN)

    % Choose default command line output for AssignmentTest
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes AssignmentTest wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = AssignmentTest_OutputFcn(hObject, eventdata, handles)
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --- Executes on slider movement.
function RollSlider_Callback(hObject, eventdata, handles)
    % hObject    handle to RollSlider (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end

% --- Executes during object creation, after setting all properties.
function RollSlider_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to RollSlider (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end
end

% --- Executes on button press in DetectUsefulPoints.
function DetectUsefulPoints_Callback(hObject, eventdata, handles)
    % hObject    handle to DetectUsefulPoints (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of DetectUsefulPoints
end

% --- Executes on button press in AngleCorrection.
function AngleCorrection_Callback(hObject, eventdata, handles)
    % hObject    handle to AngleCorrection (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of AngleCorrection
end

% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
    % hObject    handle to Close (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in PlayPause.
function PlayPause_Callback(hObject, eventdata, handles)
    % hObject    handle to PlayPause (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of PlayPause
end

% --- Executes on slider movement.
function PitchSlider_Callback(hObject, eventdata, handles)
    % hObject    handle to PitchSlider (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end

% --- Executes during object creation, after setting all properties.
function PitchSlider_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to PitchSlider (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end
end


