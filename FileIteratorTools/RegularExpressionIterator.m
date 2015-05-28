classdef RegularExpressionIterator < FolderIterator
    %REGULAREXPRESSIONITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    properties
        reg_exp;
    end
    properties (Access = private)
        dir_listing;
    end
    methods (Access = private)
        function wait_until_available(obj)
            while true
                nr_available = size(obj.dir_listing, 1);
                if nr_available >= obj.counter
                    break
                end
                pause(obj.sleep_time);
                obj.dir_listing = dir(fullfile(obj.folder, obj.reg_exp));
            end
            obj.current_item = fullfile(obj.folder, obj.dir_listing(obj.counter).name);
        end
    end
    
    
    methods
        function obj = RegularExpressionIterator(folder, sleep_time, end_value, reg_exp)
            obj = obj@FolderIterator(folder, sleep_time, end_value);
            obj.reg_exp = reg_exp;
        end
        function first(obj)
            obj.counter = 1;
            obj.wait_until_available()
        end
        function next(obj)
            obj.counter = obj.counter + 1;
            obj.wait_until_available()
        end
    end
    
end

