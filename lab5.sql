create database lab5
use lab5

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[ItemNo] [int] NOT NULL,
	[Name] [varchar](10) NULL,
	[Price] [int] NULL,
	[Quantity in Store] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (100, N'A', 1000, 100)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (200, N'B', 2000, 50)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (300, N'C', 3000, 60)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (400, N'D', 6000, 400)
/****** Object:  Table [dbo].[Courses]    Script Date: 02/17/2017 13:04:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerNo] [varchar](2) NOT NULL,
	[Name] [varchar](30) NULL,
	[City] [varchar](3) NULL,
	[Phone] [varchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C1', N'AHMED ALI', N'LHR', N'111111')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C2', N'ALI', N'LHR', N'222222')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C3', N'AYESHA', N'LHR', N'333333')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C4', N'BILAL', N'KHI', N'444444')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C5', N'SADAF', N'KHI', N'555555')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C6', N'FARAH', N'ISL', NULL)
/****** Object:  Table [dbo].[Order]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderNo] [int] NOT NULL,
	[CustomerNo] [varchar](2) NULL,
	[Date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (1, N'C1', CAST(0x7F360B00 AS Date))
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (2, N'C3', CAST(0x2A3C0B00 AS Date))
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (3, N'C3', CAST(0x493C0B00 AS Date))
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date]) VALUES (4, N'C4', CAST(0x4A3C0B00 AS Date))
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderNo] [int] NOT NULL,
	[ItemNo] [int] NOT NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC,
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 200, 20)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 400, 10)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (2, 200, 5)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (3, 200, 60)

GO
/****** Object:  ForeignKey [FK__OrderDeta__ItemN__4316F928]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ItemNo])
REFERENCES [dbo].[Items] ([ItemNo])
GO
/****** Object:  ForeignKey [FK__OrderDeta__Order__4222D4EF]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderNo])
REFERENCES [dbo].[Order] ([OrderNo])
GO


select * from [Customers]
select * from [Order]
select * from [OrderDetails]
select * from [Items]

------------------------------q1--------------------------------
create view greaterOrder as
select I.[Name] as ItemName, sum(OD.Quantity) as quantityOrdered from [Order] O join OrderDetails OD on O.OrderNo = OD.OrderNo join Items I on I.ItemNo = OD.ItemNo group by I.[Name], I.[Quantity in Store] having sum(OD.Quantity) > I.[Quantity in Store];

select * from greaterOrder;

------------------------------q2--------------------------------
create view highDemand as
select I.[Name] as ItemName, sum(OD.Quantity) as quantityOrdered from [Order] O join OrderDetails OD on O.OrderNo = OD.OrderNo join Items I on I.ItemNo = OD.ItemNo group by I.[Name] having sum(OD.Quantity) > 30;

select * from highDemand;

------------------------------q3--------------------------------
create view premiumCust as
select C.Name from Customers C join [Order] O on C.CustomerNo = O.CustomerNo join OrderDetails OD on O.OrderNo = OD.OrderNo join Items I on I.ItemNo = OD.ItemNo where (Quantity * Price) > 2500;

select * from premiumCust;
------------------------------q4--------------------------------
alter view premiumCust as
select top(1) C.Name, O.Date from Customers C join [Order] O on C.CustomerNo = O.CustomerNo join OrderDetails OD on O.OrderNo = OD.OrderNo join Items I on I.ItemNo = OD.ItemNo order by (Quantity*price) desc

select * from premiumCust;
------------------------------q5--------------------------------
create view temp_cust as
select * from Customers;

select * from temp_cust;

insert into temp_cust
values('C7', 'Sana', 'ISL', '121341');

select * from Customers;
select * from temp_cust;

------------------------------q6---------------------------------
create view notNullPhoneCheck as
select * from Customers where Phone is not null
with check option;

insert into notNullPhone values('D1', 'Saniia', 'ISL', '12134uyu1');


create view notNullPhone as
select * from Customers where Phone is not null;

-------------------------------q7---------------------------------
--WRITING DBO WITH ALL TABLES IS NECESSARY
create view dbo.materialised_1 (
[Name], [Quantity])
with schemabinding 
as
select C.[Name], OD.Quantity 
from dbo.Customers C 
join dbo.[Order] O on C.CustomerNo = O.CustomerNo 
join dbo.OrderDetails OD on O.OrderNo = OD.OrderNo 
join dbo.Items I on I.ItemNo = OD.ItemNo 
where C.[Name] like '%Ali%' 
and OD.Quantity between 15 and 25;

select * from materialised_1;

-------------------------------q8----------------------------------
create view dbo.materialised_2(
cust_no, item_no, A)
with schemabinding
as
select C.CustomerNo, I.ItemNo, COUNT_BIG(*)
from dbo.Customers C 
join dbo.[Order] O on C.CustomerNo = O.CustomerNo 
join dbo.OrderDetails OD on O.OrderNo = OD.OrderNo 
join dbo.Items I on I.ItemNo = OD.ItemNo 
group by C.CustomerNo, I.ItemNo

select * from materialised_2