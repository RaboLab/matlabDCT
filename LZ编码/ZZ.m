function varargout = ZZ(varargin)
% ZZ M-file for ZZ.fig
%      ZZ, by itself, creates a new ZZ or raises the existing
%      singleton*.
%
%      H = ZZ returns the handle to a new ZZ or the handle to
%      the existing singleton*.
%
%      ZZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZZ.M with the given input arguments.
%
%      ZZ('Property','Value',...) creates a new ZZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ZZ_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ZZ_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ZZ


% Begin initialization code 初始化编码
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ZZ_OpeningFcn, ...
                   'gui_OutputFcn',  @ZZ_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1}) %nargin判断输入变量个数，varargin函数输入参数
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% 初始化编码结束


% --- 使ZZ生效
function ZZ_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ZZ (see VARARGIN)

% Choose default command line output for ZZ
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ZZ wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ZZ_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% ---使pushbutton1（开始编码）生效.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%LZ encode main function
clc;
%打开source文件
fid=fopen('source.txt','r');
seq=fread(fid);
fclose(fid);
seq=reshape(seq,1,length(seq));
if ~isempty(seq)
    [entropy]=Entropy(seq); 
    [dictionary codelength]=LZcode(seq);
    %calculate the efficiency, and display the entropy,average length
    %as well as efficiency
    avglength=((codelength*length(dictionary))/length(seq));
    %efficiency=(entropy/avglength);
    l1=num2str(entropy);
   l2=num2str(codelength); 
   set(handles.edit2,'string',l1);
   set(handles.edit1,'string',l2);
    %disp(strcat('Efficiency = ',num2str(efficiency)));
    %将函数与GUI界面上控件联系
    %编码
    disp('Encoded Sequence : Look encode.txt.');
    enseq=LZencode(dictionary);
    fiden=fopen('encode.txt','w');
    en=fwrite(fiden,enseq);
    fclose(fiden);
    %解码
    display('Decoded Sequence : Look decode.txt.');
    deseq=LZdecode(dictionary);
    fidde=fopen('decode.txt','w');
    de=fwrite(fidde,deseq);
    fclose(fiden);        
else
    display('Empty Sequence....');
end

% ---使pushbutton2（复位）生效
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'string',' ');
set(handles.edit2,'string',' ');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- 使pushbutton4（退出）生效
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
