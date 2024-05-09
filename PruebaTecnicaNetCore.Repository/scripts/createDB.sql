USE [master]
GO
    /****** Object:  Database [PruebaTecnica]    Script Date: 5/9/2024 10:06:53 AM ******/
    CREATE DATABASE [PruebaTecnica] CONTAINMENT = NONE ON PRIMARY (
        NAME = N'PruebaTecnica',
        FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PruebaTecnica.mdf',
        SIZE = 8192KB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 65536KB
    ) LOG ON (
        NAME = N'PruebaTecnica_log',
        FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PruebaTecnica_log.ldf',
        SIZE = 8192KB,
        MAXSIZE = 2048GB,
        FILEGROWTH = 65536KB
    ) WITH CATALOG_COLLATION = DATABASE_DEFAULT,
    LEDGER = OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    COMPATIBILITY_LEVEL = 160
GO
    IF (
        1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')
    ) begin EXEC [PruebaTecnica].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
    ALTER DATABASE [PruebaTecnica]
SET
    ANSI_NULL_DEFAULT OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    ANSI_NULLS OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    ANSI_PADDING OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    ANSI_WARNINGS OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    ARITHABORT OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    AUTO_CLOSE OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    AUTO_SHRINK OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    AUTO_UPDATE_STATISTICS ON
GO
    ALTER DATABASE [PruebaTecnica]
SET
    CURSOR_CLOSE_ON_COMMIT OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    CURSOR_DEFAULT GLOBAL
GO
    ALTER DATABASE [PruebaTecnica]
SET
    CONCAT_NULL_YIELDS_NULL OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    NUMERIC_ROUNDABORT OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    QUOTED_IDENTIFIER OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    RECURSIVE_TRIGGERS OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    DISABLE_BROKER
GO
    ALTER DATABASE [PruebaTecnica]
SET
    AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    DATE_CORRELATION_OPTIMIZATION OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    TRUSTWORTHY OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    ALLOW_SNAPSHOT_ISOLATION OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    PARAMETERIZATION SIMPLE
GO
    ALTER DATABASE [PruebaTecnica]
SET
    READ_COMMITTED_SNAPSHOT OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    HONOR_BROKER_PRIORITY OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    RECOVERY SIMPLE
GO
    ALTER DATABASE [PruebaTecnica]
SET
    MULTI_USER
GO
    ALTER DATABASE [PruebaTecnica]
SET
    PAGE_VERIFY CHECKSUM
GO
    ALTER DATABASE [PruebaTecnica]
SET
    DB_CHAINING OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    FILESTREAM(NON_TRANSACTED_ACCESS = OFF)
GO
    ALTER DATABASE [PruebaTecnica]
SET
    TARGET_RECOVERY_TIME = 60 SECONDS
GO
    ALTER DATABASE [PruebaTecnica]
SET
    DELAYED_DURABILITY = DISABLED
GO
    ALTER DATABASE [PruebaTecnica]
SET
    ACCELERATED_DATABASE_RECOVERY = OFF
GO
    ALTER DATABASE [PruebaTecnica]
SET
    QUERY_STORE = ON
GO
    ALTER DATABASE [PruebaTecnica]
SET
    QUERY_STORE (
        OPERATION_MODE = READ_WRITE,
        CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30),
        DATA_FLUSH_INTERVAL_SECONDS = 900,
        INTERVAL_LENGTH_MINUTES = 60,
        MAX_STORAGE_SIZE_MB = 1000,
        QUERY_CAPTURE_MODE = AUTO,
        SIZE_BASED_CLEANUP_MODE = AUTO,
        MAX_PLANS_PER_QUERY = 200,
        WAIT_STATS_CAPTURE_MODE = ON
    )
GO
    USE [PruebaTecnica]
GO
    /****** Object:  Table [dbo].[Articulos]    Script Date: 5/9/2024 10:06:53 AM ******/
SET
    ANSI_NULLS ON
GO
SET
    QUOTED_IDENTIFIER ON
GO
    CREATE TABLE [dbo].[Articulos](
        [ID] [int] IDENTITY(1, 1) NOT NULL,
        [Codigo] [varchar](50) NOT NULL,
        [Nombre] [varchar](100) NOT NULL,
        [Tipo] [varchar](50) NOT NULL,
        [Marca] [varchar](50) NOT NULL,
        [Precio] [decimal](10, 0) NOT NULL,
        CONSTRAINT [PK_Articulos] PRIMARY KEY CLUSTERED ([Codigo] ASC) WITH (
            PAD_INDEX = OFF,
            STATISTICS_NORECOMPUTE = OFF,
            IGNORE_DUP_KEY = OFF,
            ALLOW_ROW_LOCKS = ON,
            ALLOW_PAGE_LOCKS = ON,
            OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
        ) ON [PRIMARY]
    ) ON [PRIMARY]
