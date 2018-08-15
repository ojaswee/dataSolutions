# Data Solutions
<b>Mission statement </b><br />
The purpose of the Data Solutions database is to maintain the data we generate, and to supply
information that supports the engagement services we provide to our clients and the management 
services to all our teams.<br /> <br />
<b>About Data Solutions:</b><br />
Data solutions is a company which produces and sales various software and hardware products.
Software which is related to testing is created by Quality department. Other software’s are
created by IT department. Hardware products are produced by Operations department.<br /><br />
<b>Requirements for Database:</b><br />
Data Solutions had various business needs to be addressed in this database. To pinpoint these
needs we had to conduct interviews with all stakeholders, gather information from forms and
existing systems.<br />
A) Interviews:<br />
From this information we could determine what piece of information is needed to what
group and it leads us to create different procedures and views for this specific group.<br />
B) Business forms and documents:<br />
These were very important for our purpose of our database creation. We used number of
forms which is used by business every day. Some of the forms we used were<br />
&emsp;1)New higher information form<br />
&emsp;2)Invoices<br />
&emsp;3)Sales Receipt<br />
&emsp;4)Expenses Reports<br />
&emsp;5)Customer Survey<br />
&emsp;6)Timesheets<br />
&emsp;7)Payroll details<br />
These forms sometimes contained redundant data and some of the information could be
combined together. Hence we created database with following details.<br /><br />
<b>Database for Data Solutions:</b><br />
Database for Data Solutions was created in SQL Server 2017. This database contains 10 tables.
Each table has triggers that are set either at insert, update or delete. Come of the tables have
triggers that are set for more than 1 instance. These details are discussed in the table section
below. Tables can also have other constrains which helps to discard garbage values to some
extent.<br />
It also has 8 stored procedure and 2 stored functions. Each of these 10 stored procedures or
functions join two or more tables.There are 3 views in this database. All these views have been joined to output result.
Data Solutions has 10 tables  <br />
&nbsp;<img src= "images/database_diagram.PNG" width = "600" border="5">
<br /><b>Stored Functions:</b><br />
&emsp;1)dbo.totalHours<br />
&emsp;2)dbo.fullName<br /> 
<b>Stored Procedures</b><br />
&emsp;1)itemizedReceipt<br />
&emsp;2)product_review<br />
&emsp;3)retiringThisYear<br />
&emsp;4)totlIemsByCustomer<br />
&emsp;5)totalSalarybyDept<br />
&emsp;6)totalValusofReceipt<br />
<b>Stored Procedures with cursor</b><br />
&emsp;1)birthdayThisMonth<br /> 
&emsp;2)noOfDependents<br />
