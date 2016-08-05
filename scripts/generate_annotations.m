%% clean up
clear variables
close all
clc

tic
%% set path
addpath('/home/toy/jsonlab/jsonlab')
WIDER_dir = '/media/toy/sshd/WIDER';
imgdim_file = '/media/toy/sshd/WIDER/WIDER_train/imgdim_train.txt';
out_dir = '/media/toy/sshd/WIDER/WIDER_train/annt';

%% get resizing scale
fileID = fopen(imgdim_file);
imgdims = textscan(fileID, '%s %d %d %d %d');
fclose(fileID);

scalesMap = containers.Map(imgdims{1,1}, single(imgdims{1,4})./single(imgdims{1,2}));

%% parse annotation
load(fullfile(WIDER_dir, 'wider_face_split', 'wider_face_train.mat'))

num_dir = numel(invalid_label_list);
for i_dir = 1:num_dir
    
    num_img = numel(invalid_label_list{i_dir, 1});
    for i_img = 1:num_img
        
        img_name = file_list{i_dir, 1}{i_img, 1};
        invalid_flags = invalid_label_list{i_dir, 1}{i_img, 1}; 
        bboxes = face_bbx_list{i_dir, 1}{i_img, 1};      
        bboxes = bboxes(find(~invalid_flags), :);
        
        % convert to JSON and write to file
        jsonObj = struct;
        jsonObj.filename = img_name;
        
        num_face = size(bboxes, 1);
        for i_face = 1:num_face
  
            % scale
            scale = scalesMap([img_name '.jpg']);
            
            % in: [x_left y_top width height]
            % out: scale*[xmin ymin xmax ymax]
            bbox = scale*bboxes(i_face, :);
            xmin = bbox(1);
            ymin = bbox(2);
            xmax = xmin + bbox(3);
            ymax = ymin + bbox(4);
 
            % convert to JSON file
            bboxObj = struct;
            bboxObj.bbox = [xmin, ymin, xmax, ymax];
            jsonObj.annotation(i_face) = bboxObj;
            savejson('', jsonObj, ... 
                'FloatFormat', '%.2f', ...
                'FileName', fullfile(out_dir, [img_name '.json']));
        end       
    end
end
toc
% Elapsed time is 4875.473827 seconds.