GO
    /****** Object:  StoredProcedure [dbo].[spAddNewArticle]    Script Date: 5/9/2024 10:06:53 AM ******/
SET
    ANSI_NULLS ON
GO
SET
    QUOTED_IDENTIFIER ON
GO
    CREATE PROCEDURE [dbo].[spAddNewArticle] @Codigo VARCHAR(50),
    @Nombre VARCHAR(100),
    @Tipo VARCHAR(50),
    @Marca VARCHAR(50),
    @Precio DECIMAL(10, 0) AS BEGIN
SET
    NOCOUNT ON;

IF EXISTS (
    SELECT
        1
    FROM
        [dbo].[Articulos]
    WHERE
        Codigo = @Codigo
) BEGIN THROW 50000,
'Codigo de articulo ya existe.',
1;

END IF EXISTS (
    SELECT
        1
    FROM
        [dbo].[Articulos]
    WHERE
        Nombre = @Nombre
) BEGIN THROW 50000,
'Nombre de articulo ya existe.',
1;

END BEGIN TRY BEGIN TRANSACTION;

INSERT INTO
    [dbo].[Articulos] (Codigo, Nombre, Tipo, Marca, Precio)
VALUES
    (@Codigo, @Nombre, @Tipo, @Marca, @Precio);

COMMIT TRANSACTION;

SELECT
    ID,
    Codigo,
    Nombre,
    Tipo,
    Marca,
    Precio
FROM
    [dbo].[Articulos]
WHERE
    Codigo = @Codigo;

END TRY BEGIN CATCH IF @ @TRANCOUNT > 0 ROLLBACK TRANSACTION;

THROW;

END CATCH;

END
GO
    /****** Object:  StoredProcedure [dbo].[spDeleteArticle]    Script Date: 5/9/2024 10:06:53 AM ******/
SET
    ANSI_NULLS ON
GO
SET
    QUOTED_IDENTIFIER ON
GO
    CREATE PROCEDURE [dbo].[spDeleteArticle] @Codigo VARCHAR(50) AS BEGIN
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
GO
    /****** Object:  StoredProcedure [dbo].[spGetAllArticles]    Script Date: 5/9/2024 10:06:53 AM ******/
SET
    ANSI_NULLS ON
GO
SET
    QUOTED_IDENTIFIER ON
GO
    CREATE PROCEDURE [dbo].[spGetAllArticles] AS BEGIN
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
GO
    /****** Object:  StoredProcedure [dbo].[spUpdateArticle]    Script Date: 5/9/2024 10:06:53 AM ******/
SET
    ANSI_NULLS ON
GO
SET
    QUOTED_IDENTIFIER ON
GO
    CREATE PROCEDURE [dbo].[spUpdateArticle] @ID INT,
    @Nombre VARCHAR(100),
    @Tipo VARCHAR(50),
    @Marca VARCHAR(50),
    @Precio DECIMAL(10, 0) AS BEGIN
SET
    NOCOUNT ON;

BEGIN TRY IF @ID < 1 BEGIN THROW 51001,
'El ID del articulo es requerido.',
1;

END IF NOT EXISTS (
    SELECT
        1
    FROM
        [dbo].[Articulos]
    WHERE
        ID = @ID
) BEGIN THROW 51000,
'Articulo no existe.',
1;

END BEGIN TRANSACTION;

UPDATE
    [dbo].[Articulos]
SET
    Nombre = @Nombre,
    Tipo = @Tipo,
    Marca = @Marca,
    Precio = @Precio
WHERE
    ID = @ID;

COMMIT TRANSACTION;

SELECT
    ID,
    Codigo,
    Nombre,
    Tipo,
    Marca,
    Precio
FROM
    [dbo].[Articulos]
WHERE
    ID = @ID;

END TRY BEGIN CATCH IF @ @TRANCOUNT > 0 ROLLBACK TRANSACTION;

THROW;

END CATCH;

END
GO
    USE [master]
GO
    ALTER DATABASE [PruebaTecnica]
SET
    READ_WRITE
GO