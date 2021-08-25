function varargout = DISGUISE(varargin)
% DISGUISE MATLAB code for DISGUISE.fig
%      DISGUISE, by itself, creates a new DISGUISE or raises the existing
%      singleton*.
%
%      H = DISGUISE returns the handle to a new DISGUISE or the handle to
%      the existing singleton*.
%
%      DISGUISE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISGUISE.M with the given input arguments.
%
%      DISGUISE('Property','Value',...) creates a new DISGUISE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DISGUISE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DISGUISE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DISGUISE

% Last Modified by GUIDE v2.5 22-Dec-2020 07:58:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DISGUISE_OpeningFcn, ...
                   'gui_OutputFcn',  @DISGUISE_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before DISGUISE is made visible.
function DISGUISE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DISGUISE (see VARARGIN)

% Choose default command line output for DISGUISE
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

myImage = imread('logo.png');
set(handles.axes9,'Units','pixels');
resizePos = get(handles.axes9,'Position');
myImage= imresize(myImage, [resizePos(3) resizePos(3)]);
axes(handles.axes9);
imshow(myImage);
set(handles.axes9,'Units','normalized');
%aa = evalin('basevalue',aaa);
%if aa == 0
    %set(handles.text1,'ForegroundColor',[1 0 0]);
    %pause(0.2);
    %set(handles.text1,'ForegroundColor',[0 1 0]);
    %pause(0.2);
    %set(handles.text1,'ForegroundColor',[0 0 1]);
   % pause(0.2);
    %else  
     %return;
%end


 
     


    
% UIWAIT makes DISGUISE wait for user response (see UIRESUME)
 %uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = DISGUISE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output


% --- Executes on button press in enc.
function enc_Callback(hObject, eventdata, handles)
% hObject    handle to enc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(DISGUISE);
ENCODING;

% --- Executes on button press in dec.
function dec_Callback(hObject, eventdata, handles)
% hObject    handle to dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(DISGUISE);
DECODING;


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
answer = questdlg('Would you like to EXIT?', ...
	'Confirm', ...
	'Yes','No','No');
% Handle response
switch answer
    case 'Yes'
        close(DISGUISE);
    case 'No'
        close(questdlg);

 end

