classdef NamedList < handle
    %NAMEDLIST Summary of this class goes here
    %   Detailed explanation goes here
    properties (Access = private)
        initial;
    end
    
    properties
        names;
        values;
    end
    
    methods
        function obj = NamedList()
           obj.names = [];
           obj.values = [];
        end
        function append(obj, name, value)
                obj.names =  [obj.names; name];
                obj.values = [obj.values; value];
        end
        function as_struct = asStruct(obj)
            as_struct = struct('names', obj.names, 'values', obj.values);
        end
    end
    
end

