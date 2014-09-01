classdef DataFrame < dynamicprops
    %DATAFRAME - an implementation of a DataFrame class for Matlab
    % DATAFRAME - inspired by Pandas and R DataFrame, this class wraps the
    %   Matlab table datatype as an object oriented alternative
    %
    % SYNTAX:
    %   df = DataFrame( varargin )
    %
    % Description:
    %   df = DataFrame( varargin ) the DataFrame literally passes the input
    %   arguement on to the table during construction
    %
    % PROPERTIES:
    %   (dynamic) - the DataFrame properties will match the
    %   table.Properties.VariableNames
    %
    % EXAMPLES:
    %   df = DataFrame(0, 0, 0, 0, 'VariableNames', ...
    %             {'test1', 'test2','test3','test4',})
    %   df.head()
    %
    % SEE ALSO: table
    %
    % Author:       nick roth
    % email:        nick.roth@nou-systems.com
    % Matlab ver.:  8.3.0.532 (R2014a)
    % Date:         01-Sep-2014
    
    %% Properties
    properties
        Properties
    end
    
    properties (Access = private)
        data
    end
    
    %% Methods
    methods
        % DATAFRAME Constructor
        function self = DataFrame(varargin)

            if nargin == 1
                tbl = varargin{1};
                if istable(tbl)
                    self.data = tbl;
                end
            else
                % Process inputs as if we are a Matlab table
                self.data = table(varargin{:});
            end
            
            self.update_props();
        end
             
        function head(self)
            %HEAD - implements the method that Pandas provides to see the
            %top rows of the table
            
            toprows = self.data(min(length(self),10), :);
            disp(toprows);
        end
        
        function out = getTable(self)
            
            out = self.data;
        end
        
        function details(self)
            
            builtin('disp', self);
            self.head();
            self.summary();
        end
    end
    
    methods (Access = private)
        function update_props(self)
            %UDPATE_PROPS - adds the table variables to the class as
            %dynamic properties. This way we can make it look like the
            %DataFrame object is actually a table
            
            vars = self.data.Properties.VariableNames;
            for i = 1:length(vars)
                var = vars{i};
                self.addprop(var);
            end
        end
    end
    
    % Constructors
    methods (Static)
        function out = fromStruct(varargin)
            out = DataFrame(struct2table(varargin{:}));
        end
        
        function out = fromCSV(varargin)
            out = DataFrame(readtable(varargin{:}));
        end
        
        function out = fromArray(varargin)
            out = DataFrame(array2table(varargin{:}));
        end
        
        function out = fromCell(varargin)
            out = DataFrame(cell2table(varargin{:}));
        end
    end
    
    %% Pass Throughs
    methods
        function out = height(self)
            out = height(self.data);
        end
        
        function out = width(self)
            out = width(self.data);
        end
        
        function summary(self)
            summary(self.data);
        end
        
        function out = toStruct(self)
            out = table2struct(self.data);
        end
        
        function out = toCell(self)
            out = table2cell(self.data);
        end
        
        function out = toArray(self)
            out = table2array(self.data);
        end
        
        function writetable(self, varargin)
            writetable(self.data, varargin{:})
        end
        
        function out = get.Properties(self)
            out = self.data.Properties;
        end
    end
    
    %% Static
    methods (Static)
        function [C,ia,ib] = intersect(A, B, varargin)
            [C,ia,ib] = intersect(A, B, varargin{:});
        end
        
        function [Lia, Locb] = ismember(A, B, varargin)
            [Lia, Locb] = ismember(A, B, varargin{:});
        end
        
        function out = rowfun(func, A, varargin)
            out = rowfun(func, A, varargin{:});
        end
        
        function out = varfun(func, A, varargin)
            out = varfun(func, A, varargin{:});
        end
    end
    
    %% Overrides
    methods
        
        function out = subsref(self, S)
            %SUBSREF - overrides the subscript reference method, which
            %provides the way for us to wrap the built in table type
            
            call_type = S.type;
            var = S.subs;
            
            switch call_type
                case '.'
                    if ismethod(self, var)
                        if strcmp(var, 'head') || strcmp(var, 'details')
                            builtin('subsref', self, S);
                        else
                            out = builtin('subsref', self, S);
                        end
                    else
                        tbl = self.data;
                        out = builtin('subsref', tbl, S);
                    end
                case '()'
                    
                case '{}'
            end
        end
        
        function disp(self)
            %DISP - overrides the default disp method, which makes our
            %DataFrame look like a typical table
            
            disp(self.data);
        end
    end

end
