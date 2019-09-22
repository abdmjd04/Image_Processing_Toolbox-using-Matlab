function varargout = CV_toolbox(varargin)
% CV_TOOLBOX MATLAB code for CV_toolbox.fig
%      CV_TOOLBOX, by itself, creates a new CV_TOOLBOX or raises the existing
%      singleton*.
%
%      H = CV_TOOLBOX returns the handle to a new CV_TOOLBOX or the handle to
%      the existing singleton*.
%
%      CV_TOOLBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CV_TOOLBOX.M with the given input arguments.
%
%      CV_TOOLBOX('Property','Value',...) creates a new CV_TOOLBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CV_toolbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CV_toolbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CV_toolbox

% Last Modified by GUIDE v2.5 08-May-2018 01:07:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CV_toolbox_OpeningFcn, ...
                   'gui_OutputFcn',  @CV_toolbox_OutputFcn, ...
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


% --- Executes just before CV_toolbox is made visible.
function CV_toolbox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CV_toolbox (see VARARGIN)

% Choose default command line output for CV_toolbox
handles.output = hObject;
handles.processedImage = {};
handles.imNum = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CV_toolbox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CV_toolbox_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in imageLoad.
function imageLoad_Callback(hObject, eventdata, handles)
% hObject    handle to imageLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile (...
{ '*.jpg;*.pbm;*.png;*.jpg;*.tiff;*.gif;*'}, ...
 'Pick an image file',...
 'MultiSelect', 'on');
fileName = fullfile(pathname, filename);

inImage = imread([pathname filename]);

handles.processedImage{1} = inImage;

imshow(inImage,[], 'Parent', handles.axes1());
imshow(inImage,[], 'Parent', handles.axes2());
guidata(hObject, handles);

% --- Executes on selection change in processList.
function processList_Callback(hObject, eventdata, handles)
% hObject    handle to processList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    



% Hints: contents = cellstr(get(hObject,'String')) returns processList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from processList


% --- Executes during object creation, after setting all properties.
function processList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to processList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in applyButton.
function applyButton_Callback(hObject, eventdata, handles)
% hObject    handle to applyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


index = get(handles.processList, 'Value');
handles.imNum = handles.imNum+1;

if (index == 2)
     prompt = {'Enter noise value between 0 and 1'};
     noise = inputdlg(prompt);
     
    handles.processedImage{1,handles.imNum} = imnoise(handles.processedImage{1,handles.imNum-1},'salt & pepper',str2num(noise{1}));
    imshow(handles.processedImage{1, handles.imNum},[], 'Parent', handles.axes2());
end


if (index == 3)
    [filenames, pathname] = uigetfile (...
{ '*.jpg;*.pbm;*.png;*.jpg;*.tiff;*.gif;*'}, ...
 'Pick an image file',...
 'MultiSelect', 'on');
logo = imread([pathname filenames]);
handles.processedImage{1,handles.imNum} = addLogo(logo,handles.processedImage{1,handles.imNum-1});
imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
end

if (index == 4)
    color = colorSpace;
    
    if (color == 1)
       handles.processedImage{1,handles.imNum} = rgb2ntsc(handles.processedImage{1,handles.imNum-1});
       imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    
    elseif(color == 2)
        handles.processedImage{1,handles.imNum} = rgb2ycbcr(handles.processedImage{1,handles.imNum-1});
       imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
       
    elseif (color ==3)
        handles.processedImage{1,handles.imNum} = rgb2gray(handles.processedImage{1,handles.imNum-1});
       imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
       
    elseif (color == 4)
        handles.processedImage{1,handles.imNum} = rgb2hsv(handles.processedImage{1,handles.imNum-1});
       imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
       
    end
       
end

if( index == 5)
    handles.processedImage{1,handles.imNum} = rgb2gray(handles.processedImage{1,handles.imNum-1});
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    figure;
    imhist(handles.processedImage{1,handles.imNum});
end

if( index == 6)
    if (ndims(handles.processedImage{1,handles.imNum-1}) ==3)
    handles.processedImage{1,handles.imNum} = histeq(rgb2gray(handles.processedImage{1,handles.imNum-1}));
    
    else
         handles.processedImage{1,handles.imNum} =  histeq(handles.processedImage{1,handles.imNum-1});
    end
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    figure;
    imhist(handles.processedImage{1,handles.imNum});
end

