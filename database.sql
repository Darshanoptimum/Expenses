USE [master]
GO
/****** Object:  Database [Expense_Management]    Script Date: 23-03-2024 12:23:58 PM ******/
CREATE DATABASE [Expense_Management]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Expense_Management', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Expense_Management.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Expense_Management_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Expense_Management_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Expense_Management] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Expense_Management].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Expense_Management] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Expense_Management] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Expense_Management] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Expense_Management] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Expense_Management] SET ARITHABORT OFF 
GO
ALTER DATABASE [Expense_Management] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Expense_Management] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Expense_Management] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Expense_Management] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Expense_Management] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Expense_Management] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Expense_Management] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Expense_Management] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Expense_Management] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Expense_Management] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Expense_Management] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Expense_Management] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Expense_Management] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Expense_Management] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Expense_Management] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Expense_Management] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Expense_Management] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Expense_Management] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Expense_Management] SET  MULTI_USER 
GO
ALTER DATABASE [Expense_Management] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Expense_Management] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Expense_Management] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Expense_Management] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Expense_Management] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Expense_Management] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Expense_Management] SET QUERY_STORE = ON
GO
ALTER DATABASE [Expense_Management] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Expense_Management]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateTotal]    Script Date: 23-03-2024 12:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateTotal]
(@Month int,@User_id int)
RETURNS int
AS
BEGIN
			DECLARE @sum int = 0;
			WITH  Exps as (
			SELECT MONTH(Date) AS Month,
			SUM(CASE When Ex_Type='credit' then Amount else 0 end) as TotalCredit ,
			SUM(CASE When Ex_Type='debit' then Amount else 0 end) AS TotalDebit 
			,SUM(CASE When Ex_Type='credit' then Amount else -Amount end) as TotalBalance
			FROM Expenses 
			Where User_Id = @User_id
			GROUP BY MONTH(Date)) 
			SELECT @sum=SUM(TotalBalance) FROM Exps WHERE Month<@Month;

   RETURN @sum
