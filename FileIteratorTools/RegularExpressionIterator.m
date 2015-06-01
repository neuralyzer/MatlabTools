classdef RegularExpressionIterator < FolderIterator
    %REGULAREXPRESSIONITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    properties
        reg_exp;
    end
    properties (Access = private)
        to_be_processed;
        already_done;
        new_files;
    end
    methods (Access = private)
        function wait_until_available(obj)
            while true
                if size(obj.new_files) > 0
                    break
                end
                raw_dir_listing = dir(fullfile(obj.folder, obj.reg_exp));
                dir_listing = arrayfun(@(x) x.name, raw_dir_listing, 'UniformOutput', false);
                full_file_name_listing = cellfun(@(x) fullfile(obj.folder, x), dir_listing...
                                                  , 'UniformOutput', false);
                obj.new_files = setdiff(full_file_name_listing, obj.already_done);
                pause(obj.sleep_time);
            end
            obj.current_item = obj.new_files{1};
            obj.already_done{end+1} = obj.current_item;
            obj.new_files = obj.new_files(2:end);
        end
    end
    
    
    methods
        function obj = RegularExpressionIterator(folder, sleep_time, end_value, reg_exp)
            obj = obj@FolderIterator(folder, sleep_time, end_value);
            obj.reg_exp = reg_exp;
            obj.already_done = cell(0,0);
            obj.new_files = cell(0,0);
        end
        function first(obj)
            obj.counter = 1;
            obj.wait_until_available();
        end
        function next(obj)
            obj.wait_until_available();
            obj.counter = obj.counter + 1;
        end
    end
    
end

