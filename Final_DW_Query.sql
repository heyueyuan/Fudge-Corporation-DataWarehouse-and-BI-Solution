/* Drop table cd4.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'ist722_hhkhan_cd4_dw.dbo.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE ist722_hhkhan_cd4_dw.dbo.DimProduct 
;
/* Create table cd4.DimProduct */
CREATE TABLE ist722_hhkhan_cd4_dw.dbo.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [Product_ID]  int   NOT NULL
,  [Product_Name]  varchar(50)   NOT NULL
,  [Product_Is_Active]  nChar(1)  DEFAULT('N') NOT NULL
,  [Supplier_Name]  nvarchar(50)  DEFAULT 'No Supplier' NOT NULL
,  [Category]  nvarchar(25)  DEFAULT 'No Category' NOT NULL
,  [Source]  nvarchar(20)  DEFAULT 'None' NOT NULL
,  [RowIsCurrent]  bit default(1)   NOT NULL
,  [RowStartDate]  datetime DEFAULT '1/1/1900'  NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200) default ('N/A')  NOT NULL
, CONSTRAINT [ist722_hhkhan_cd4_dw.dbo.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

/* Drop table cd4.DimCustomer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'ist722_hhkhan_cd4_dw.dbo.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE ist722_hhkhan_cd4_dw.dbo.DimCustomer 
;

/* Create table cd4.DimCustomer */
CREATE TABLE ist722_hhkhan_cd4_dw.dbo.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  int   NOT NULL
,  [CutomerName]  nvarchar(101)   NOT NULL
,  [CutomerEmail]  varchar(200)  DEFAULT 'N/A' NOT NULL
,  [CustomerCity]  varchar(50)   NOT NULL
,  [CustomerState]  varchar(2)   NOT NULL
,  [CustomerZip]  varchar(20)   NOT NULL
,  [Source]  nvarchar(20)  DEFAULT 'None' NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1   NOT NULL
,  [RowStartDate]  datetime DEFAULT '1/1/1900' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200) default ('N/A') NOT NULL
, CONSTRAINT [PK_ist722_hhkhan_cd4_dw.dbo.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

/* Drop table cd4.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'ist722_hhkhan_cd4_dw.dbo.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE ist722_hhkhan_cd4_dw.dbo.DimDate 
;

/* Create table cd4.DimDate */
CREATE TABLE ist722_hhkhan_cd4_dw.dbo.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  datetime   NULL
,  [DayName]  nchar(10)   NOT NULL
,  [FullDateUSA]  nchar(11)   NOT NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL 
,  [DayOfYear]  int   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  int   NOT NULL
,  [IsWeekday]  varchar(1) NOT NULL DEFAULT (('N'))
, CONSTRAINT [PK_ist722_hhkhan_cd4_dw.dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

/* Drop table cd4.FactSales */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'ist722_hhkhan_cd4_dw.dbo.FactSales') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE ist722_hhkhan_cd4_dw.dbo.FactSales 
;

/* Create table cd4.FactSales */
CREATE TABLE ist722_hhkhan_cd4_dw.dbo.FactSales (
   [ProductKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [OrderID]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [Quantity]  int   NOT NULL
,  [TotalAmount]  decimal(25,4)   NOT NULL
,  [UnitPrice]  money   NOT NULL
,  [Source]  nvarchar(20)  DEFAULT 'None' NULL
, CONSTRAINT [PK_ist722_hhkhan_cd4_dw.dbo.FactSales] PRIMARY KEY 
( [ProductKey], [OrderID] )
;
) ON [PRIMARY]

ALTER TABLE ist722_hhkhan_cd4_dw.dbo.FactSales ADD CONSTRAINT
   FK_ist722_hhkhan_cd4_dw_FactSales_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;


ALTER TABLE ist722_hhkhan_cd4_dw.dbo.FactSales ADD CONSTRAINT
   FK_ist722_hhkhan_cd4_dw_FactSales_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE ist722_hhkhan_cd4_dw.dbo.FactSales ADD CONSTRAINT
   FK_ist722_hhkhan_cd4_dw_FactSales_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 


