classdef wavSet
    properties(SetAccess = private)
        Description
        WavLocation
        Count
    end
    
    methods
        function wavset = wavSet(wavfolderpath, varargin)
            if nargin==0||nargin>2
                error('Invalid parameter.')
            end
            
            % path is must a folder, not file
            if(~isdir(wavfolderpath))
                error('Invalid file folder.')
            end
            
            if nargin==1
                
                wavpath = fullfile(wavfolderpath,'*.wav');
                [~,wavset.Description,~] = fileparts(fileparts(wavfolderpath));
                d = dir(wavpath);
                wavset.Count = length(d);
                wavset.WavLocation = cell(1,wavset.Count);
                for i = 1:wavset.Count
                    wavset.WavLocation{i} = fullfile(wavfolderpath,d(i).name);
                end
            elseif nargin==2
                if strcmpi(varargin{1},'recursive')
                    
                else
                    error('Invalid parameter.')
                end
            else
                error('Invalid parameter.')
            end
            
        end
    end
end