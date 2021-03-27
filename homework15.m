function varargout = homework15(varargin)
% HOMEWORK15 MATLAB code for homework15.fig
%      HOMEWORK15, by itself, creates a new HOMEWORK15 or raises the existing
%      singleton*.
%
%      H = HOMEWORK15 returns the handle to a new HOMEWORK15 or the handle to
%      the existing singleton*.
%
%      HOMEWORK15('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOMEWORK15.M with the given input arguments.
%
%      HOMEWORK15('Property','Value',...) creates a new HOMEWORK15 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before homework15_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to homework15_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help homework15

% Last Modified by GUIDE v2.5 24-Dec-2020 22:11:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @homework15_OpeningFcn, ...
                   'gui_OutputFcn',  @homework15_OutputFcn, ...
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


% --- Executes just before homework15 is made visible.
function homework15_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to homework15 (see VARARGIN)
[y,fs]=audioread('1.wav');
real=y(100001:100100,1);
max_value=max(abs(real));
outlier_value=0.8*max_value;
x=1:100;
random_num = sort(x(randperm(numel(x),10)));
%error=awgn(real,15,'measured');
error=add_noise(real,15);
for i=1:10
    error(random_num(i))=min(outlier_value+error(random_num(i)),max_value);
end
axes(handles.axes1);
time_x=x/fs;
plot(time_x,real);
hold on;
plot(time_x,error,'rx');
legend('真实值','加15dB噪声');
% Choose default command line output for homework15
handles.output = hObject;
handles.episilon=0.003;
handles.sigma=0.004;
handles.C=0.05;
handles.error=error;
handles.x=x;
handles.real=real;
handles.time_x=time_x;
set(handles.text2,'String',['C:' num2str(handles.C)]);
set(handles.text3,'String',['σ:' num2str(handles.sigma)]);
set(handles.text4,'String',['ε:' num2str(handles.episilon)]);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes homework15 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = homework15_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
C=get(handles.slider1,'Value')
handles.C=C;
guidata(hObject,handles);

redraw(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sigma=get(handles.slider2,'Value')
handles.sigma=sigma;
guidata(hObject,handles);
redraw(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
episilon=get(handles.slider3,'Value')
handles.episilon=episilon;
guidata(hObject,handles);
redraw(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function redraw(hObject,handles)
episilon=handles.episilon;
sigma=handles.sigma;
gamma=1/(2*sigma*sigma);
C=handles.C;
x=handles.x;
x=x';
train_x=x/100;
error=handles.error;
real=handles.real;
%cmd_str=['-s 3 -t 2 -c ',num2str(C),' -g ',num2str(gamma),' -p ',num2str(episilon),' -q'];
%model=svmtrain(error,train_x,cmd_str);
model=solve_origin(train_x,error,C,episilon,sigma);
pl=origin_predict(train_x,error,model);
%pl=svmpredict(real,train_x,model,'-q');
axes(handles.axes1);
time_x=handles.time_x;
set(handles.text2,'String',['C:' num2str(handles.C)]);
set(handles.text3,'String',['σ:' num2str(handles.sigma)]);
set(handles.text4,'String',['ε:' num2str(handles.episilon)]);
cla;
plot(time_x,error,'x');
hold on
plot(time_x,pl);
hold on;
plot(time_x,pl,'r.');
legend('15dB','fitted curve');
guidata(hObject,handles);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[handles.C,handles.sigma,handles.episilon]=reset_default(hObject,handles);
guidata(hObject,handles);
redraw(hObject,handles);
function [C,sigma,episilon]=reset_default(hObject,handles)
C=0.05;
episilon=0.003;
sigma=0.004;
handles.C=C;
handles.simga=sigma;
handles.episilon=episilon;
set(handles.slider1,'Value',C);
set(handles.slider2,'Value',sigma);
set(handles.slider3,'Value',episilon);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
