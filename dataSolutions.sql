
/*Author: Ojaswee Dhungana
Project: Data solutions
Description: This file can be doenloaded and run in MS SQL Server to create table,constrains, triggers and determine relationships between 
other tables*/
USE [master]
GO
/****** Object:  Database [DataSolutions]    Script Date: 5/12/2018 6:48:59 PM ******/
CREATE DATABASE [DataSolutions]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'chapter5_company', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\chapter5_company.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'chapter5_company_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\chapter5_company_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DataSolutions] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataSolutions].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DataSolutions] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DataSolutions] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DataSolutions] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DataSolutions] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DataSolutions] SET ARITHABORT OFF 
GO
ALTER DATABASE [DataSolutions] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DataSolutions] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DataSolutions] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DataSolutions] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DataSolutions] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DataSolutions] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DataSolutions] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DataSolutions] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DataSolutions] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DataSolutions] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DataSolutions] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DataSolutions] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DataSolutions] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DataSolutions] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DataSolutions] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DataSolutions] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DataSolutions] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DataSolutions] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DataSolutions] SET  MULTI_USER 
GO
ALTER DATABASE [DataSolutions] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DataSolutions] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DataSolutions] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DataSolutions] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DataSolutions] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DataSolutions] SET QUERY_STORE = OFF
GO
USE [DataSolutions]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [DataSolutions]
GO
/****** Object:  UserDefinedFunction [dbo].[fullName]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[fullName] (@fName varchar(50) ,@lName varchar(50))
returns varchar(50)
AS
BEGIN
DECLARE @Name varchar(50);
SET @Name = CONCAT(RTRIM(@fName),' ', RTRIM(@lName))
RETURN @Name
END


GO
/****** Object:  UserDefinedFunction [dbo].[totalHours]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[totalHours](@empID int)  
RETURNS int   
AS   
-- Returns the hours worked for each employee.  
BEGIN  
    DECLARE @tHrs int;  
	SELECT @tHrs = SUM(wo.hoursWorked) 
    FROM [worksON] wo 
	WHERE wo.empNo = @empID
     IF (@tHrs IS NULL)   
        SET @tHrs = 0;  
    RETURN @tHrs;  
END; 
GO
/****** Object:  Table [dbo].[employee]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee](
	[empNo] [int] NOT NULL,
	[fName] [char](115) NULL,
	[lName] [char](115) NULL,
	[addres] [char](205) NULL,
	[DOB] [date] NULL,
	[sex] [char](1) NULL,
	[position] [varchar](20) NULL,
	[deptNo] [int] NULL,
	[Country] [varchar](50) NULL,
	[city] [varchar](20) NULL,
	[state] [varchar](20) NULL,
	[salary] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[empNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[project]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project](
	[projNo] [int] NOT NULL,
	[projName] [char](115) NOT NULL,
	[deptNo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[projNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[worksON]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[worksON](
	[empNo] [int] NOT NULL,
	[projNo] [int] NOT NULL,
	[dateWorked] [date] NOT NULL,
	[hoursWorked] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[empNo] ASC,
	[projNo] ASC,
	[dateWorked] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_HoursbyEmployee_by_Project]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_HoursbyEmployee_by_Project] AS
SELECT e.empNo,e.fName,e.lName,p.projName,w.hoursWorked
FROM employee e, worksON w,project p
WHERE e.empNo=w.empNo AND p.projNo=w.projNo;
GO
/****** Object:  View [dbo].[EmpProject]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EmpProject](empNo, projNo, totalHours)
AS SELECT w.empNo, w.projNo, SUM(hoursWorked)
FROM Employee e, Project p, WorksOn w
WHERE e.empNo = w.empNo AND p.projNo = w.projNo
GROUP BY w.empNo, w.projNo;
GO
/****** Object:  View [dbo].[v_femaleManagers]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_femaleManagers]
AS
SELECT TOP (99.999999)PERCENT p.projNo, e.empNo,e.fName,e.lName,e.position,e.sex,e.deptNo 
FROM dbo.employee e, dbo.project p
WHERE (e.deptNo = p.deptNo) 
AND e.sex='F' AND e.position='Manager'
ORDER BY p.projNo;
GO
/****** Object:  Table [dbo].[customer]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[custID] [int] NOT NULL,
	[fName] [varchar](20) NULL,
	[lName] [varchar](20) NULL,
	[company] [varchar](20) NULL,
	[addres] [varchar](20) NULL,
	[city] [varchar](10) NULL,
	[states] [varchar](25) NULL,
	[country] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[custID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[department]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department](
	[deptNo] [int] NOT NULL,
	[deptName] [char](115) NOT NULL,
	[mgrEmpNo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[deptNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dependents]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dependents](
	[dependentID] [int] NOT NULL,
	[fName] [varchar](50) NULL,
	[lName] [varchar](50) NULL,
	[relationship] [varchar](20) NULL,
	[empNo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[dependentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feedback]    Script Date: 5/12/2018 6:49:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feedback](
	[feedbackNo] [int] NOT NULL,
	[custNo] [int] NULL,
	[productNo] [int] NULL,
	[orderID] [int] NULL,
	[feedback] [varchar](300) NULL,
 CONSTRAINT [PK_feedbackNo] PRIMARY KEY CLUSTERED 
(
	[feedbackNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderDetails]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderDetails](
	[detaillD] [int] NOT NULL,
	[orderID] [int] NULL,
	[productNo] [int] NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[detaillD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[orderId] [int] NOT NULL,
	[orderDate] [date] NOT NULL,
	[custID] [int] NULL,
	[cStatus] [varchar](10) NULL,
	[shipped] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[productNo] [int] NOT NULL,
	[productName] [varchar](20) NULL,
	[dateRelesed] [date] NULL,
	[deptNo] [int] NULL,
	[categories] [nchar](20) NULL,
	[salePrice] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[productNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[orderDetails] ADD  CONSTRAINT [DF_orderDetails_quantity]  DEFAULT ((1)) FOR [quantity]
GO
ALTER TABLE [dbo].[department]  WITH CHECK ADD  CONSTRAINT [FK_ManagerID] FOREIGN KEY([mgrEmpNo])
REFERENCES [dbo].[employee] ([empNo])
GO
ALTER TABLE [dbo].[department] CHECK CONSTRAINT [FK_ManagerID]
GO
ALTER TABLE [dbo].[dependents]  WITH CHECK ADD FOREIGN KEY([empNo])
REFERENCES [dbo].[employee] ([empNo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD  CONSTRAINT [FK_employee_deptNo] FOREIGN KEY([deptNo])
REFERENCES [dbo].[department] ([deptNo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[employee] CHECK CONSTRAINT [FK_employee_deptNo]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD  CONSTRAINT [FK_custNo_customer] FOREIGN KEY([custNo])
REFERENCES [dbo].[customer] ([custID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[feedback] CHECK CONSTRAINT [FK_custNo_customer]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD  CONSTRAINT [FK_orderID_feedback] FOREIGN KEY([orderID])
REFERENCES [dbo].[orders] ([orderId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[feedback] CHECK CONSTRAINT [FK_orderID_feedback]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD  CONSTRAINT [FK_productNo_feedback] FOREIGN KEY([productNo])
REFERENCES [dbo].[products] ([productNo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[feedback] CHECK CONSTRAINT [FK_productNo_feedback]
GO
ALTER TABLE [dbo].[orderDetails]  WITH CHECK ADD  CONSTRAINT [FK_orderID_orderDetails] FOREIGN KEY([orderID])
REFERENCES [dbo].[orders] ([orderId])
GO
ALTER TABLE [dbo].[orderDetails] CHECK CONSTRAINT [FK_orderID_orderDetails]
GO
ALTER TABLE [dbo].[orderDetails]  WITH CHECK ADD  CONSTRAINT [FK_productNo_orderDetails] FOREIGN KEY([productNo])
REFERENCES [dbo].[products] ([productNo])
GO
ALTER TABLE [dbo].[orderDetails] CHECK CONSTRAINT [FK_productNo_orderDetails]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_custID_orders] FOREIGN KEY([custID])
REFERENCES [dbo].[customer] ([custID])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_custID_orders]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_deptID_Product] FOREIGN KEY([deptNo])
REFERENCES [dbo].[department] ([deptNo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_deptID_Product]
GO
ALTER TABLE [dbo].[project]  WITH CHECK ADD  CONSTRAINT [FK_deptNo] FOREIGN KEY([deptNo])
REFERENCES [dbo].[department] ([deptNo])
GO
ALTER TABLE [dbo].[project] CHECK CONSTRAINT [FK_deptNo]
GO
ALTER TABLE [dbo].[project]  WITH CHECK ADD  CONSTRAINT [FK_project_deptNo] FOREIGN KEY([deptNo])
REFERENCES [dbo].[department] ([deptNo])
GO
ALTER TABLE [dbo].[project] CHECK CONSTRAINT [FK_project_deptNo]
GO
ALTER TABLE [dbo].[worksON]  WITH CHECK ADD  CONSTRAINT [FK_worksOn_empNo] FOREIGN KEY([empNo])
REFERENCES [dbo].[employee] ([empNo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[worksON] CHECK CONSTRAINT [FK_worksOn_empNo]
GO
ALTER TABLE [dbo].[worksON]  WITH CHECK ADD  CONSTRAINT [FK_worksOn_projNo] FOREIGN KEY([projNo])
REFERENCES [dbo].[project] ([projNo])
GO
ALTER TABLE [dbo].[worksON] CHECK CONSTRAINT [FK_worksOn_projNo]
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD  CONSTRAINT [check_position] CHECK  (([position]='Software Developer' OR [position]='Analyst' OR [position]='Team Lead' OR [position]='Manager' OR [position]='Shift'))
GO
ALTER TABLE [dbo].[employee] CHECK CONSTRAINT [check_position]
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD  CONSTRAINT [check_sex] CHECK  (([sex]='M' OR [sex]='F'))
GO
ALTER TABLE [dbo].[employee] CHECK CONSTRAINT [check_sex]
GO
ALTER TABLE [dbo].[worksON]  WITH CHECK ADD  CONSTRAINT [check_hours] CHECK  (([hoursWorked]>=(0) AND [hoursWorked]<=(40)))
GO
ALTER TABLE [dbo].[worksON] CHECK CONSTRAINT [check_hours]
GO
/****** Object:  StoredProcedure [dbo].[bithdayThisMonth]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[bithdayThisMonth]
AS
DECLARE db_cursor CURSOR FOR SELECT * FROM employee;
OPEN db_cursor;
DECLARE @mon int;
SET @mon = month(getdate());
BEGIN
SELECT dbo.fullName(e.fName,e.lName)AS FullName
,e.position
,d.deptName
,day(e.DOB) AS birthday
 FROM employee e, department d
where month(e.DOB) = @mon
AND e.deptNo=d.deptNo
END;
CLOSE db_cursor;
DEALLOCATE db_cursor;

GO
/****** Object:  StoredProcedure [dbo].[itemizedReceipt]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[itemizedReceipt] @orderID int
AS
DECLARE @total INT;
SET @total =0;
SELECT oD.orderID,oD.detaillD,p.productName,p.categories,oD.quantity,p.salePrice
,(oD.quantity * p.salePrice) AS totalPrice
 from orderDetails oD, products p
WHERE oD.productNo=p.productNo
AND oD.orderID=@orderID

EXECUTE totalValueofReceipt @orderID

--SELECT oD.orderID
--	,MAX(c.company) AS Company
--	,MAX(o.orderDate) AS OrderDate
--	,SUM(oD.quantity) AS totalquantity
--	,SUM(p.salePrice) AS totalPrce
--	,MAX(o.cStatus) AS statusOfOrder
--	--,(oD.quantity * p.salePrice) AS totalPrice
-- from orderDetails oD, products p, customer c,orders o
--WHERE oD.productNo=p.productNo
--AND oD.orderID=1500
--AND c.custID=o.custID
--AND oD.orderID=o.orderId
--GROUP BY oD.orderID;

GO
/****** Object:  StoredProcedure [dbo].[noOfDependents]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[noOfDependents]
AS
DECLARE db_cursor CURSOR FOR SELECT fname, relationship FROM dependents; 
DECLARE @myName VARCHAR(256);
DECLARE @myrelationshp varchar(20);
OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @myName, @myrelationshp;
--WHILE @@FETCH_STATUS = 0  
BEGIN  
  --Do stuff with scalar values
  SELECT Max(e.empNo) AS empNo
,CONCAT (RTRIM(e.fName), ' ', RTRIM(e.lName)) AS empName
,count(d.dependentID) AS noOfDependents
 FROM dependents d, employee e
WHERE d.empNo= e.empNo
GROUP BY e.fname, e.lName
ORDER BY empNO;
      -- FETCH NEXT FROM db_cursor INTO @myName, @myrelationshp;
END;
CLOSE db_cursor;
DEALLOCATE db_cursor;
GO
/****** Object:  StoredProcedure [dbo].[product_review]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROcedure [dbo].[product_review]
AS
SELECT p.productName,c.company,f.feedback FROM products p, feedback f, customer c
WHERE f.custNo=c.custID
AND f.productNo = p.productNo;
GO
/****** Object:  StoredProcedure [dbo].[retiringThisYear]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[retiringThisYear]
AS
declare @year datetime
set @year = year(getdate()) - 65
SELECT e.empNo, dbo.fullName(e.fName,e.lName) AS FullName 
,e.position
,d.deptName
FROM employee e, department d
where year(DOB) =@year 
AND e.deptNo=d.deptNo
;
GO
/****** Object:  StoredProcedure [dbo].[totalItemsByCustomer]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[totalItemsByCustomer]
AS
SELECT MAX(c.company) AS Company
	,SUM(p.salePrice) AS Sale
	,count(oD.orderID) AS noOfItems
 from orderDetails oD, products p, customer c, orders o
WHERE oD.productNo=p.productNo
AND oD.orderID =o.orderId
AND o.custID=c.custID
GROUP BY c.custID
ORDER BY noOfItems DESC;
GO
/****** Object:  StoredProcedure [dbo].[totalSalarybyDept]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[totalSalarybyDept]
AS
declare @salary int
set @salary = 0
SELECT d.deptName AS deptName
,sum(e.salary) AS totalSalary
, count(e.empNo) AS No_of_Employee
FROM employee e, department d
where e.deptNo=d.deptNo
GROUP BY d.deptName;
GO
/****** Object:  StoredProcedure [dbo].[totalValueofReceipt]    Script Date: 5/12/2018 6:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[totalValueofReceipt] @orderID int
AS
SELECT oD.orderID
	,MAX(c.company) AS Company
	,MAX(o.orderDate) AS OrderDate
	,SUM(oD.quantity) AS totalquantity
	,SUM(p.salePrice) AS totalPrce
	,MAX(o.cStatus) AS statusOfOrder
 from orderDetails oD, products p, customer c,orders o
WHERE oD.productNo=p.productNo
AND c.custID=o.custID
AND oD.orderID=o.orderId
AND oD.orderID=@orderID
GROUP BY oD.orderID;

GO
USE [master]
GO
ALTER DATABASE [DataSolutions] SET  READ_WRITE 
GO
