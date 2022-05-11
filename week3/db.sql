USE [master]
GO
/****** Object:  Database [ExampleCommerceDb]    Script Date: 5/5/2022 10:57:01 PM ******/
CREATE DATABASE [ExampleCommerceDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ExampleCommerceDb', FILENAME = N'/var/opt/mssql/data/ExampleCommerceDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ExampleCommerceDb_log', FILENAME = N'/var/opt/mssql/data/ExampleCommerceDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ExampleCommerceDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ExampleCommerceDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ExampleCommerceDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ExampleCommerceDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ExampleCommerceDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ExampleCommerceDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ExampleCommerceDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET RECOVERY FULL 
GO
ALTER DATABASE [ExampleCommerceDb] SET  MULTI_USER 
GO
ALTER DATABASE [ExampleCommerceDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ExampleCommerceDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ExampleCommerceDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ExampleCommerceDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ExampleCommerceDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ExampleCommerceDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ExampleCommerceDb', N'ON'
GO
ALTER DATABASE [ExampleCommerceDb] SET QUERY_STORE = OFF
GO
USE [ExampleCommerceDb]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 5/5/2022 10:57:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
	[Details] [nvarchar](max) NOT NULL,
	[PostalCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 5/5/2022 10:57:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 5/5/2022 10:57:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[Id] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 5/5/2022 10:57:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 5/5/2022 10:57:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[AddressId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[PaidPrice] [decimal](18, 2) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 5/5/2022 10:57:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[Sku] [nvarchar](50) NOT NULL,
	[InStock] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/5/2022 10:57:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Cities_idName_index]    Script Date: 5/5/2022 10:57:02 PM ******/
CREATE NONCLUSTERED INDEX [Cities_idName_index] ON [dbo].[Cities]
(
	[Name] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Cities]    Script Date: 5/5/2022 10:57:02 PM ******/
CREATE NONCLUSTERED INDEX [IX_Cities] ON [dbo].[Cities]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Contries_idName_index]    Script Date: 5/5/2022 10:57:02 PM ******/
CREATE NONCLUSTERED INDEX [Contries_idName_index] ON [dbo].[Countries]
(
	[Id] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Products_category_index]    Script Date: 5/5/2022 10:57:02 PM ******/
CREATE NONCLUSTERED INDEX [Products_category_index] ON [dbo].[Products]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Products_sku_index]    Script Date: 5/5/2022 10:57:02 PM ******/
CREATE NONCLUSTERED INDEX [Products_sku_index] ON [dbo].[Products]
(
	[Sku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Users_email_index]    Script Date: 5/5/2022 10:57:02 PM ******/
CREATE NONCLUSTERED INDEX [Users_email_index] ON [dbo].[Users]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Users_phone_index]    Script Date: 5/5/2022 10:57:02 PM ******/
CREATE NONCLUSTERED INDEX [Users_phone_index] ON [dbo].[Users]
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Cities] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Cities]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Users]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [CountryId] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [CountryId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Addresses1] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Addresses1]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Products1] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Products1]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users1] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users1]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Products] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Products]
GO
/****** Object:  StoredProcedure [dbo].[stockUpdater]    Script Date: 5/5/2022 10:57:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[stockUpdater]
	-- Add the parameters for the stored procedure here
	@ProductId int , 
	@update_value int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE Products SET InStock=InStock+@update_value  where @ProductId= Products.Id;
END
GO
/****** Object:  Trigger [dbo].[order_insert_trigger]    Script Date: 5/5/2022 10:57:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   TRIGGER [dbo].[order_insert_trigger]
   ON  [dbo].[Orders]
   AFTER INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for trigger here
		IF NOT EXISTS(SELECT * FROM DELETED)
            -- INSERT
			UPDATE Products SET InStock=InStock-1  from inserted as i where i.ProductId= Products.Id;
        ELSE
			BEGIN
            -- UPDATE
			IF EXISTS(SELECT i.* FROM inserted as i, deleted as d where i.ProductId!=d.ProductId)
				BEGIN
				Declare @InsertedProductId int ;
				Declare @DeletedProductId int ;
				set @InsertedProductId = (select i.ProductId from inserted as i);
				set @DeletedProductId = (select d.ProductId from deleted as d);
				exec stockUpdater @InsertedProductId,1;
				exec stockUpdater @DeletedProductId,-1;
				END
			END

END
GO
ALTER TABLE [dbo].[Orders] ENABLE TRIGGER [order_insert_trigger]
GO
USE [master]
GO
ALTER DATABASE [ExampleCommerceDb] SET  READ_WRITE 
GO
