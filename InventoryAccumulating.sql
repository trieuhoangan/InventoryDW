CREATE TABLE InventoryReceiptAccumulatingFact (
	ProductLotReceiptNumber INT NOT NULL PRIMARY KEY,
    QuantityReceived INT NOT NULL,
    QuantityInspected INT NOT NULL,
    QuantityReturnedToVendor INT NOT NULL,
    QuantityPlacedInBin INT NOT NULL,
    QuantityShippedToCustomer INT NOT NULL,
    QuantityReturnedByCustomer INT NOT NULL,
    QuantityReturnedToInventory INT NOT NULL,
    QuantityDamaged INT NOT NULL,
    ReceiptToInspectedLag BOOLEAN,
    ReceiptToBinPlacementLag BOOLEAN,
    ReceiptToInitialShipmentLag BOOLEAN,
    InitialToLastShipmentLag BOOLEAN,
    FOREIGN KEY (DateReceivedKey) REFERENCES DateReceivedDimension(DateReceivedKey),
    FOREIGN KEY (DateInspectedKey) REFERENCES DateInspectedDimension(DateInspectedKey),
    FOREIGN KEY (DateBinPlacementKey) REFERENCES DateBinPlacementDimension(DateBinPlacementKey),
    FOREIGN KEY (DateInitialShipmentKey) REFERENCES DateInitialShipmentDimension(DateInitialShipmentKey),
    FOREIGN KEY (DateLastShipmentKey) REFERENCES DateLastShipmentDimension(DateLastShipmentKey),
    FOREIGN KEY (ProductKey) REFERENCES ProductDimension(ProductKey),
    FOREIGN KEY (WarehouseKey) REFERENCES WarehouseDimension(WarehouseKey),
    FOREIGN KEY (VendorKey) REFERENCES VendorDimension(VendorKey)
)
GO

CREATE TABLE DateReceivedDimension (
	DateReceivedKey int NOT NULL PRIMARY KEY,
)
GO

CREATE TABLE DateInspectedDimension (
	DateInspectedKey int NOT NULL PRIMARY KEY,
)
GO

CREATE TABLE DateBinPlacementDimension (
    DateBinPlacementKey int NOT NULL PRIMARY KEY,
)
GO

CREATE TABLE DateInitialShipmentDimension (
	DateInitialShipmentKey int NOT NULL PRIMARY KEY,
)
GO

CREATE TABLE DateLastShipmentDimension (
	DateLastShipmentKey int NOT NULL PRIMARY KEY,
)
GO

CREATE TABLE ProductDimension (
	ProductKey INT identity NOT NULL PRIMARY KEY,
)
GO

CREATE TABLE WarehouseDimension (
	WarehouseKey INT identity NOT NULL PRIMARY KEY,
)
GO

CREATE TABLE VendorDimension (
	VendorKey INT identity NOT NULL PRIMARY KEY,
)
GO