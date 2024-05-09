USE [PruebaTecnica]
GO
/****** Object:  StoredProcedure [dbo].[spAddNewArticle]    Script Date: 5/8/2024 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spAddNewArticle] 
    @Codigo VARCHAR(50),
    @Nombre VARCHAR(100),
    @Tipo VARCHAR(50),
    @Marca VARCHAR(50),
    @Precio DECIMAL(10, 0)
AS 
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM [dbo].[Articulos]
        WHERE Codigo = @Codigo
    )
    BEGIN
        THROW 50000, 'Codigo de articulo ya existe.', 1;
    END  
	
	IF EXISTS (
        SELECT 1
        FROM [dbo].[Articulos]
        WHERE Nombre = @Nombre
    )
    BEGIN
        THROW 50000, 'Nombre de articulo ya existe.', 1;
    END  

    BEGIN TRY 
        BEGIN TRANSACTION;

        INSERT INTO [dbo].[Articulos] (Codigo, Nombre, Tipo, Marca, Precio)
        VALUES (@Codigo, @Nombre, @Tipo, @Marca, @Precio);

        COMMIT TRANSACTION;

        SELECT ID, Codigo, Nombre, Tipo, Marca, Precio 
        FROM [dbo].[Articulos]
        WHERE Codigo = @Codigo;
    END TRY 
    BEGIN CATCH
        IF @@TRANCOUNT > 0 
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END