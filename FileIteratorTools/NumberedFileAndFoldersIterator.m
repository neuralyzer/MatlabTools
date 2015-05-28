classdef NumberedFileAndFoldersIterator < FolderIterator
    %FILESYSTEMITERATOR Iterate over folder and wait untill file becomes available
    %   FilesystemIterator(folder, sleep_time, start_value, increment, end_value, number_format)
    % sleep_time: time in seconds between checks for file/folder existence
    % start_value: start number
    % increment: stuff to add to the value whenever next is called
    % end_value: maximum nr to expect
    % number_format: strin in the printf/sprintf format, e.g. '0%6d'
    properties
        start_value;
        increment;
        number_formatter;
    end

    methods (Access = private)
        function wait_until_available(obj)
            while true
                res = exist(obj.current_item, 'file');
                if res == 2 || res == 7
                    break 
                end
                pause(obj.sleep_time);
            end
        end
        function make_path_from_counter(obj)
            obj.current_item = fullfile(obj.folder, obj.number_formatter(obj.counter));
        end
    end
    methods
        function obj = NumberedFileAndFoldersIterator(folder, sleep_time, start_value,...
                                          increment, end_value, number_formatter)

            obj@FolderIterator(folder, sleep_time, end_value)
            obj.start_value = start_value;
            obj.number_formatter = number_formatter;
            obj.increment = increment;
        end
        function first(obj)
            obj.counter = obj.start_value;
            obj.make_path_from_counter();
            obj.wait_until_available();
        end
        function next(obj)
            obj.counter = obj.counter + obj.increment;
            obj.make_path_from_counter();
            obj.wait_until_available();
        end
    end
    
end

