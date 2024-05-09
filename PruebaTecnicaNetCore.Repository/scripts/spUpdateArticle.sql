USE [PruebaTecnica]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateArticle]    Script Date: 5/8/2024 9:41:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spUpdateArticle] 
    @ID INT,
    @Nombre VARCHAR(100),
    @Tipo VARCHAR(50),
    @Marca VARCHAR(50),
    @Precio DECIMAL(10, 0)
AS 
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY 

	IF @ID < 1
    BEGIN 
        THROW 51001, 'El ID del articulo es requerido.', 1;
    END


        IF NOT EXISTS (
            SELECT 1
            FROM [dbo].[Articulos]
            WHERE ID = @ID
        ) 
        BEGIN 
            THROW 51000, 'Articulo no existe.', 1;
        END

BEGIN TRANSACTION;

        UPDATE [dbo].[Articulos]
        SET 
            Nombre = @Nombre,
            Tipo = @Tipo,
            Marca = @Marca,
            Precio = @Precio
        WHERE ID = @ID;

        COMMIT TRANSACTION;
		 SELECT ID, Codigo, Nombre, Tipo, Marca, Precio 
        FROM [dbo].[Articulos]
        WHERE ID = @ID;
    END TRY 
    BEGIN CATCH
        IF @@TRANCOUNT > 0 
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END