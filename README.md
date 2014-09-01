DataFrame
=========

Matlab impelementation of DataFrame/Pandas concept. This project wraps and makes use of as much as possible of the Matlab table, but with the intent of providing a class implementation that could be specialized further.


<html><head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="generator" content="MATLAB 8.3"><link rel="schema.DC" href="http://purl.org/dc/elements/1.1/"><meta name="DC.date" content="2014-09-01"><meta name="DC.source" content="DataFrame_example.m"><style type="text/css">
html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,font,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td{margin:0;padding:0;border:0;outline:0;font-size:100%;vertical-align:baseline;background:transparent}body{line-height:1}ol,ul{list-style:none}blockquote,q{quotes:none}blockquote:before,blockquote:after,q:before,q:after{content:'';content:none}:focus{outine:0}ins{text-decoration:none}del{text-decoration:line-through}table{border-collapse:collapse;border-spacing:0}

html { min-height:100%; margin-bottom:1px; }
html body { height:100%; margin:0px; font-family:Arial, Helvetica, sans-serif; font-size:10px; color:#000; line-height:140%; background:#fff none; overflow-y:scroll; }
html body td { vertical-align:top; text-align:left; }

h1 { padding:0px; margin:0px 0px 25px; font-family:Arial, Helvetica, sans-serif; font-size:1.5em; color:#d55000; line-height:100%; font-weight:normal; }
h2 { padding:0px; margin:0px 0px 8px; font-family:Arial, Helvetica, sans-serif; font-size:1.2em; color:#000; font-weight:bold; line-height:140%; border-bottom:1px solid #d6d4d4; display:block; }
h3 { padding:0px; margin:0px 0px 5px; font-family:Arial, Helvetica, sans-serif; font-size:1.1em; color:#000; font-weight:bold; line-height:140%; }

a { color:#005fce; text-decoration:none; }
a:hover { color:#005fce; text-decoration:underline; }
a:visited { color:#004aa0; text-decoration:none; }

p { padding:0px; margin:0px 0px 20px; }
img { padding:0px; margin:0px 0px 20px; border:none; }
p img, pre img, tt img, li img, h1 img, h2 img { margin-bottom:0px; }

ul { padding:0px; margin:0px 0px 20px 23px; list-style:square; }
ul li { padding:0px; margin:0px 0px 7px 0px; }
ul li ul { padding:5px 0px 0px; margin:0px 0px 7px 23px; }
ul li ol li { list-style:decimal; }
ol { padding:0px; margin:0px 0px 20px 0px; list-style:decimal; }
ol li { padding:0px; margin:0px 0px 7px 23px; list-style-type:decimal; }
ol li ol { padding:5px 0px 0px; margin:0px 0px 7px 0px; }
ol li ol li { list-style-type:lower-alpha; }
ol li ul { padding-top:7px; }
ol li ul li { list-style:square; }

.content { font-size:1.2em; line-height:140%; padding: 20px; }

pre, code { font-size:12px; }
tt { font-size: 1.2em; }
pre { margin:0px 0px 20px; }
pre.codeinput { padding:10px; border:1px solid #d3d3d3; background:#f7f7f7; }
pre.codeoutput { padding:10px 11px; margin:0px 0px 20px; color:#4c4c4c; }
pre.error { color:red; }

@media print { pre.codeinput, pre.codeoutput { word-wrap:break-word; width:100%; } }

span.keyword { color:#0000FF }
span.comment { color:#228B22 }
span.string { color:#A020F0 }
span.untermstring { color:#B20000 }
span.syscmd { color:#B28C00 }

.footer { width:auto; padding:10px 0px; margin:25px 0px 0px; border-top:1px dotted #878787; font-size:0.8em; line-height:140%; font-style:italic; color:#878787; text-align:left; float:none; }
.footer p { margin:0px; }
.footer a { color:#878787; }
.footer a:hover { color:#878787; text-decoration:underline; }
.footer a:visited { color:#878787; }

table th { padding:7px 5px; text-align:left; vertical-align:middle; border: 1px solid #d6d4d4; font-weight:bold; }
table td { padding:7px 5px; text-align:left; vertical-align:top; border:1px solid #d6d4d4; }





  </style></head><body><div class="content"><h1>DataFrame Example</h1><!--introduction--><p>Walkthrough using DataFrame</p><p>Matlab ver.:  8.3.0.532 (R2014a) Date:         01-Sep-2014</p><!--/introduction--><h2>Contents</h2><div><ul><li><a href="#1">Create a DataFrame from scratch</a></li><li><a href="#2">View the DataFrame the Same as a Table</a></li><li><a href="#3">Access Table Columns Through DataFrame</a></li><li><a href="#4">Access Methods Attached to the DataFrame Object</a></li><li><a href="#5">Extend DataFrame However We'd Like</a></li><li><a href="#6">Or, if You Still Want to See the Object</a></li><li><a href="#7">We Can Try the Same Thing on a Standard Table</a></li><li><a href="#8">Initial Start at Providing Complete Wrapper for Table</a></li></ul></div><h2>Create a DataFrame from scratch<a name="1"></a></h2><p>The DataFrame is created in the same exact way as a table. The constructor just passes the arguements to the table constructor, then stores the table as as private property. We can still retrieve table properties</p><pre class="codeinput">
df = DataFrame(0, 0, 0, 0, ...
              'VariableNames', {'test1', 'test2','test3','test4'});
df.Properties
</pre><pre class="codeoutput">
ans =

             Description: ''
    VariableDescriptions: {}
           VariableUnits: {}
          DimensionNames: {'Row'  'Variable'}
                UserData: []
                RowNames: {}
           VariableNames: {'test1'  'test2'  'test3'  'test4'}

</pre><h2>View the DataFrame the Same as a Table<a name="2"></a></h2><p>DataFrame overrides the display method to show the table instead of the DataFrame object</p><pre class="codeinput">df
</pre><pre class="codeoutput">
df =

    test1    test2    test3    test4

    0        0        0        0

</pre><h2>Access Table Columns Through DataFrame<a name="3"></a></h2><p>The column names are pass throughs into the actual table structure. We can access the column as normal</p><pre class="codeinput">df.test1
df.test3
</pre><pre class="codeoutput">
ans =

     0


ans =

     0

</pre><h2>Access Methods Attached to the DataFrame Object<a name="4"></a></h2><p>You no longer need to know which possible functions you can use on a Matlab table. They are available to use either way.</p><pre class="codeinput">df.height()
height(df)
</pre><pre class="codeoutput">
ans =

     1


ans =

     1

</pre><h2>Extend DataFrame However We'd Like<a name="5"></a></h2><p>Matlab blocks you from extending the table data structure, but we can get around that with this approach</p><pre class="codeinput"><span>df = DataFrame.fromCSV(which(<span class="string">'ugly_data.csv'</span>));</span>
df.head();
</pre>
<pre class="codeoutput">
         Name          Zeros     Lat       Lng       Normal      Negative

    'Connor Hayden'    0        -2.582    71.067    0.0060495    3


                     GUID                           Date           Timestamp

    '7B79A197-E85F-2BFF-F37E-727DEDAC9803'    'April 27th 2015'    1.3944e+09


    AlphaNumeric

    'FSU09MJG3ZB'


</pre><h2>Or, if You Still Want to See the Object<a name="6"></a></h2><p>Column data will show empty since we are just dynamically passing through them on each subscript call. Properties shows up with contents, since it uses a getter method</p><pre class="codeinput">df.details();
</pre><pre class="codeoutput">

 DataFrame with properties:

      Properties: [1x1 struct]
             Lat: []
          Normal: []
           Zeros: []
            Name: []
             Lng: []
    AlphaNumeric: []
            GUID: []
       Timestamp: []
            Date: []
        Negative: []


         Name          Zeros     Lat       Lng       Normal      Negative

    'Connor Hayden'    0        -2.582    71.067    0.0060495    3


                     GUID                           Date           Timestamp

    '7B79A197-E85F-2BFF-F37E-727DEDAC9803'    'April 27th 2015'    1.3944e+09


    AlphaNumeric

    'FSU09MJG3ZB'

Variables:

    Name: 20400x1 cell string

    Zeros: 20400x1 double
        Values:

            min       0
            median    0
            max       0

    Lat: 20400x1 double
        Values:

            min       -89.424
            median    -1.0206
            max        88.893

    Lng: 20400x1 double
        Values:

            min       -177.19
            median    0.93481
            max        176.44

    Normal: 20400x1 double
        Values:

            min        -0.54325
            median    -0.017612
            max         0.57328

    Negative: 20400x1 double
        Values:

            min        -5
            median    0.5
            max         5

    GUID: 20400x1 cell string

    Date: 20400x1 cell string

    Timestamp: 20400x1 double
        Values:

            min        1.379e+09
            median    1.4036e+09
            max       1.4395e+09

    AlphaNumeric: 20400x1 cell string


</pre><h2>We Can Try the Same Thing on a Standard Table<a name="7"></a></h2><pre class="codeinput"><span>df = DataFrame.fromCSV(which(<span class="string">'ugly_data.csv'</span>));</span>
<span class="keyword">try</span>
    tbl.head();
    head(tbl);
<span class="keyword">catch</span> err
    disp(err.message)
<span class="keyword">end</span>
</pre><pre class="codeoutput">Unrecognized variable name 'head'.
</pre><h2>Initial Start at Providing Complete Wrapper for Table<a name="8"></a></h2><pre class="codeinput"><span>methods(<span class="string">'DataFrame'</span>)</span>
</pre>
<pre class="codeoutput">```
  Methods for class DataFrame:

  DataFrame   disp        height      toArray     width
  addprop     getTable    subsref     toCell      writetable  
  details     head        summary     toStruct

  Static methods:

fromArray   fromCell    intersect   rowfun
fromCSV     fromStruct  ismember    varfun

Call "methods('handle')" for methods of DataFrame inherited from handle.
```
</pre><p class="footer"><br><a href="http://www.mathworks.com/products/matlab/">Published with MATLAB&reg; R2014a</a><br></p></div><!--
##### SOURCE BEGIN #####
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
##### SOURCE END #####
--></body></html>