END 
GO
/****** Object:  Table [dbo].[Current_Balance_data]    Script Date: 23-03-2024 12:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Current_Balance_data](
	[Bal_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[User_Id] [bigint] NOT NULL,
	[Current_Balance] [bigint] NOT NULL,
 CONSTRAINT [PK_Current_Balance_data] PRIMARY KEY CLUSTERED 
(
	[Bal_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Expenses]    Script Date: 23-03-2024 12:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expenses](
	[Ex_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[User_Id] [bigint] NOT NULL,
	[Ex_Type] [varchar](50) NOT NULL,
	[Date] [date] NOT NULL,
	[Amount] [bigint] NOT NULL,
	[Balance_Amount] [bigint] NOT NULL,
 CONSTRAINT [PK_Expenses] PRIMARY KEY CLUSTERED 
(
	[Ex_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_data]    Script Date: 23-03-2024 12:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_data](
	[User_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Email] [nvarchar](230) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Mobile] [nvarchar](10) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PK_User_data] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Current_Balance_data]  WITH CHECK ADD  CONSTRAINT [FK_Current_Balance_data_User_data] FOREIGN KEY([User_Id])
REFERENCES [dbo].[User_data] ([User_Id])
GO
ALTER TABLE [dbo].[Current_Balance_data] CHECK CONSTRAINT [FK_Current_Balance_data_User_data]
GO
ALTER TABLE [dbo].[Expenses]  WITH CHECK ADD  CONSTRAINT [FK_Expenses_User_data] FOREIGN KEY([User_Id])
REFERENCES [dbo].[User_data] ([User_Id])
GO
ALTER TABLE [dbo].[Expenses] CHECK CONSTRAINT [FK_Expenses_User_data]
GO
/****** Object:  StoredProcedure [dbo].[GetAllExpenses]    Script Date: 23-03-2024 12:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetAllExpenses] --null-- 'darshan@gmail.com'
(@Email nvarchar(230))
AS
BEGIN
	DECLARE @User_Id bigint;
	SELECT @User_Id = User_Id FROM User_data WHERE Email=@Email

	IF @Email IS NULL
	BEGIN 
		SELECT Ex_Id,Expenses.User_Id,Email,Expenses.Date,Ex_Type,Amount,Balance_Amount,'All transaction' AS Result FROM Expenses INNER JOIN User_data ON Expenses.User_Id= User_data.User_Id
		SELECT 0 AS Closing_Balance,0 AS User_Id 
	END

	ELSE
	BEGIN
		SELECT Ex_Id,Expenses.User_Id,Email,Expenses.Date,Ex_Type,Amount,Balance_Amount,'User transaction' AS Result FROM Expenses INNER JOIN User_data ON Expenses.User_Id= User_data.User_Id WHERE Expenses.User_Id=@User_Id
		SELECT Current_Balance AS Closing_Balance,User_Id FROM Current_Balance_data WHERE User_Id=@User_Id
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetExpensesByMonth]    Script Date: 23-03-2024 12:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetExpensesByMonth] --'prince@gmail.com'
(@Email nvarchar(230))
AS
BEGIN

	DECLARE @user_Id bigint;
	SELECT @user_Id=User_Id FROM User_data WHERE Email=@Email;
	WITH  Exps as (
			SELECT MONTH(Date) AS Month,
			SUM(CASE When Ex_Type='credit' then Amount else 0 end) as TotalCredit ,
			SUM(CASE When Ex_Type='debit' then Amount else 0 end) AS TotalDebit 
			,SUM(CASE When Ex_Type='credit' then Amount else -Amount end) as TotalBalance
			FROM Expenses 
			Where User_Id = @user_Id
			GROUP BY MONTH(Date)) 
			

			Select  
			     E1.Month,E1.TotalCredit,E1.TotalDebit, TotalBalance as TotalExpense
			   ,(ISNULL(E1.TotalBalance,0)+ISNULL(dbo.CalculateTotal(E1.Month,@user_Id),0)) as Balance ,'All Data Found' AS Result
				From Exps E1 
	
	SELECT Current_Balance AS Closing_Balance,User_Id FROM Current_Balance_data WHERE User_Id=@user_Id
	
	-----get month vise expenses
	--SELECT d.Month AS Month,d.TotalCredit AS TotalCredit,d.TotalDebit AS TotalDebit,(d.Total+ISNULL(c.Total,0)) AS Total,'All Data Found' AS Result  FROM
	--	(SELECT a.Month AS Month,ISNULL(TotalCredit,0) AS TotalCredit,ISNULL(TotalDebit,0) AS TotalDebit,ISNULL((a.TotalCredit-b.TotalDebit),TotalCredit) as Total
	--	FROM 
	--		(SELECT MONTH(Date) AS Month, SUM(Amount) AS TotalCredit  -- fetch total credit from table
	--		FROM Expenses
	--		WHERE Ex_type = 'credit' AND User_Id = @user_Id
	--		GROUP BY MONTH(Date)) AS a
	--	FULL OUTER JOIN 
	--		(SELECT MONTH(Date) AS Month, isnull(SUM(Amount), 0) AS TotalDebit   -- fetch total debit from table
	--		FROM Expenses
	--		WHERE Ex_type = 'debit' AND User_Id = @user_Id
	--		GROUP BY MONTH(Date)) AS b
	--	ON a.Month = b.Month) AS d
	
	--	LEFT JOIN 

	--	(SELECT a.Month,ISNULL((a.TotalCredit-b.TotalDebit),TotalCredit) as Total
	--	FROM 
	--		(SELECT MONTH(Date) AS Month, SUM(Amount) AS TotalCredit  -- fetch total credit from table
	--		FROM Expenses
	--		WHERE Ex_type = 'credit' AND User_Id = @user_Id
	--		GROUP BY MONTH(Date)) AS a
	--	FULL OUTER JOIN 
	--		(SELECT MONTH(Date) AS Month, isnull(SUM(Amount), 0) AS TotalDebit   -- fetch total debit from table
	--		FROM Expenses
	--		WHERE Ex_type = 'debit' AND User_Id = @user_Id
	--		GROUP BY MONTH(Date)) AS b
	--	ON a.Month = b.Month) AS c ON d.Month-1 = c.Month
	
END
GO
/****** Object:  StoredProcedure [dbo].[insertExpenses]    Script Date: 23-03-2024 12:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[insertExpenses] -- 3,'debit',500
(@User_Id bigint,
@Ex_Type varchar(50),
@Amount bigint
)
AS 
BEGIN
		DECLARE @Balance_Amount bigint = 0 
		SELECT @Balance_Amount=ISNULL(Current_Balance,0) 
		FROM Current_Balance_data 
		WHERE User_Id=@User_Id
	---------------------Credit
	IF(@Ex_Type = 'Credit')
	BEGIN
		
		
		---------------insert
		INSERT INTO Expenses 
		(User_Id,Ex_type,Date,Amount,Balance_Amount) 
		VALUES (@User_Id,@Ex_Type,GETDATE(),@Amount,(@Balance_Amount+@Amount))
		
		----------update Current_Balance
		IF(EXISTS(SELECT 1 FROM Current_Balance_data WHERE User_Id=@User_Id))
			BEGIN
				UPDATE Current_Balance_data 
				SET Current_Balance=Current_Balance+@Amount
				WHERE User_Id=@User_Id
			END
		
		----------insert Current_Balance
		ELSE
			BEGIN
				INSERT INTO Current_Balance_data 
				(User_Id,Current_Balance) 
				VALUES (@User_Id,@Amount)
			END

		-----------responce
		SELECT 'Credited successfully' AS Result,User_Id,Current_Balance as Balance_Amount FROM Current_Balance_data WHERE User_Id=@User_Id
	END

	-----------------Debit
	IF(@Ex_Type = 'Debit')
	BEGIN
		
		------------------- Insufficient balance
		IF(@Amount > @Balance_Amount)
		BEGIN
			-------------------if user ave lower balance

			SELECT 'Insufficient balance' AS Result,@User_Id as User_Id,@Balance_Amount as Balance_Amount
		
		-------------------if user first time add expenses
			/*IF(EXISTS(SELECT 1 FROM Expenses WHERE User_Id = @User_Id))
				BEGIN
					----------------Response
					SELECT 'Insufficient balance' AS Result,User_Id,Current_Balance as Balance_Amount FROM Current_Balance_data WHERE User_Id=@User_Id 
				END
			ELSE
				BEGIN
					----------------Response
					SELECT 'Insufficient balance' AS Result, @User_Id as User_Id
				END*/
		END

		------------------- balance available
		ELSE
		BEGIN
			------------------------insert Expense
			INSERT INTO Expenses 
			(User_Id,Ex_type,Date,Amount,Balance_Amount) 
			VALUES (@User_Id,@Ex_Type,GETDATE(),@Amount,(@Balance_Amount-@Amount))

			---------------------update Current Balance
			IF(EXISTS(SELECT 1 FROM Current_Balance_data WHERE User_Id=@User_Id))
			BEGIN
					UPDATE Current_Balance_data 
					SET Current_Balance=Current_Balance-@Amount
					WHERE User_Id=@User_Id
			END

		----------------Response
			SELECT 'Debited successfully' AS Result,User_Id,Current_Balance as Balance_Amount FROM Current_Balance_data WHERE User_Id=@User_Id
		END
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[insertin]    Script Date: 23-03-2024 12:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[insertin]-- 1,'credit',500,'2024-01-2024'
(@User_Id bigint,
@Ex_Type varchar(50),
@Amount bigint,
@Date date
)
AS 
BEGIN
		DECLARE @Balance_Amount bigint = 0 
		SELECT @Balance_Amount=Current_Balance 
		FROM Current_Balance_data 
		WHERE User_Id=@User_Id
	---------------------Credit
	IF(@Ex_Type = 'Credit')
	BEGIN
		
		
		---------------insert
		INSERT INTO Expenses 
		(User_Id,Ex_type,Date,Amount,Balance_Amount) 
		VALUES (@User_Id,@Ex_Type,@Date,@Amount,(@Balance_Amount+@Amount))
		
		----------update Current_Balance
		IF(EXISTS(SELECT 1 FROM Current_Balance_data WHERE User_Id=@User_Id))
			BEGIN
				UPDATE Current_Balance_data 
				SET Current_Balance=Current_Balance+@Amount
				WHERE User_Id=@User_Id
			END
		
		----------insert Current_Balance
		ELSE
			BEGIN
				INSERT INTO Current_Balance_data 
				(User_Id,Current_Balance) 
				VALUES (@User_Id,@Amount)
			END

		-----------responce
		SELECT 'Credited successfully' AS Result,User_Id,Current_Balance as Balance_Amount FROM Current_Balance_data WHERE User_Id=@User_Id
	END

	-----------------Debit
	IF(@Ex_Type = 'Debit')
	BEGIN
		
		------------------- Insufficient balance
		IF(@Amount > @Balance_Amount)
		BEGIN

		-------------------if user first time add expenses
			IF(EXISTS(SELECT 1 FROM Expenses WHERE User_Id = @User_Id))
				BEGIN
					----------------Response
					SELECT 'Insufficient balance' AS Result,User_Id,Current_Balance as Balance_Amount FROM Current_Balance_data WHERE User_Id=@User_Id 
				END
			ELSE
				BEGIN
					----------------Response
					SELECT 'Insufficient balance' AS Result, @User_Id as User_Id
				END
		END

		------------------- balance available
		ELSE
		BEGIN
			------------------------insert Expense
			INSERT INTO Expenses 
			(User_Id,Ex_type,Date,Amount,Balance_Amount) 
			VALUES (@User_Id,@Ex_Type,@Date,@Amount,(@Balance_Amount-@Amount))

			---------------------update Current Balance
			IF(EXISTS(SELECT 1 FROM Current_Balance_data WHERE User_Id=@User_Id))
			BEGIN
					UPDATE Current_Balance_data 
					SET Current_Balance=Current_Balance-@Amount
					WHERE User_Id=@User_Id
			END

		----------------Response
			SELECT 'Debited successfully' AS Result,User_Id,Current_Balance as Balance_Amount FROM Current_Balance_data WHERE User_Id=@User_Id
		END
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 23-03-2024 12:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertUser]-- 'darshan','darshan0ersdt01@gmail.com','Darshan@123','9510484425','surat'
(
@Name varchar(max),
@Email nvarchar(230),
@Password nvarchar(50),
@Mobile nvarchar(10),
@Address nvarchar(max))
AS
BEGIN
IF(EXISTS(SELECT 1 FROM User_data WHERE Email=@Email))
BEGIN
	SELECT User_Id,Name,Email,Password,Mobile,Address,Date,'User Alredy exist' as result 
	FROM User_data
	WHERE Email=@Email
END
ELSE
BEGIN
	INSERT INTO User_data (Name,Email,Password,Mobile,Address,Date) VALUES (@Name,@Email,@Password,@Mobile,@Address,GETDATE())
	
	SELECT User_Id,Name,Email,Password,Mobile,Address,Date,'Register successfuly' as result 
	FROM User_data
	WHERE Email=@Email 
END
END
GO
USE [master]
GO
ALTER DATABASE [Expense_Management] SET  READ_WRITE 
GO
