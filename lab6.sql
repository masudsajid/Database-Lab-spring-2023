create database LAB6
use LAB6
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

--------------------------------q1----------------------------------
create procedure proc1
@name varchar(100)
as
begin
select * from [User]
where [User].name = @name
end;

execute proc1 'Ali';

--------------------------------q2----------------------------------
create procedure proc2
@output_1 float OUTPUT
as
begin
select top (1) @output_1 = balance from [User] U join UserCard UC on U.userId = UC.userID join Card C on UC.cardNum = C.cardNum order by balance desc
end;



declare @output1 float;
exec proc2 @output1 out;
print @output1;

--------------------------------q3----------------------------------
create procedure proc3
@name varchar(50), @id int, @noOfCards int output
as
begin
	select @noOfCards = count(*) from [User] U join UserCard UC on U.userId = UC.userID where U.name = @name and U.userId = @id
end;

declare @noOfCards1 int;
exec proc3 'Ahmed', 2, @noOfCards1 out;
print @noOfCards1;

--------------------------------q4----------------------------------

create procedure [login]
@cardNum varchar(20), @cardPin varchar(4), @status int output
as
begin
	set @status = 0
	if exists (select * from [Card] C where C.PIN = @cardPin and C.cardNum = @cardNum)
	begin
		set @status = 1
	end
end;

declare @status1 int;
exec [login] '3336', '0234', @status1 out;
print @status1;

--------------------------------q5-----------------------------------
create procedure proc4
@oldPin varchar(4), @newPin varchar(20), @pinStatus varchar(20) output
as
begin
	set @pinStatus = 'Error';
	if exists(select * from [card] C where C.PIN = @oldPin)
	begin
		if len(@newPin) = 4
		begin
			update [Card] 
			set PIN = @newPin where PIN = @oldPin;
			set @pinStatus = 'Pin changed';
		end
	end
end;
		
declare @pinStatus1 varchar(50);
exec proc4 '0000', '0001', @pinStatus1 out;
print @pinStatus1;

--------------------------------q6-----------------------------------
create procedure Withdraw
@cardNum int, @pinNum varchar(4), @amount float, @status varchar(100) output
as
begin
	declare @pinStatus1 int;
	exec [login] @cardNum, @pinNum, @pinStatus1 out;
	if (@pinStatus1 != 0)
	begin
		if((select C.balance from [Card] C where C.cardNum = @cardNum) >= @amount)
		begin
			update [Card]
			set balance = balance - @amount where cardNum = @cardNum;
			declare @newTransID int, @currentDate Date;
			SET @currentDate = GETDATE();
			select @newTransID = max(transId) + 1 from [Transaction];
			insert into [Transaction] values (@newTransID,@currentDate,@cardNum, @amount,1);
			set @status = 'Transaction Successful';

		end
		else
		begin
			declare @newTransID1 int, @currentDate1 Date;
			SET @currentDate1 = GETDATE();
			select @newTransID1 = max(transId) + 1 from [Transaction];
			insert into [Transaction] values (@newTransID1,@currentDate1,@cardNum, @amount,4);
			set @status = 'Transaction Unsuccessful, low balance!';
		end
	end
	else
	begin
		set @status = 'Transaction Unsuccessful, login error!';
	end
end;

declare @WithdrawStatus1 varchar(100);
exec Withdraw '6456', '1200', 130000, @WithdrawStatus1 out;
print @WithdrawStatus1;

select * from [Card];
select * from [Transaction];