if (index == 7)
    operation = morphOperation;
 
    if(operation == 1)
      handles.processedImage{1,handles.imNum} = dialate(handles.processedImage{1,handles.imNum-1});
      imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    
    elseif(operation == 2)
       handles.processedImage{1,handles.imNum} = erode(handles.processedImage{1,handles.imNum-1});
      imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
        
   
    elseif (operation == 3)
       handles.processedImage{1,handles.imNum} = openImage(handles.processedImage{1,handles.imNum-1});
      imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    
    elseif (operation == 4)
          handles.processedImage{1,handles.imNum} = closeImage(handles.processedImage{1,handles.imNum-1});
      imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
     end

end

if(index == 8)

     filter = blurDialog;
     handles.processedImage{1,handles.imNum} = imgaussfilt(handles.processedImage{1,handles.imNum-1}, str2num(filter{1}), 'FilterSize',str2num(filter{2}));
     imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
end

if(index == 9)
    handles.processedImage{1,handles.imNum} = sobel(handles.processedImage{1,handles.imNum-1});
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
 end
    
if(index == 10)
    handles.processedImage{1,handles.imNum} = laplacian(handles.processedImage{1,handles.imNum-1});
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
end
 
if(index == 11)
    handles.processedImage{1,handles.imNum} = cannyEdge(handles.processedImage{1,handles.imNum-1});
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
end
 
 if(index == 12)
    handles.processedImage{1,handles.imNum} = imsharpen(handles.processedImage{1,handles.imNum-1});
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
 end
 
 if(index == 13)
    handles.processedImage{1,handles.imNum} = handles.processedImage{1,1};
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    houghLines(handles.processedImage{1,handles.imNum-1});
 end
 
 if(index == 14)
 
    handles.processedImage{1,handles.imNum} = handles.processedImage{1,1};
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    houghCircles(handles.processedImage{1,handles.imNum-1});
   
 end
 
 if(index == 15)

    handles.processedImage{1,handles.imNum} = handles.processedImage{1,1};
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    cornersHarris(handles.processedImage{1,handles.imNum-1});
   
 end
 
  if(index == 16)

    handles.processedImage{1,handles.imNum} = handles.processedImage{1,1};
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    cornersFAST(handles.processedImage{1,handles.imNum-1});
   
  end
 
  if(index == 17)

    handles.processedImage{1,handles.imNum} = handles.processedImage{1,1};
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    featuresSURF(handles.processedImage{1,handles.imNum-1});
   
  end
 
   if (index == 18)
     handles.processedImage{1,handles.imNum} = handles.processedImage{1,1};
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    contours(handles.processedImage{1,handles.imNum-1});
   end

if( index ==19)
    handles.processedImage{1,handles.imNum} = handles.processedImage{1,handles.imNum-1};
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    boundBox(handles.processedImage{1,handles.imNum-1});
    
end

if (index == 20)
    handles.processedImage{1,handles.imNum} = handles.processedImage{1,handles.imNum-1};
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    enclosingCircle(handles.processedImage{1,handles.imNum-1});
end

if(index == 21)
    
[filenames, pathname] = uigetfile (...
{ '*.jpg;*.pbm;*.png;*.jpg;*.tiff;*.gif;*'}, ...
 'Pick an image file',...
 'MultiSelect', 'on');

    file1 = [pathname filenames{1}];
    file2 = [pathname filenames{2}];
    
    image1 = imread(file1);
    image2 = imread(file2);
    
     handles.processedImage{1,handles.imNum} = image2;
    
    imshow(image1,[], 'Parent', handles.axes1());
    imshow(image2,[], 'Parent', handles.axes2());
    
    featureMatch(image1,image2);
    
    
    set(handles.inputText, 'String', 'Image1');
     set(handles.outputText, 'String', 'Image2');
    
end

if (index == 22)
    
    pathname = uigetdir('C:\Users\Zain\Desktop\Shabayek\calibration pattern', 'Choose folder containing calibration pattern');
    images = imageSet(pathname);
    imageFileNames = images.ImageLocation;
    im1 = imread(imageFileNames{1});
    
    imshow(im1,[], 'Parent', handles.axes1());
    handles.processedImage{1,handles.imNum} = im1;
    
    
    imshow(im1,[], 'Parent', handles.axes2());
    params= calibCamera (imageFileNames,images);
    set(handles.paramTable, 'Data', params.IntrinsicMatrix);
    set(handles.textPara, 'String', 'Camera Matrix');
    
     set(handles.inputText, 'String', 'Image1');
     set(handles.outputText, 'String', 'Image2');
    
end

