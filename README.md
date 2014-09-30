DataFrame
=========

Matlab impelementation of DataFrame/Pandas concept. This project wraps and makes use of as much as possible of the Matlab table, but with the intent of providing a class implementation that could be specialized further.

  </style></head><body><h2>Create a DataFrame from scratch<a name="1"></a></h2><p>The DataFrame is created in the same exact way as a table. The constructor just passes the arguements to the table constructor, then stores the table as as private property. We can still retrieve table properties</p><pre class="codeinput">df = DataFrame(0, 0, 0, 0, <span class="keyword">...</span>
    <span class="string">'VariableNames'</span>, {<span class="string">'test1'</span>, <span class="string">'test2'</span>,<span class="string">'test3'</span>,<span class="string">'test4'</span>,});
df.Properties
</pre><pre class="codeoutput">ans = 

             Description: ''
    VariableDescriptions: {}
           VariableUnits: {}
          DimensionNames: {'Row'  'Variable'}
                UserData: []
                RowNames: {}
           VariableNames: {'test1'  'test2'  'test3'  'test4'}

</pre><h2>View the DataFrame the Same as a Table<a name="2"></a></h2><p>DataFrame overrides the display method to show the table instead of the DataFrame object</p><pre class="codeinput">df
</pre><pre class="codeoutput">df = 

    test1    test2    test3    test4
    _____    _____    _____    _____

    0        0        0        0    

</pre><h2>Access Table Columns Through DataFrame<a name="3"></a></h2><p>The column names are pass throughs into the actual table structure. We can access the column as normal</p><pre class="codeinput">df.test1
df.test3
</pre><pre class="codeoutput">ans =

     0


ans =

     0

</pre><h2>Access Methods Attached to the DataFrame Object<a name="4"></a></h2><p>You no longer need to know which possible functions you can use on a Matlab table. They are available to use either way.</p><pre class="codeinput">df.height()
height(df)
</pre><pre class="codeoutput">ans =

     1


ans =

     1

</pre><h2>Extend DataFrame However We'd Like<a name="5"></a></h2><p>Matlab blocks you from extending the table data structure, but we can get around that with this approach</p><pre class="codeinput">df = DataFrame.fromCSV(which(<span class="string">'ugly_data.csv'</span>));
df.head();
</pre><pre class="codeoutput">         Name          Zeros      Lat         Lng         Normal       Negative
    _______________    _____    ________    ________    ___________    ________

    'Connor Hayden'    0        -2.58201    71.06714    0.006049531    3       


                     GUID                           Date           Timestamp 
    ______________________________________    _________________    __________

    '7B79A197-E85F-2BFF-F37E-727DEDAC9803'    'April 27th 2015'    1394414933


    AlphaNumeric 
    _____________

    'FSU09MJG3ZB'

</pre><h2>Or, if You Still Want to See the Object<a name="6"></a></h2><p>Column data will show empty since we are just dynamically passing through them on each subscript call. Properties shows up with contents, since it uses a getter method</p><pre class="codeinput">df.details();
</pre><pre class="codeoutput">  DataFrame with properties:

      Properties: [1x1 struct]
          Normal: []
             Lng: []
        Negative: []
           Zeros: []
            Name: []
    AlphaNumeric: []
            Date: []
            GUID: []
             Lat: []
       Timestamp: []

         Name          Zeros      Lat         Lng         Normal       Negative
    _______________    _____    ________    ________    ___________    ________

    'Connor Hayden'    0        -2.58201    71.06714    0.006049531    3       


                     GUID                           Date           Timestamp 
    ______________________________________    _________________    __________

    '7B79A197-E85F-2BFF-F37E-727DEDAC9803'    'April 27th 2015'    1394414933


    AlphaNumeric 
    _____________

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

            min       -89.42406
            median     -1.02059
            max        88.89347

    Lng: 20400x1 double
        Values:

            min       -177.18611
            median      0.934815
            max         176.4439

    Normal: 20400x1 double
        Values:

            min       -0.543252895
            median    -0.017611593
            max        0.573277103

    Negative: 20400x1 double
        Values:

            min        -5       
            median    0.5       
            max         5       

    GUID: 20400x1 cell string

    Date: 20400x1 cell string

    Timestamp: 20400x1 double
        Values:

            min         1378967930
            median    1403645750.5
            max         1439505058

    AlphaNumeric: 20400x1 cell string

</pre><h2>We Can Try the Same Thing on a Standard Table<a name="7"></a></h2><pre class="codeinput">tbl = readtable(which(<span class="string">'ugly_data.csv'</span>));
<span class="keyword">try</span>
    tbl.head();
    head(tbl);
<span class="keyword">catch</span> err
    disp(err.message)
<span class="keyword">end</span>
</pre><pre class="codeoutput">Unrecognized variable name 'head'.
</pre><h2>Dynamically add columns to the DataFrame<a name="8"></a></h2><pre class="codeinput">df.Lat2 = df.Lat;
df.Lat3 = df.Lat;
df.columns()
</pre><pre class="codeoutput">ans = 

  Columns 1 through 7

    'Name'    'Zeros'    'Lat'    'Lng'    'Normal'    'Negative'    'GUID'

  Columns 8 through 12

    'Date'    'Timestamp'    'AlphaNumeric'    'Lat2'    'Lat3'

</pre><h2>Easily remove columns from the DataFrame<a name="9"></a></h2><pre class="codeinput">df.remove_cols({<span class="string">'Lat2'</span>, <span class="string">'Lat3'</span>});
df.columns()
</pre><pre class="codeoutput">ans = 

  Columns 1 through 7

    'Name'    'Zeros'    'Lat'    'Lng'    'Normal'    'Negative'    'GUID'

  Columns 8 through 10

    'Date'    'Timestamp'    'AlphaNumeric'

</pre><h2>Initial Start at Providing Complete Wrapper for Table<a name="10"></a></h2><pre class="codeinput">methods(<span class="string">'DataFrame'</span>)
</pre><pre class="codeoutput">Methods for class DataFrame:

DataFrame    disp         is_column    subsref      toStruct     
addprop      getTable     numel        summary      width        
columns      head         remove_cols  toArray      writetable   
details      height       subsasgn     toCell       

Static methods:

fromArray    fromCell     intersect    rowfun       
fromCSV      fromStruct   ismember     varfun       

Call "methods('handle')" for methods of DataFrame inherited from handle.
</body></html>
