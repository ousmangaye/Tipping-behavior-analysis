
/* Import the CSV file into SAS */
proc import datafile="/home/u63865872/tips.csx"
    out=tips
    dbms=csv
    replace;
    getnames=yes;
run;

/* Calculate the total bill paid */
proc means data=tips sum;
    var total_bill;
run;

/* Explore relationship between total bill and tip */
proc sgscatter data=tips;
    plot tip*total_bill;
run;

proc corr data=tips;
    var total_bill tip;
run;

proc reg data=tips;
    model tip = total_bill;
run;


ods graphics on / reset=index imagename="ScatterPlot_Tips" imagefmt=png;
ods listing gpath="C:\Users\ousma\Desktop";


/* Compare tipping behavior by gender */
proc means data=tips mean std;
    class sex;
    var tip;
run;

proc ttest data=tips;
    class sex;
    var tip;
run;

proc sgplot data=tips;
    vbox tip / category=sex;
run;


/* Compare tipping behavior by smoker status */
proc means data=tips mean std;
    class smoker;
    var tip;
run;

proc ttest data=tips;
    class smoker;
    var tip;
run;

proc sgplot data=tips;
    vbox tip / category=smoker;
run;


/* Analyze tipping trends by day of the week */
proc means data=tips mean std;
    class day;
    var tip;
run;

proc anova data=tips;
    class day;
    model tip = day;
run;

proc sgplot data=tips;
    vbox tip / category=day;
run;


/* Compare tipping behavior by mealtime */
proc means data=tips mean std;
    class time;
    var tip;
run;

proc ttest data=tips;
    class time;
    var tip;
run;

proc sgplot data=tips;
    vbox tip / category=time;
run;



/* Analyze the influence of party size on tipping */
proc means data=tips mean std;
    class size;
    var tip;
run;

proc anova data=tips;
    class size;
    model tip = size;
run;

proc sgplot data=tips;
    vbox tip / category=size;
run;




/* Compute descriptive statistics */
proc means data=tips mean std min max n;
    var total_bill tip;
run;


/* Histogram for total bill */
proc sgplot data=tips;
    histogram total_bill;
    density total_bill;
    title "Histogram of Total Bill";
run;

/* Histogram for tip */
proc sgplot data=tips;
    histogram tip;
    density tip;
    title "Histogram of Tip";
run;

/* Box plot for total bill */
proc sgplot data=tips;
    vbox total_bill;
    title "Box Plot of Total Bill";
run;

/* Box plot for tip */
proc sgplot data=tips;
    vbox tip;
    title "Box Plot of Tip";
run;

/* Scatter plot for total bill vs tip */
proc sgplot data=tips;
    scatter x=total_bill y=tip;
    title "Scatter Plot of Total Bill vs Tip";
run;

/* Correlation matrix */
proc corr data=tips nosimple;
    var total_bill tip;
run;



/* T-test for gender */
proc ttest data=tips;
    class sex;
    var tip;
run;

/* T-test for smoker status */
proc ttest data=tips;
    class smoker;
    var tip;
run;


/* ANOVA for day of the week */
proc anova data=tips;
    class day;
    model tip = day;
run;


/* Simple linear regression */
proc reg data=tips;
    model tip = total_bill;
run;

/* Multiple linear regression including interactions */
proc reg data=tips;
    model tip = total_bill sex smoker day time size total_bill*sex total_bill*smoker total_bill*day total_bill*time total_bill*size;
run;