if (index == 23)
    [filenames, pathname] = uigetfile (...
    { '*.jpg;*.pbm;*.png;*.jpg;*.tiff;*.gif;*'}, ...
     'Pick an image file',...
     'MultiSelect', 'on');
    
    file1 = [pathname filenames{1}];
    file2 = [pathname filenames{2}];
    
    image1 = imread(file1);
    image2 = imread(file2);
    
     handles.processedImage{1,handles.imNum} = image1;
     
      imshow(image1,[], 'Parent', handles.axes1());
      imshow(image2,[], 'Parent', handles.axes2());
    
    F = fundaEstimate(image1, image2);
    set(handles.paramTable, 'Data', F);
    set(handles.textPara, 'String', 'Fundamental Matrix');
    
     set(handles.inputText, 'String', 'Image1');
     set(handles.outputText, 'String', 'Image2');
    
end 
    if (index ==24)
         [filenames, pathname] = uigetfile (...
        { '*.jpg;*.pbm;*.png;*.jpg;*.tiff;*.gif;*'}, ...
         'Pick an image file',...
         'MultiSelect', 'on');
    
    image1 = imread(filenames{1});
    image2 = imread(filenames{2});
    
  handles.processedImage{1,handles.imNum} = image1;
     
     [points1 points2] = epiPolesAndLines(image1, image2);
     
    imshow(image1,[], 'Parent', handles.axes1());
    line(points1(:,[1,3])',points1(:,[2,4])', 'Parent', handles.axes1());
     
    
    imshow(image2,[], 'Parent', handles.axes2());
     line(points2(:,[1,3])',points2(:,[2,4])', 'Parent', handles.axes2());
           
    end
    
    if (index ==25)
        [filenames, pathname] = uigetfile (...
    { '*.jpg;*.pbm;*.png;*.jpg;*.tiff;*.gif;*'}, ...
     'Pick an image file',...
     'MultiSelect', 'on');
    X = imread( [pathname filenames{1}]);
    I1 = rgb2gray (X);
    I2 =rgb2gray( imread( [pathname filenames{1}]));
    
    imshow(I1,[], 'Parent', handles.axes1());
    imshow(I2,[], 'Parent', handles.axes2());
    
     
    handles.processedImage{1,handles.imNum} = I1;
    
    H = computeHomography (I1, I2);
    set(handles.paramTable, 'Data', H);
    set(handles.inputText, 'String', 'Image1');
    set(handles.outputText, 'String', 'Image2');
    
    

    end
    

guidata(hObject, handles);

function undoButton_Callback(hObject, eventdata, handles)
% --- Executes on button press in undoButton.function undoButton_Callback(hObject, eventdata, handles)
% hObject    handle to undoButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.imNum == 1)
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());
    
else
    handles.processedImage(handles.imNum) = [];
    handles.imNum = handles.imNum-1; 
    imshow(handles.processedImage{1,handles.imNum},[], 'Parent', handles.axes2());

end
  set(handles.paramTable, 'Data', zeros(4,4));


guidata(hObject, handles);


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file, pathname] = uiputfile(...
 {'*.jpg';'*.png';'*.gif';'*.*'},...
 'Save as');

filename = [pathname  file];
imwrite(handles.processedImage{1,handles.imNum}, filename, 'jpg' , 'Quality',100, 'Mode', 'lossy');


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imageLoad_Callback(hObject,eventdata,handles);


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

saveButton_Callback(h.hObject,eventdata,handles);


% --------------------------------------------------------------------
function uipushtool3_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
undoButton_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function uipushtool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resetButton_Callback(hObject, eventdata, handles)


% --- Executes during object deletion, before destroying properties.
function fundaTable_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to fundaTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadvideopush.
function loadvideopush_Callback(hObject, eventdata, handles)
% hObject    handle to loadvideopush (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Function to get video
[filename, pathname] = uigetfile({'*.avi;*.mpeg','All Video Files';'*.*','All Files'}, 'Select a Video');
fileName = fullfile(pathname, filename);

h = waitbar(0,'Loading Video...');
       
    %create a video object
    vidObject = VideoReader(fileName);
    
    %get video frame height and width
    vidHeight = vidObject.Height;
    vidWidth = vidObject.Width;
    
    %take 200 frames in each video
    vidFrames = vidObject.NumberOfFrames;
    
    % Create a video as a 3 dimensional data
    video3Dmat = zeros(vidHeight, vidWidth, vidFrames);
    
    % Read one frame at a time using readFrame until 200 frames reached
    % Append data from each video frame to the mat array
    for nFrame = 1: vidFrames
        vid_image = read(vidObject, nFrame);
        img(:, :,:, nFrame) = vid_image ;
        waitbar(nFrame/vidFrames);
    end
    
    



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in undoButton.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to undoButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in select2.
function select2_Callback(hObject, eventdata, handles)
% hObject    handle to select2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select2


% --- Executes during object creation, after setting all properties.
function select2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
