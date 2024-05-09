USE [PruebaTecnica]
GO
/****** Object:  StoredProcedure [dbo].[spGetAllArticles]    Script Date: 5/8/2024 7:54:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spGetAllArticles]
AS
BEGIN
   SELECT
   ID,
   Codigo,
   Nombre,
   Tipo,
   Marca,
   Precio
FROM
   [dbo].[Articulos] WITH (NOLOCK)
ORDER BY
   Nombre ASC;
END
