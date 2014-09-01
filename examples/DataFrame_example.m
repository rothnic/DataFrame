%% DataFrame_example
% Walkthrough using DataFrame
%
% Author:       nick roth
% email:        nick.roth@nou-systems.com
% Matlab ver.:  8.3.0.532 (R2014a)
% Date:         01-Sep-2014

%% Create a DataFrame from scratch
% The DataFrame is created in the same exact way as a table. The
% constructor just passes the arguements to the table constructor, then
% stores the table as as private property. We can still retrieve table
% properties
df = DataFrame(0, 0, 0, 0, ...
    'VariableNames', {'test1', 'test2','test3','test4',});
df.Properties

%% View the DataFrame the Same as a Table
% DataFrame overrides the display method to show the table instead of the
% DataFrame object
df

%% Access Table Columns Through DataFrame
% The column names are pass throughs into the actual table structure. We
% can access the column as normal
df.test1
df.test3

%% Access Methods Attached to the DataFrame Object
% You no longer need to know which possible functions you can use on a
% Matlab table. They are available to use either way.
df.height()
height(df)

%% Extend DataFrame However We'd Like
% Matlab blocks you from extending the table data structure, but we can get
% around that with this approach
df = DataFrame.fromCSV(which('ugly_data.csv'));
df.head();

%% Or, if You Still Want to See the Object
% Column data will show empty since we are just dynamically passing through
% them on each subscript call. Properties shows up with contents, since it
% uses a getter method
df.details();

%% We Can Try the Same Thing on a Standard Table
tbl = readtable(which('ugly_data.csv'));
try
    tbl.head();
    head(tbl);
catch err
    disp(err.message)
end

%% Initial Start at Providing Complete Wrapper for Table
methods('DataFrame')