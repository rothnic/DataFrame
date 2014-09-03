function tests = test_DataFrame
%test_DataFrame Summary of this function goes here
%   Detailed explanation goes here 
tests = functiontests(localfunctions);
end

%% Ignore warnings
%#ok<*DEFNU> 
%#ok<*INUSD>

%% Test Functions
function test_DataFrame_head(testCase) 
%Test that we can execute the head method

testCase.TestData.df.head();
end

function test_DataFrame_TableAccess(testCase)
%Test that we can access the table properties

testCase.TestData.df.Properties.VariableNames;
end

function test_dyn_props(testCase)
%Test that we can access all vars as properties of the object

check_props(testCase.TestData.df);
end

function test_length(testCase)
length(testCase.TestData.df);
end

function test_width(testCase)
width(testCase.TestData.df);
end

function test_height(testCase)
height(testCase.TestData.df);
end

function test_struct_constructor(testCase)
s = [];
s.test1 = 0;
s.test2 = 0;
s.test3 = 0;

df = DataFrame.fromStruct(s);
check_props(df);
end

function test_csv_constructor(testCase)
df = DataFrame.fromCSV(which('ugly_data.csv'));
check_props(df);
end

function check_props(df)

props = df.Properties.VariableNames;
%vars = props.VariableNames;

for i = 1:length(props)
    df.(props{i});      % "." reference
    df(:, i);          % "()" reference
    df(1, props{i});
    df{:, i};          % "{}" reference
    df{:, props{i}};
end
end

%% Optional file fixtures  
function setupOnce(testCase)  % do not change function name
% set a new path, for example
testCase.TestData.df = DataFrame(0, 0, 0, 0, 'VariableNames', ...
    {'test1', 'test2','test3','test4',});
end

function teardownOnce(testCase)   % do not change function name
% change back to original path, for example
end

%% Optional fresh fixtures  
function setup(testCase)  % do not change function name
% open a figure, for example
end

function teardown(testCase)  % do not change function name
% close figure, for example
end