USE [PruebaTecnica]
GO
    /****** Object:  StoredProcedure [dbo].[spDeleteArticle]    Script Date: 5/8/2024 10:22:37 PM ******/
SET
    ANSI_NULLS ON
GO
SET
    QUOTED_IDENTIFIER ON
GO
    ALTER PROCEDURE [dbo].[spDeleteArticle] @Codigo VARCHAR(50) AS BEGIN
SET
    NOCOUNT ON;

BEGIN TRY IF NOT EXISTS (
    SELECT
        1
    FROM
        [dbo].[Articulos]
    WHERE
        Codigo = @Codigo
) BEGIN THROW 51000,
'Este articulo no existe.',
1;

END BEGIN TRANSACTION;

DELETE FROM
    [dbo].[Articulos]
WHERE
    Codigo = @Codigo COMMIT TRANSACTION;

END TRY BEGIN CATCH IF @ @TRANCOUNT > 0 ROLLBACK TRANSACTION;

THROW;

END CATCH;

END