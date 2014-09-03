function run_DataFrame_tests
% Run all tests within the same directory as this file
out = runtests(fileparts(which('run_DataFrame_tests.m')),'Recursively',true);
out.disp;
end