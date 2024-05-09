USE [PruebaTecnica]
GO
/****** Object:  Trigger [dbo].[ResetArticleIDSeed]    Script Date: 5/8/2024 10:03:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgResetArticleIDSeed]
ON [dbo].[Articulos] 
AFTER DELETE
AS
BEGIN
    DECLARE @MaxID INT;
    
    SELECT @MaxID = ISNULL(MAX(ID), 0)
    FROM [dbo].[Articulos];
    
    DBCC CHECKIDENT('Articulos', RESEED, @MaxID);
END;