create database LAB4
use LAB4
go

create table [UserType](
[userTypeId] int primary key,
[name] varchar(20) not null
)
go
create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[userType] int foreign key references UserType([userTypeId]),
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go

create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go

Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go

create table TransactionType(
[transTypeID] int primary key,
[typeName] varchar(15),
[description] varchar(40) null
)

go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null,
transType int foreign key references TransactionType(transTypeID)
)

go

INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (1, N'Silver')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (2, N'Gold')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (3, N'Bronze')
GO
INSERT [dbo].[UserType] ([userTypeId], [name]) VALUES (4, N'Common')
GO






INSERT [dbo].[User] ([userId], [name], [userType],[phoneNum], [city]) VALUES (1, N'Ali',2, N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name],  [userType],[phoneNum], [city]) VALUES (2, N'Ahmed',1, N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (3, N'Aqeel',3, N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (4, N'Usman',4,  N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (5, N'Hafeez',2, N'03036061000', N'Lahore')
GO







INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (3, N'Gift', N'Enjoy')
GO





INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6569', 3, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'3336', 3, N'0234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6566', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'6456', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'3436', 2, N'0034', CAST(N'2020-09-02' AS Date), 34025.12)
GO




INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'6569')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'3336')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'6566')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'3436')
GO





INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (1, N'Withdraw')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (2, N'Deposit')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (3, N'Scheduled')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName]) VALUES (4, N'Failed')
GO





INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (1, CAST(N'2017-02-02' AS Date), N'6569', 500,1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (2, CAST(N'2018-02-03' AS Date), N'3436', 3000,3)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (3, CAST(N'2017-05-06' AS Date), N'6566', 2500,2)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (4, CAST(N'2016-09-09' AS Date), N'6566', 2000,1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (5, CAST(N'2015-02-10' AS Date), N'3336', 6000,4)
GO


Select * from UserType
Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]
Select * from TransactionType


-----------------------------q1-----------------------------------
select cardNum from Card where cardNum not in (select cardNum from [Transaction]);
select C.cardNum from Card C left join [Transaction] T on C.cardNum = T.cardNum where T.cardNum is null;

-----------------------------q2-----------------------------------
select U.name from UserCard UC join [User] U on UC.userID = U.userId join Card C on
UC.cardNum = C.cardNum where C.balance < 30000;

-----------------------------q3-----------------------------------
select U.name from UserCard UC join [User] U on UC.userID = U.userId join Card C on
UC.cardNum = C.cardNum join CardType CT on C.cardTypeID = CT.cardTypeID where CT.name = 'debit';

-----------------------------q4-----------------------------------
select U.name from UserCard UC join [User] U on UC.userID = U.userId join Card C on
UC.cardNum = C.cardNum join [Transaction] T on C.cardNum = T.cardNum join TransactionType TT on T.transType = TT.transTypeID where TT.typeName = 'failed';

-----------------------------q5-----------------------------------
select * from UserCard UC join [User] U on UC.userID = U.userId join Card C on
UC.cardNum = C.cardNum join CardType CT on C.cardTypeID = CT.cardTypeID join UserType UT on U.userType = UT.userTypeId
where C.balance > 30000 and UT.name = 'gold';

-----------------------------q6-----------------------------------
select U.name, T.amount from UserCard UC join [User] U on UC.userID = U.userId join Card C on
UC.cardNum = C.cardNum join [Transaction] T on C.cardNum = T.cardNum join TransactionType TT on T.transType = TT.transTypeID where TT.typeName = 'failed';

-----------------------------q7-----------------------------------
select top 1 U.name, C.balance from UserCard UC join [User] U on UC.userID = U.userId join Card C on
UC.cardNum = C.cardNum where C.balance not in (select max(balance) from Card) order by C.balance Desc;

-----------------------------q8-----------------------------------
select * from [user] where [userId] in
(select [userID] from [UserCard] where [cardNum] in
(select [cardNum] from [card] where [cardNum] in
(select [cardNum] from [Transaction] where [transType] not in 
(select [transTypeID] from [TransactionType] where [TypeName] like 'Deposit'))) and city = 'Lahore');

-----------------------------q9-----------------------------------
select U.city from [User] U where U.userId in
(select UC.userID from UserCard UC where UC.cardNum in
(select C.cardNum from Card C where C.balance = (select max(balance) from Card)));
