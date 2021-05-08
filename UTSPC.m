function varargout = UTSPC(varargin)
% UTSPC MATLAB code for UTSPC.fig
%      UTSPC, by itself, creates a new UTSPC or raises the existing
%      singleton*.
%
%      H = UTSPC returns the handle to a new UTSPC or the handle to
%      the existing singleton*.
%
%      UTSPC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UTSPC.M with the given input arguments.
%
%      UTSPC('Property','Value',...) creates a new UTSPC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UTSPC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UTSPC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UTSPC

% Last Modified by GUIDE v2.5 08-May-2021 07:04:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UTSPC_OpeningFcn, ...
                   'gui_OutputFcn',  @UTSPC_OutputFcn, ...
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


% --- Executes just before UTSPC is made visible.
function UTSPC_OpeningFcn(hObject, eventdata, handles, varargin)

%Menambah background
handles.output = hObject;
guidata(hObject, handles);
background=axes('unit', 'normalized', 'position', [0 0 1 1]);
bg=imread('yesbg.png'); imagesc(bg);
set(background, 'handlevisibility','off','visible', 'off')



% --- Outputs from this function are returned to the command line.
function varargout = UTSPC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function brightness_CreateFcn(hObject, ~, ~)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in searchimages.
function searchimages_Callback(hObject, eventdata, handles)
% hObject    handle to searchimages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
global G;
[nama , alamat] = uigetfile({'*.jpg';'*.bmp';'*.png';'*.tif'},'Browse Image'); %mengambil data
I = imread([alamat,nama]); %membaca data yg dipilih
handles.image=I; %gambar terpilih disimpan ke I
guidata(hObject, handles); %mengarahkan gcbo ke objek yg fungsinya sedang di eksekusi
axes(handles.axes1); %akses akses1
imshow(I,[]); %menampilkan gambar
G=I; %menyimpan data I ke G, jd isinya sama G dg I, nanti G yang berubah karena image processingnya
axes(handles.axes3); %akses axes3 buat histogram asal
histogramRGB(G); %nampil fungsi histogramRGB

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes2);
[nama_file_simpan, path_simpan]=uiputfile({'*.jpg','(*.jpg)';
    '*.*','All File(*.*)'}, 'Save Picture');
nama = fullfile(path_simpan, nama_file_simpan);
F=getframe(handles.axes2);
W=frame2im(F);
imwrite(W, nama)

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
global I;
citra=handles.image; 
axes(handles.axes2);
cla;
axes(handles.axes4);
cla reset;
G=I;



% --- Executes on button press in pshbtnred.
function pshbtnred_Callback(hObject, eventdata, handles)
% hObject    handle to pshbtnred (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
axes(handles.axes2);
red = G(:,:,1); % Red channel
% Create an all black channel.
var = zeros(size(G, 1), size(G, 2), 'uint8');
% Create color versions of the individual color channels.
just_red = cat(3, red, var, var);
guidata(hObject,handles);
imshow(just_red);
axes(handles.axes4);
histogram(G(:),256,'FaceColor','r','EdgeColor','r')


% --- Executes on button press in pshbtngreen.
function pshbtngreen_Callback(hObject, eventdata, handles)
% hObject    handle to pshbtngreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
axes(handles.axes2);
green = G(:,:,2); % Green channel
% Create an all black channel.
var = zeros(size(G, 1), size(G, 2), 'uint8');
% Create color versions of the individual color channels.
just_green = cat(3, var, green, var);
guidata(hObject,handles);
imshow(just_green);
axes(handles.axes4);
%histogramRGB(G);
histogram(G(:),256,'FaceColor','g','EdgeColor','g')

% --- Executes on button press in pshbtnblue.
function pshbtnblue_Callback(hObject, eventdata, handles)
% hObject    handle to pshbtnblue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
axes(handles.axes2);
blue = G(:,:,3); % Blue channel
% Create an all black channel.
var = zeros(size(G, 1), size(G, 2), 'uint8');
% Create color versions of the individual color channels.
just_blue = cat(3, var, var, blue);
guidata(hObject,handles);
imshow(just_blue);
axes(handles.axes4);
%histogramRGB(G);
histogram(G(:),256,'FaceColor','b','EdgeColor','b')


% --- Executes on button press in mybio.
function mybio_Callback(hObject, eventdata, handles)
% hObject    handle to mybio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[namafile, formatfile] = uigetfile({'mybio.png'}, 'membuka gambar'); %Memilih Gambar
image = imread([formatfile, namafile]); %Membaca Gambar
guidata(hObject, handles);
axes(handles.axes5); %Memilih axes1 sebagai letak gambar yang dimunculkan
imshow(image); %Memunculkan Gambar
msgbox('Berikut Identifikasi Saya :)','INFORMASI','warn');



% --- Executes on button press in brghtscitra.
function brghtscitra_Callback(hObject, eventdata, handles)
% hObject    handle to brghtscitra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Meningkatkan kecerahan gambar
Global g
img=getappdata(0,'img');
img_bright=img+100;
axes(handles.axes2);
imshow(img_bright);


% --- Executes on button press in btnexit.
function btnexit_Callback(hObject, eventdata, handles)
% hObject    handle to btnexit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button = questdlg('Anda Akan Menutup Aplikasi ?','Tutup','Ya','Tidak','cancel');
switch button
    case 'Ya', clc;
        close;
    case 'Tidak', quit cancel;
end
