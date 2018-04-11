 USE master
 GO


 CREATE DATABASE InventoryDW
 GO

USE InventoryDW
GO
CREATE TABLE [dbo].[ProductDimension]
(
    [ProductKey] [int] identity(1,1) NOT NULL,
    [ProductAltKey] [nvarchar](255) NOT NULL,
    [ProductName] [nvarchar](255) NULL,
    [ProductLine] [nvarchar](255) NULL,
    [ProductCategoryName] [nvarchar](255) NULL,
    [ProductClass] [nvarchar](255) null,
    [ProductModel] [int] null,
    [ProductValue] [int] NULL,
    [ProductQuantity] [int] not null,
    [ProductSource] [NVARCHAR](255) null
) on [PRIMARY];

CREATE TABLE [dbo].[WarehouseDimension]
(
    [WarehouseKey] [int] IDENTITY(1,1) NOT NULL,
    [WarehouseNumber] [int] NOT NULL,
    [WarehouseName] [NVARCHAR](255) NULL,
    [WarehouseAddress] [NVARCHAR](255) NULL,
    [WarehouseCity] [nvarchar](255) null,
    [WarehouseZone] [NVARCHAR](255) null,
    [WarehouseTotalSquareFootage] [NVARCHAR](255) null, 
) ON [PRIMARY]
GO
-- tao bang Inventory Transaction type dimension
CREATE TABLE [dbo].[InventoryTransactionTypeDimension]
(
    [InventoryTransactionTypeKey] [int] IDENTITY(1,1) NOT NULL,
    [InventoryTransactionTypeDescription] [TEXT] NULL,
    [InventoryTransactionTypeGroup] [NVARCHAR](255) NULL,
) ON [PRIMARY]
GO
-- tao bang Store Dimension
create table [dbo].[StoreDimension]
(
    [StoreKey] [int] IDENTITY(1,1) not NULL,
    [StoreAddress] [NVARCHAR](255)  null,
    [StoreManager] [NVARCHAR](255)  null,
    [StoreNumber] [int] not null,
    [StoreName] [NVARCHAR](255) not null,
    [StoreCounty] [NVARCHAR](255) null,
    [FloorPlanType] [NVARCHAR](255) null,
    [SellingSquareFootage] [INT] not null,
    [TotalSquareFootage] [INT] not null,
    [FirstOpenDate] [DATE] null,
    [LastRemodelDate] [DATE] null
) on [PRIMARY];
-- Tao ban vendor dimension
-- create table [dbo].[VendorDimension]
-- (
--     [VendorKey] [int] IDENTITY(1,1) not null,
--     [VendorName] [NVARCHAR](255) not null,
--     [VendorProductType] [NVARCHAR](255) null,
--     [VendorProductQuantity] [int] not null,
--     [VendorAddress] [NVARCHAR](255) null,
--     [VendorDescription] [NVARCHAR](255)  null, 
--     [VendorPayment] int  null
-- ) ON [Primary];
-- tao bang Date Dimension
CREATE TABLE [dbo].[DateDimension]
(
  	[DateKey] int identity(1,1) not null,
	[full_date] date NULL,
	[day_of_week] [float] NULL,
	[day_num_in_month] [float] NULL,
	[day_num_overall] [float] NULL,
	[day_name] [nvarchar](255) NULL,
	[day_abbrev] [nvarchar](255) NULL,
	[weekday_flag] [nvarchar](255) NULL,
	[weekd_num_in_year] [float] NULL,
	[week_num_of_overall] [float] NULL,
	[week_begin_date] date NULL,
	[week_begin_date_key] [float] NULL,
	[month] [float] NULL,
	[month_num_overall] [float] NULL,
	[month_name] [nvarchar](255) NULL,
	[month_abbrev] [nvarchar](255) NULL,
	[quarter] [float] NULL,
	[year] [float] NULL,
	[year_month] [float] NULL,
	[fiscal_month] [float] NULL,
	[fiscal_quarter] [float] NULL,
	[fiscal_year] [float] NULL,
	[month_end_flag] [nvarchar](255) NULL

) ON [PRIMARY];

CREATE TABLE [dbo].[WarehouseInventoryTransactionFact]
(
    [DateKey] [int] NOT NULL,
    [InventoryTransactionTypeKey] [int] NOT NULL , 
    [WarehouseKey] [int] NOT NULL ,
    [ProductKey] [int] NOT NULL ,  
    [InventoryTransactionNumber] [INT] NULL,
    [InventoryTransactionDollarAmount] [int] NULL,
    [NumberofProduct] [int] NULL, 
    [TypeOfProduct] [int] NULL


) ON [PRIMARY];

