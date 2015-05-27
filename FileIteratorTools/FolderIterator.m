classdef FolderIterator < handle
    %ITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        folder;
        current_item;
        sleep_time;
        end_value;
        counter;
    end
    properties (Access = private)
        not_yet_iterated;
        to_be_continued;
    end
       
    methods
        function obj = FolderIterator(folder, sleep_time, end_value)
                    obj.folder = folder;
            obj.sleep_time = sleep_time;
            obj.counter = 1;
            obj.end_value = end_value;
            obj.not_yet_iterated = 1;
            obj.to_be_continued = 1;
            obj.current_item = '';
        end
        function continues = items(obj)
            continues = obj.to_be_continued; 
            if continues
                if obj.not_yet_iterated
                    obj.first()
                    obj.not_yet_iterated = 0;
                else
                    obj.next()
                end
               obj.to_be_continued = ~ obj.isDone();
            end
        end
        function first(obj)
            obj.counter = 1;
        end
        function next(obj)
            obj.counter = obj.counter + 1;
        end
        function is_done = isDone(obj)
            if strcmp(obj.end_value, 'forever')
                is_done = false;
            else
               is_done = (obj.counter == obj.end_value);
            end
        end
    end
    
end

