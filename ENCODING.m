function varargout = ENCODING(varargin)
% ENCODING MATLAB code for ENCODING.fig
%      ENCODING, by itself, creates a new ENCODING or raises the existing
%      singleton*.
%
%      H = ENCODING returns the handle to a new ENCODING or the handle to
%      the existing singleton*.
%
%      ENCODING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENCODING.M with the given input arguments.
%
%      ENCODING('Property','Value',...) creates a new ENCODING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ENCODING_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ENCODING_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ENCODING

% Last Modified by GUIDE v2.5 21-Dec-2020 16:03:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ENCODING_OpeningFcn, ...
                   'gui_OutputFcn',  @ENCODING_OutputFcn, ...
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


% --- Executes just before ENCODING is made visible.
function ENCODING_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ENCODING (see VARARGIN)

% Choose default command line output for ENCODING
handles.output = hObject;

set( findobj(gcf, 'type', 'uicontrol', 'tag', 'selectedsecretmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'newselectedsecretmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'secretmessagelength'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'secretmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedsecretmessagelength'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'Imageresolution'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'psnrvalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'ssimvalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'msevalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'LSB'), 'value', 0);
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'DWT'), 'value', 0);
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'lsbcap'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'dwtcap'), 'string', '');
%set(handles.message_length.String , '');
axes(handles.axes1); cla reset; imshow('logomdf.png');
axes(handles.axes2); cla reset;imshow('logomdf.png');
axes(handles.axes3); cla reset;imshow('logomdf.png');
axes(handles.axes4); cla reset;imshow('logomdf.png');
yyy = imread('logo.png');
%yy = imresize(yyy, [50 50]);
axes(handles.axes5);
imshow(yyy);
set(handles.slider1,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ENCODING wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ENCODING_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BROWSE.
function BROWSE_Callback(hObject, eventdata, handles)
% hObject    handle to BROWSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(handles.BROWSE,'Value',1);
set(handles.secretmessage,'String','');
set(handles.secretmessagelength,'String','');
set(handles.selectedsecretmessage,'String','');
set(handles.newselectedsecretmessage,'String','');

[filename, pathname] = uigetfile({'*.txt'},'Open File'); 
if filename==0
   
    errordlg('Secret Message File is not selected.','Error', 'modal');
else
assignin('base','filename',filename);

f = waitbar(0,'Please wait...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
waitbar(.10,f,'Loading Text File...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
Message_file= fopen(filename,'rt');
Secret_message = fscanf(Message_file,'%c');
fclose(Message_file);
waitbar(.30,f,'Loading Text File...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(1)
set(handles.secretmessage,'Max',2);
set(handles.secretmessage,'String',Secret_message);
waitbar(.30,f,'Loading Text File...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(1)
waitbar(.80,f,'Calculating Length of Text File...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(1)
set(handles.secretmessagelength,'String',length(Secret_message));


waitbar(1,f,'Completed','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
close(f)
x=get(handles.secretmessage,'String');
if isempty(x)
set(handles.slider1,'Enable','off');
msgbox('Selected Text File is Empty. Please Choose a Valid Text File','Error','Error')
end
if ~isempty(x)
set(handles.slider1,'Enable','on');
set(handles.slider1,'Value',0);
end
end


% --- Executes on button press in BROWSECOVER.
function BROWSECOVER_Callback(hObject, eventdata, handles)
% hObject    handle to BROWSECOVER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.lsbcap,'String','');
set(handles.dwtcap,'String','');
set(handles.LSB,'Value',0);
set(handles.DWT,'Value',0);
set(handles.hresolution,'String','');
set(handles.wresolution,'String','');
axes(handles.axes1); cla reset; imshow('logomdf.png');
axes(handles.axes2); cla reset;imshow('logomdf.png');
axes(handles.axes3); cla reset; imshow('logomdf.png');
axes(handles.axes4); cla reset;imshow('logomdf.png');
[filename ,pathname] = uigetfile({'*.jpg', 'JPEG'; '*.png', 'PNG'; '*.bmp', 'BMP';'*.tif', 'TIF'; '*.*', 'All Files'},'File Selector');
if filename==0 
    errordlg('Cover Image is not selected.','Error','modal');
else
handles.CoverImage = strcat(pathname, filename);
Wait_Bar=waitbar(0,'Please wait...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
 waitbar(.30,Wait_Bar,'Loading Cover Image...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
 axes(handles.axes1);
 imshow(handles.CoverImage);
waitbar(.50,Wait_Bar,'Calculating Image Resolution... ','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5);
 imginfo = imfinfo(handles.CoverImage);
imgwidth = imginfo.Width;
imgheight = imginfo.Height;
set(handles.hresolution,'String',num2str(imgwidth));
set(handles.wresolution,'String',num2str(imgheight));
waitbar(.70,Wait_Bar,'Calculating Maximum Payload Capacity... ','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
lsb_capacity=num2str(round(imgwidth*imgheight*24/64));
set(handles.lsbcap,'String',lsb_capacity);


 image = imread(handles.CoverImage);
 image_ycbcr = rgb2ycbcr(image);
% extract blue-difference chroma
    cb = image_ycbcr(:, :, 2);
    % construct Haar wavelet
    haar_wavelet = liftwave('haar', 'Int2Int');
    [LL, HL, LH, HH] = lwt2(double(cb), haar_wavelet);

    % Hide text in HH and HL regions
    [~, HH_width] = size(HH);
    [~, HL_width] = size(HL);

HH_flat = reshape(HH.', 1, []);
%HL_flat = reshape(HL.', 1, []);   
%HH_flat(1:size_length * 8) = de2bi(char_count, size_length * 8);
HH_can_fit = length(HH_flat) / 8;
%HH_limit = min(char_count + size_length, HH_can_fit);
dwt_capacity=num2str(round(HH_can_fit*2-4));
set(handles.dwtcap,'String',dwt_capacity);
waitbar(.85,Wait_Bar,'Plotting Histogram...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(1)
img_read=imread(handles.CoverImage);
red=img_read( : , : , 1);
green=img_read( : , : , 2);
blue=img_read( : , : , 3);
h=cat(2,red,green,blue);
axes(handles.axes2);
imhist(h,255);
colorbar('off');

waitbar(1,Wait_Bar,'Completed','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
close(Wait_Bar);
 % save the updated handles object
 guidata(hObject,handles);
end
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
maxlength=str2double(get(handles.secretmessagelength,'String'));
set(handles.slider1, 'Max',maxlength,'Min',0);
set(handles.slider1, 'SliderStep' , [1,0.1] );
newval = hObject.Value;                         %get value from the slider
newval = round(newval);                         %round off this value
set(hObject, 'Value', newval);  
sliderValue = get(handles.slider1,'Value');
set(handles.selectedsecretmessage,'String',sliderValue);

filename=evalin('base','filename');

Message_file= fopen(filename,'rt');
selected_text = (dec2bin(fread(Message_file(:,1))'));
selected_text=char(bin2dec(selected_text(:,:)))';
new_selected_text = selected_text(1:sliderValue);
set(handles.newselectedsecretmessage,'Max',2);
set(handles.newselectedsecretmessage,'string',new_selected_text);
fid = fopen('secret_selected_msg.txt', 'wt');
fprintf(fid,new_selected_text);
fclose(fid);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.8 .88 1]);
end



function secretmessage_Callback(hObject, eventdata, handles)
% hObject    handle to secretmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of secretmessage as text
%        str2double(get(hObject,'String')) returns contents of secretmessage as a double


% --- Executes during object creation, after setting all properties.
function secretmessage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secretmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function Imageresolution_Callback(hObject, eventdata, handles)
% hObject    handle to Imageresolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Imageresolution as text
%        str2double(get(hObject,'String')) returns contents of Imageresolution as a double


% --- Executes during object creation, after setting all properties.
function Imageresolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Imageresolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LSB.
function LSB_Callback(hObject, eventdata, handles)
% hObject    handle to LSB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LSB
axes(handles.axes3); cla reset; imshow('logomdf.png');
axes(handles.axes4); cla reset; imshow('logomdf.png');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'psnrvalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'ssimvalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'msevalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedsecretmessagelength'), 'string', '');
a=str2double(get(handles.lsbcap,'String'));
sliderValue = get(handles.slider1,'Value');
if sliderValue>a
   msg_box= errordlg('Maximum LSB Payload Capacity Exceeded.','Warning');
    pause(1.5)
    close(msg_box);
    msg_box_=errordlg('Please Select text less than Maximum Payload Capacity ', 'Warning');
    pause(1.5)
    set(handles.slider1,'Value',0);
    set(handles.LSB,'Value',0);
    set(handles.DWT,'Value',0);
    set( handles.selectedsecretmessage, 'string', '');
    set( handles.newselectedsecretmessage, 'string', '');
    close(msg_box_);
else
 Wait_Bar=waitbar(0,'Please wait...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
image = imread(handles.CoverImage);
    cover = image ;
file= fopen('secret_selected_msg.txt','rt');
%Save message as a char array
message = fread(file,'char');
%Close file
fclose(file);
    %message = input_text_path;
  eof = 'þ';
messageText = [message;eof];
waitbar(0.30,Wait_Bar,'Encoding...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
%Each character needs to be converted into 8-bit binary form
binary = transpose(dec2bin(messageText,8));
%Find the least-significant bits to be set to one or zero.
zeroBit = find(binary == '0');
oneBit = find(binary == '1');
%Set the values of the least-significant bits
cover(zeroBit) = bitset(cover(zeroBit),1,0);
cover(oneBit) = bitset(cover(oneBit),1,1);
waitbar(0.70,Wait_Bar,'Stego Image Generation...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
StegoImage = 'lsbstegoimage.png';
imwrite(cover,StegoImage);
axes(handles.axes3);
imshow(StegoImage);
waitbar(0.80,Wait_Bar,'Histogram Plotting...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
stegoimg=imread('lsbstegoimage.png');
red=stegoimg( : , : , 1);
green=stegoimg( : , : , 2);
blue=stegoimg( : , : , 3);
h=cat(2,red,green,blue);
axes(handles.axes4);
imhist(h,255)
waitbar(1,Wait_Bar,'Complete','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
close(Wait_Bar);
end
% --- Executes on button press in DWT.
function DWT_Callback(hObject, eventdata, handles)
% hObject    handle to DWT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DWT
axes(handles.axes3); cla reset; imshow('logomdf.png');
axes(handles.axes4); cla reset; imshow('logomdf.png');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'psnrvalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'ssimvalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'msevalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedsecretmessagelength'), 'string', '');
a=str2double(get(handles.dwtcap,'String'));
sliderValue = get(handles.slider1,'Value');
if sliderValue>a
   msg_box= errordlg('Maximum DWT Payload Capacity Exceeded.','Warning');
    pause(1.5)
    close(msg_box);
    msg_box_=errordlg('Please Select text less than Maximum Payload Capacity ','Warning');
    pause(1.5)
    set(handles.slider1,'Value',0);
    set(handles.LSB,'Value',0);
    set(handles.DWT,'Value',0);
    set( handles.selectedsecretmessage, 'string', '');
    set( handles.newselectedsecretmessage, 'string', '');
    close(msg_box_);
else
 Wait_Bar=waitbar(0,'Please wait...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
 image = imread(handles.CoverImage);
   
    
    %fid = get(handles.newselectedsecretmessage,'String');
   fid = fopen('secret_selected_msg.txt', 'rt');
    text = fread(fid, inf, 'uint8');
    bin_text = de2bi(text, 8);

    [char_count, ~] = size(bin_text);
waitbar(0.30,Wait_Bar,'Encoding...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
    % convert to YCbCr color space
    image_ycbcr = rgb2ycbcr(image);

    % extract blue-difference chroma
    cb = image_ycbcr(:, :, 2);

    % construct Haar wavelet
    haar_wavelet = liftwave('haar', 'Int2Int');

    % apply DWT to the input image, on Cb channel
    % L/H = Low/High
    % LL = approximation coefficients
    % HL/LH/HH = detail coefficients
    [LL, HL, LH, HH] = lwt2(double(cb), haar_wavelet);

    % Hide text in HH and HL regions
    [~, HH_width] = size(HH);
    [~, HL_width] = size(HL);

    HH_flat = reshape(HH.', 1, []);
    HL_flat = reshape(HL.', 1, []);
    
    size_length = 4;
    overwhelmed = (8 * char_count + 8 * size_length) > (length(HH_flat) + length(HL_flat));
    
    
    if (overwhelmed)
        %err_msg=('Text length is too large to be embedded! Please set the slider value less than maximum hiding capacity....');
        disp('Text length is too large to be embedded!');
       
    else
        % store the number of chars as the first `size_length` bytes
        
        HH_flat(1:size_length * 8) = de2bi(char_count, size_length * 8);

        HH_can_fit = length(HH_flat) / 8;

        HH_limit = min(char_count + size_length, HH_can_fit);

        % encode in HH (first 2 bytes = size)
        for i = size_length + 1:HH_limit
            HH_flat((i-1)*8 + 1:(i-1)*8 + 8) = bin_text(i-size_length, :);
        end

        % if HH can't contain all, also use HL
        rest = char_count + size_length - HH_can_fit;
        if (rest > 0)
            for i = 1:rest
                HL_flat((i-1)*8+1:(i-1)*8+8) = bin_text(i-size_length+HH_limit, :);
            end
        end
    end

    % restore matrix dimensions
    HH = vec2mat(HH_flat, HH_width);
    HL = vec2mat(HL_flat, HL_width);
waitbar(0.70,Wait_Bar,'Stego Image Generation...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
    % output final image
    output_image_path = 'dwtstegoimage.png';
    image_ycbcr(:, :, 2) = ilwt2(LL, HL, LH, HH, haar_wavelet);
    out_image = ycbcr2rgb(image_ycbcr);
    imwrite(out_image, output_image_path);
     StegoImage = 'dwtstegoimage.png';
    imwrite(out_image,StegoImage);
    axes(handles.axes3);
    imshow(StegoImage);
waitbar(0.80,Wait_Bar,'Histogram Plotting...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
stegoimg=imread('dwtstegoimage.png');
red=stegoimg( : , : , 1);
green=stegoimg( : , : , 2);
blue=stegoimg( : , : , 3);
h=cat(2,red,green,blue);
axes(handles.axes4);
imhist(h,255);
colorbar('off');
waitbar(1,Wait_Bar,'Complete','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
close(Wait_Bar);
end


function psnrvalue_Callback(hObject, eventdata, handles)
% hObject    handle to psnrvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psnrvalue as text
%        str2double(get(hObject,'String')) returns contents of psnrvalue as a double


% --- Executes during object creation, after setting all properties.
function psnrvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psnrvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function msevalue_Callback(hObject, eventdata, handles)
% hObject    handle to psnrvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psnrvalue as text
%        str2double(get(hObject,'String')) returns contents of psnrvalue as a double




% --- Executes during object creation, after setting all properties.
function msevalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psnrvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in RESET.
function RESET_Callback(hObject, eventdata, handles)
% hObject    handle to RESET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'selectedsecretmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'newselectedsecretmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'secretmessagelength'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'secretmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedmessage'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'extractedsecretmessagelength'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'hresolution'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'wresolution'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'psnrvalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'ssimvalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'msevalue'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'lsbcap'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'dwtcap'), 'string', '');
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'LSB'), 'value', 0);
set( findobj(gcf, 'type', 'uicontrol', 'tag', 'DWT'), 'value', 0);
%set(handles.message_length.String , '');
axes(handles.axes1); cla reset; imshow('logomdf.png');
axes(handles.axes2); cla reset; imshow('logomdf.png');
axes(handles.axes3); cla reset; imshow('logomdf.png');
axes(handles.axes4); cla reset; imshow('logomdf.png');

set(handles.slider1, 'Value',0 );

% --- Executes on button press in EXTRACT.
function EXTRACT_Callback(hObject, eventdata, handles)
% hObject    handle to EXTRACT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
lsbclick=get(handles.LSB,'Value');
dwtclick=get(handles.DWT,'Value');
if lsbclick==1
Wait_Bar=waitbar(0,'Please wait...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
waitbar(0,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
   outputMessage = [];
   eof= 'þ';
   cover=imread('lsbstegoimage.png');
   waitbar(0.3,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal','Name','DISGUISE Processing...');
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
waitbar(0.7,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
outputMessage = char(outputMessage);
set(handles.extractedmessage,'Max',2);
set(handles.extractedmessage,'String',outputMessage);
waitbar(0.9,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
set(handles.extractedsecretmessagelength,'String',length(outputMessage));

waitbar(1,Wait_Bar,'Extracting Secret Message...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
close(Wait_Bar);
fid = fopen('secret1.txt', 'wt');
fprintf(fid,outputMessage);
fclose(fid);

end

if dwtclick==1
Wait_Bar1=waitbar(0,'Please wait...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
     image = imread('dwtstegoimage.png');
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
waitbar(0.7,Wait_Bar1,'Extracting Secret Message...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
    % convert text from binary to ascii
    text = char(bi2de(bin_text(:,:)))';

set(handles.extractedmessage,'Max',2);
set(handles.extractedmessage,'String',text)
waitbar(0.9,Wait_Bar1,'Extracting Secret Message...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
set(handles.extractedsecretmessagelength,'String',length(text));

waitbar(1,Wait_Bar1,'Completed','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
close(Wait_Bar1);
fid = fopen('secret1.txt', 'wt');
fprintf(fid,text);
fclose(fid);
end



function selectedsecretmessage_Callback(hObject, eventdata, handles)
% hObject    handle to selectedsecretmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selectedsecretmessage as text
%        str2double(get(hObject,'String')) returns contents of selectedsecretmessage as a double


% --- Executes during object creation, after setting all properties.
function selectedsecretmessage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectedsecretmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function secretmessagelength_Callback(hObject, eventdata, handles)
% hObject    handle to secretmessagelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of secretmessagelength as text
%        str2double(get(hObject,'String')) returns contents of secretmessagelength as a double


% --- Executes during object creation, after setting all properties.
function secretmessagelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secretmessagelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function mse_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to MSEVALUE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function newselectedsecretmessage_Callback(hObject, eventdata, handles)
% hObject    handle to newselectedsecretmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of newselectedsecretmessage as text
%        str2double(get(hObject,'String')) returns contents of newselectedsecretmessage as a double


% --- Executes during object creation, after setting all properties.
function newselectedsecretmessage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to newselectedsecretmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in psnr.
function psnr_Callback(hObject, eventdata, handles)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Wait_Bar=waitbar(0,'Please wait...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
 waitbar(0,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
in=imread(handles.CoverImage);
lsbclick=get(handles.LSB,'Value');
dwtclick=get(handles.DWT,'Value');
 waitbar(0.2,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.3)
if lsbclick==1
o=imread('lsbstegoimage.png');
end
if dwtclick==1
o=imread('dwtstegoimage.png');
end
 waitbar(0.4,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.3)
[row col] = size(o);

original=double(in);
target=double(o);
mse = 0;
for i=1:row
    for j=1:col
        d1=target(i,j);
        
        d2=original(i,j);
        
        mse=mse+(d1-d2)^2;
    end
end
 waitbar(0.8,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.3)
mse=mse/(row*col);
k=10*log10((255^2)/mse);
 waitbar(0.95,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.3)
num2str(set(handles.psnrvalue,'String',k));
 waitbar(1,Wait_Bar,'Complete','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
 close(Wait_Bar);

% --- Executes on button press in mse.
function mse_Callback(hObject, eventdata, handles)
% hObject    handle to mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Wait_Bar=waitbar(0,'Please wait...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
 waitbar(0,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
x=imread(handles.CoverImage);
lsbclick=get(handles.LSB,'Value');
dwtclick=get(handles.DWT,'Value');
if lsbclick==1
y=imread('lsbstegoimage.png');
end
if dwtclick==1
y=imread('dwtstegoimage.png');
end
 waitbar(0.4,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.3)
m=mse(x,y);
i1=0;
for i=m
    i1=i1+i
end
waitbar(0.8,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.3)
i=i/3;
 waitbar(0.95,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.3)
num2str(set(handles.msevalue,'String',i));
 waitbar(1,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
 close(Wait_Bar);


% --- Executes during object creation, after setting all properties.
function psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function ssimvalue_Callback(hObject, eventdata, handles)
% hObject    handle to ssimvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ssimvalue as text
%        str2double(get(hObject,'String')) returns contents of ssimvalue as a double


% --- Executes during object creation, after setting all properties.
function ssimvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ssimvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ssim.
function ssim_Callback(hObject, eventdata, handles)
% hObject    handle to ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Wait_Bar=waitbar(0,'Please wait...','WindowStyle', 'modal','Name','DISGUISE Processing...');
pause(.5)
 waitbar(0,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
Cover_Image=imread(handles.CoverImage);
lsbclick=get(handles.LSB,'Value');
dwtclick=get(handles.DWT,'Value');
 waitbar(0.5,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.3)
if lsbclick==1
lsb_stego_image=imread('lsbstegoimage.png');
ssimval = ssim(Cover_Image,lsb_stego_image);
end
if dwtclick==1
dwt_stego_image=imread('dwtstegoimage.png');
ssimval = ssim(Cover_Image,dwt_stego_image);
end
 waitbar(0.9,Wait_Bar,'Calculating...','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
set(handles.ssimvalue,'String',ssimval);
 waitbar(1,Wait_Bar,'Complete','WindowStyle', 'modal','Name','DISGUISE Processing...');
 pause(.5)
 close(Wait_Bar);

% --- Executes on button press in selectstegofolder.
function selectstegofolder_Callback(hObject, eventdata, handles)
% hObject    handle to selectstegofolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

lsbclick=get(handles.LSB,'Value');
dwtclick=get(handles.DWT,'Value');
if lsbclick==1
    lsbstegoimg=('lsbstegoimage.png');
    destinationPath =  uigetdir('C:/Users/Rakesh Kumar/Desktop/stego img/','*.*');
    if destinationPath==0
        errordlg('Folder is not selected.','Error','modal');
    else
    copyfile(lsbstegoimg,destinationPath,'f');
     a=msgbox('Stego Image is Successfully Saved.','Success');
     pause(1.5)
     close(a);
    end
end
if dwtclick==1
    dwtstegoimg=('dwtstegoimage.png');
    destinationPath =  uigetdir('C:/Users/Rakesh Kumar/Desktop/stego img/','*.*');
     if destinationPath==0
        errordlg('Folder is not selected.','Error','modal');
    else
    copyfile(dwtstegoimg,destinationPath,'f');
    a=msgbox('Stego Image is Successfully Saved.','Success');
    pause(1.5)
    close(a);

     end
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



function hresolution_Callback(hObject, eventdata, handles)
% hObject    handle to hresolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hresolution as text
%        str2double(get(hObject,'String')) returns contents of hresolution as a double


% --- Executes during object creation, after setting all properties.
function hresolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hresolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wresolution_Callback(hObject, eventdata, handles)
% hObject    handle to wresolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wresolution as text
%        str2double(get(hObject,'String')) returns contents of wresolution as a double


% --- Executes during object creation, after setting all properties.
function wresolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wresolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in lsbcapacity.
function lsbcapacity_Callback(hObject, eventdata, handles)
% hObject    handle to lsbcapacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function lsbcap_Callback(hObject, eventdata, handles)
% hObject    handle to lsbcap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lsbcap as text
%        str2double(get(hObject,'String')) returns contents of lsbcap as a double


% --- Executes during object creation, after setting all properties.
function lsbcap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lsbcap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dwtcapacity.
function dwtcapacity_Callback(hObject, eventdata, handles)
% hObject    handle to dwtcapacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function dwtcap_Callback(hObject, eventdata, handles)
% hObject    handle to dwtcap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dwtcap as text
%        str2double(get(hObject,'String')) returns contents of dwtcap as a double


% --- Executes during object creation, after setting all properties.
function dwtcap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dwtcap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in backtomainscreen.
function backtomainscreen_Callback(hObject, eventdata, handles)
% hObject    handle to backtomainscreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(ENCODING);
DISGUISE;
