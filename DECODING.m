function varargout = DECODING(varargin)
% DECODING MATLAB code for DECODING.fig
%      DECODING, by itself, creates a new DECODING or raises the existing
%      singleton*.
%
%      H = DECODING returns the handle to a new DECODING or the handle to
%      the existing singleton*.
%
%      DECODING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECODING.M with the given input arguments.
%
%      DECODING('Property','Value',...) creates a new DECODING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DECODING_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DECODING_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DECODING

% Last Modified by GUIDE v2.5 21-Dec-2020 16:50:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DECODING_OpeningFcn, ...
                   'gui_OutputFcn',  @DECODING_OutputFcn, ...
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


% --- Executes just before DECODING is made visible.
function DECODING_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DECODING (see VARARGIN)
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'ui'), 'value', 0);
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'LSB'), 'value', 0);
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'DWT'), 'value', 0);
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedsecretmessagelength'), 'string', '');
axes(handles.axes1); cla reset; imshow('logomdf.png');
yyy = imread('logo.png');

axes(handles.axes2);
imshow(yyy);
% Choose default command line output for DECODING
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DECODING wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DECODING_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla reset; imshow('logomdf.png');
set(handles.DWT,'Value',0);
set(handles.LSB,'Value',0);
set(handles.extractedmessage,'String','');
set(handles.extractedsecretmessagelength,'String','');
[filename ,pathname] = uigetfile({'*.jpg', 'JPEG'; '*.png', 'PNG'; '*.bmp', 'BMP'; '*.*', 'All Files'},'File Selector');
if filename==0
    errordlg('Stego Image is not selected.','Error');
else

StegoImage = strcat(pathname, filename);
 axes(handles.axes1);
 imshow(StegoImage);
 StegoImage1=imread(StegoImage);
 imwrite(StegoImage1,'stegoimage.png');
end
 


function extractedmessage_Callback(hObject, eventdata, handles)
% hObject    handle to extractedmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of extractedmessage as text
%        str2double(get(hObject,'String')) returns contents of extractedmessage as a double


% --- Executes during object creation, after setting all properties.
function extractedmessage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to extractedmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function extractedsecretmessagelength_Callback(hObject, eventdata, handles)
% hObject    handle to extractedsecretmessagelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of extractedsecretmessagelength as text
%        str2double(get(hObject,'String')) returns contents of extractedsecretmessagelength as a double


% --- Executes during object creation, after setting all properties.
function extractedsecretmessagelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to extractedsecretmessagelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in extract.
function extract_Callback(hObject, eventdata, handles)
% hObject    handle to extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lsbclick=get(handles.LSB,'Value');
dwtclick=get(handles.DWT,'Value');
if lsbclick==1
    Wait_Bar=waitbar(0,'Please wait...','WindowStyle', 'modal');
pause(.5)
waitbar(0,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal');
pause(.5)
   outputMessage = [];
   eof= 'þ';
cover=imread('stegoimage.png');
 waitbar(0.3,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal');
   pause(.5)
for i = 1:8:numel(cover)
    chars = bitget(cover(i:i+7),1);
    chars = bin2dec(num2str(chars));
    if(chars == eof)
        break;
    else
        outputMessage(end+1) = chars;
    end
    
end
waitbar(0.7,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal');
pause(.5)
outputMessage = char(outputMessage);
set(handles.extractedmessage,'Max',2);
set(handles.extractedmessage,'String',outputMessage);
waitbar(0.9,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal');
pause(.5)
set(handles.extractedsecretmessagelength,'String',length(outputMessage));
waitbar(1,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal');
pause(.5)
close(Wait_Bar);
end

if dwtclick==1
Wait_Bar1=waitbar(0,'Please wait...','WindowStyle', 'modal');
pause(.5)
       image = imread('stegoimage.png');

    % convert to YCbCr color space
    image_ycbcr = rgb2ycbcr(image);
waitbar(0.3,Wait_Bar1,'Extracting Secret Message...','WindowStyle', 'modal');
pause(.5)
    % extract blue-difference chroma
    cb = image_ycbcr(:, :, 2);

    % construct Haar wavelet
    haar_wavelet = liftwave('haar', 'Int2Int');
    
    % apply DWT to the input image, on Cb channel
    % L/H = Low/High
    % LL = approximation coefficients
    % HL/LH/HH = detail coefficients
    [LL, HL, LH, HH] = lwt2(double(cb), haar_wavelet);

    % read from HH/HL regions
    HH_flat = reshape(HH.', 1, []);
    HL_flat = reshape(HL.', 1, []);

    % store the number of chars as the first `size_length` bytes
    size_length = 4;
    char_count = bi2de(HH_flat(1:size_length * 8));

    bin_text = zeros(char_count, 8);

    HH_can_fit = length(HH_flat) / 8;
    HH_limit = min(char_count + size_length, HH_can_fit);

    for i = size_length + 1:HH_limit
        bin_text(i-size_length, :) = abs(HH_flat((i-1)*8+1:(i-1)*8+8));
    end

    % HH couldn't contain the entire text, also read from HL
    rest = char_count + size_length - HH_can_fit;
    if (rest > 0)
        for i = 1:rest
            bin_text(i-size_length+HH_limit, :) = abs(HL_flat((i-1)*8+1:(i-1)*8+8));
        end
    end
waitbar(0.7,Wait_Bar1,'Extracting Secret Message...','WindowStyle', 'modal');
pause(.5)
    % convert text from binary to ascii
    text = char(bi2de(bin_text(:,:)))';

set(handles.extractedmessage,'Max',2);
set(handles.extractedmessage,'String',text);
waitbar(0.9,Wait_Bar1,'Extracting Secret Message...','WindowStyle', 'modal');
pause(.5)
set(handles.extractedsecretmessagelength,'String',length(text));
waitbar(1,Wait_Bar1,'Completed','WindowStyle', 'modal');
pause(.5)
close(Wait_Bar1);
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'LSB'), 'value', 0);
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'DWT'), 'value', 0);
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedsecretmessagelength'), 'string', '');
axes(handles.axes1); cla reset;imshow('logomdf.png');


% --- Executes on button press in LSB.
function LSB_Callback(hObject, eventdata, handles)
% hObject    handle to LSB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LSB
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedsecretmessagelength'), 'string', '');
%axes(handles.axes1); cla reset;imshow('logomdf.png');


% --- Executes on button press in DWT.
function DWT_Callback(hObject, eventdata, handles)
% hObject    handle to DWT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DWT
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedsecretmessagelength'), 'string', '');
%axes(handles.axes1); cla reset;imshow('logomdf.png');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(DECODING);
DISGUISE;