create TABLE [dbo].[PeriodicInventoryFact]
(
    --SnapshotKey int NOT NULL IDENTITY PRIMARY KEY NONCLUSTERED,
    [ProductKey] [int]  NOT NULL ,
    [StoreKey] [int] not NULL ,
    [DateKey] [int] not null ,
    [NumberOfTrans] [int],
    [QuantityOnHand] [int] null,
    [QuantitySold] [int] null,
    [InventoryDollarValueAtCost] [int] null,
    [InventoryDollarValueAtLatestSellingPrice] [int] null
)ON [PRIMARY] ;


-- add Primary Key
SET QUOTED_IDENTIFIER ON;

ALTER TABLE [dbo].[DateDimension] WITH CHECK ADD 
    CONSTRAINT [PK__DateDimension] PRIMARY KEY CLUSTERED
	(
	[DateKey]
	) ON [PRIMARY];
GO
ALTER TABLE [dbo].[ProductDimension] WITH CHECK ADD 
    CONSTRAINT [PK__ProductDimension] PRIMARY KEY CLUSTERED
	(
	[ProductKey]
	) ON [PRIMARY];
GO
ALTER TABLE [dbo].[StoreDimension] WITH CHECK ADD 
    CONSTRAINT [PK__StoreDimension] PRIMARY KEY CLUSTERED
	(
	[StoreKey]
	) ON [PRIMARY];
GO
ALTER TABLE [dbo].[WarehouseDimension] WITH CHECK ADD 
    CONSTRAINT [PK__WHDimension] PRIMARY KEY CLUSTERED
	(
	[WarehouseKey]
	) ON [PRIMARY];
GO
ALTER TABLE [dbo].[InventoryTransactionTypeDimension] WITH CHECK ADD 
    CONSTRAINT [PK__ITTDimension] PRIMARY KEY CLUSTERED
	(
	[InventoryTransactionTypeKey]
	) ON [PRIMARY];
GO
ALTER TABLE [dbo].[PeriodicInventoryFact] WITH CHECK ADD 
    CONSTRAINT [PK__PeriodicDimension] PRIMARY KEY CLUSTERED
	(
	[DateKey], [ProductKey], [StoreKey]
	) ON [PRIMARY];
GO
ALTER TABLE [dbo].[WarehouseInventoryTransactionFact] WITH CHECK ADD 
    CONSTRAINT [PK__TransactionDimension] PRIMARY KEY CLUSTERED
	(
	[DateKey], [ProductKey], [InventoryTransactionTypeKey], [WarehouseKey]
	) ON [PRIMARY];
GO

--set FK


ALTER TABLE [dbo].[PeriodicInventoryFact] ADD 
    CONSTRAINT [FK_DateDIm_Periodic] FOREIGN KEY 
    (
        [DateKey]
    ) REFERENCES [dbo].[DateDimension] ([DateKey]);
GO

ALTER TABLE [dbo].[PeriodicInventoryFact] ADD 
    CONSTRAINT [FK_PRODUCTDIM_Periodic] FOREIGN KEY 
    (
        [ProductKey]
    ) REFERENCES [dbo].[ProductDimension]([ProductKey]);
GO


ALTER TABLE [dbo].[PeriodicInventoryFact] ADD 
    CONSTRAINT [FK_StoreDim_Periodic] FOREIGN KEY 
    (
        [StoreKey]
    ) REFERENCES [dbo].[StoreDimension] ([StoreKey]);
GO


ALTER TABLE [dbo].[WarehouseInventoryTransactionFact] ADD 
    CONSTRAINT [FK_DateDim_Transaction] FOREIGN KEY 
    (
        [DateKey]
    ) REFERENCES [dbo].[DateDimension] ([DateKey]);
GO


ALTER TABLE [dbo].[WarehouseInventoryTransactionFact] ADD 
    CONSTRAINT [FK_WarehouseDim_Transaction] FOREIGN KEY 
    (
        [WarehouseKey]
    ) REFERENCES [dbo].[WarehouseDimension] ([WarehouseKey]);
GO


ALTER TABLE [dbo].[WarehouseInventoryTransactionFact] ADD 
    CONSTRAINT [FK_ProductDIm_Transaction] FOREIGN KEY 
    (
        [ProductKey]
    ) REFERENCES [dbo].[ProductDimension] ([ProductKey]);
GO


ALTER TABLE [dbo].[WarehouseInventoryTransactionFact] ADD 
    CONSTRAINT [FK_TransactionDIm_Transaction] FOREIGN KEY 
    (
        [InventoryTransactionTypeKey]
    ) REFERENCES [dbo].[InventoryTransactionTypeDimension] ([InventoryTransactionTypeKey]);
GO
SET QUOTED_IDENTIFIER Off;