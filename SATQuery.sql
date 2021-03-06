USE [master]
GO
/****** Object:  Database [SAT]    Script Date: 3/16/2021 10:12:49 AM ******/
CREATE DATABASE [SAT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SAT', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SAT.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SAT_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SAT_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SAT] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SAT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SAT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SAT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SAT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SAT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SAT] SET ARITHABORT OFF 
GO
ALTER DATABASE [SAT] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SAT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SAT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SAT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SAT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SAT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SAT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SAT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SAT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SAT] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SAT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SAT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SAT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SAT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SAT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SAT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SAT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SAT] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SAT] SET  MULTI_USER 
GO
ALTER DATABASE [SAT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SAT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SAT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SAT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SAT] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SAT] SET QUERY_STORE = OFF
GO
USE [SAT]
GO
/****** Object:  User [IIS APPPOOL\SAT-API]    Script Date: 3/16/2021 10:12:49 AM ******/
CREATE USER [IIS APPPOOL\SAT-API] FOR LOGIN [IIS APPPOOL\SAT-API] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [IIS APPPOOL\SAT-API]
GO
/****** Object:  Schema [Proceso]    Script Date: 3/16/2021 10:12:49 AM ******/
CREATE SCHEMA [Proceso]
GO
/****** Object:  Schema [Seguridad]    Script Date: 3/16/2021 10:12:49 AM ******/
CREATE SCHEMA [Seguridad]
GO
/****** Object:  Schema [UserInfo]    Script Date: 3/16/2021 10:12:49 AM ******/
CREATE SCHEMA [UserInfo]
GO
/****** Object:  Table [Proceso].[Presencia_Intervalos]    Script Date: 3/16/2021 10:12:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Proceso].[Presencia_Intervalos](
	[ID_Presencia_Intervalo] [int] IDENTITY(1,1) NOT NULL,
	[ID_Usuario] [varchar](15) NOT NULL,
	[ID_Sala_Intervalo] [int] NOT NULL,
 CONSTRAINT [PK__Presenci__D271F3FEE3070766] PRIMARY KEY CLUSTERED 
(
	[ID_Presencia_Intervalo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Proceso].[Salas]    Script Date: 3/16/2021 10:12:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Proceso].[Salas](
	[ID_Sala] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[MomentoIncio] [datetime] NOT NULL,
	[Duracion] [int] NOT NULL,
	[Host] [varchar](15) NOT NULL,
	[Intervalo] [int] NOT NULL,
 CONSTRAINT [PK_Salas] PRIMARY KEY CLUSTERED 
(
	[ID_Sala] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Proceso].[Salas_Intervalos]    Script Date: 3/16/2021 10:12:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Proceso].[Salas_Intervalos](
	[ID_Sala_Intervalo] [int] IDENTITY(1,1) NOT NULL,
	[ID_Sala] [int] NOT NULL,
	[Inicio] [datetime] NOT NULL,
	[Fin] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Sala_Intervalo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Proceso].[Salas_Usuarios]    Script Date: 3/16/2021 10:12:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Proceso].[Salas_Usuarios](
	[ID_Salas_Usuarios] [int] IDENTITY(1,1) NOT NULL,
	[ID_Sala] [int] NOT NULL,
	[ID_Usuario] [varchar](15) NOT NULL,
	[Presente] [bit] NOT NULL,
 CONSTRAINT [PK_Salas_Usuarios] PRIMARY KEY CLUSTERED 
(
	[ID_Salas_Usuarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Seguridad].[Sesiones]    Script Date: 3/16/2021 10:12:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Seguridad].[Sesiones](
	[ID_Sesion] [int] IDENTITY(1,1) NOT NULL,
	[Token] [varchar](100) NOT NULL,
	[Vigencia] [datetime] NOT NULL,
	[ID_Dispositivo] [nvarchar](20) NOT NULL,
	[Usuario] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Sesiones] PRIMARY KEY CLUSTERED 
(
	[ID_Sesion] ASC,
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [UserInfo].[Rol_Usuario]    Script Date: 3/16/2021 10:12:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserInfo].[Rol_Usuario](
	[ID_Usuario] [varchar](15) NOT NULL,
	[ID_Rol] [int] NOT NULL,
 CONSTRAINT [PK_Rol_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario] ASC,
	[ID_Rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [UserInfo].[Roles]    Script Date: 3/16/2021 10:12:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserInfo].[Roles](
	[ID_Rol] [int] NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[ID_Rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [UserInfo].[Usuarios]    Script Date: 3/16/2021 10:12:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserInfo].[Usuarios](
	[ID_Usuario] [varchar](15) NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[Matricula] [varchar](10) NULL,
	[Correo] [varchar](100) NOT NULL,
	[Password] [varchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [Proceso].[Presencia_Intervalos] ON 

INSERT [Proceso].[Presencia_Intervalos] ([ID_Presencia_Intervalo], [ID_Usuario], [ID_Sala_Intervalo]) VALUES (6, N'1', 11)
INSERT [Proceso].[Presencia_Intervalos] ([ID_Presencia_Intervalo], [ID_Usuario], [ID_Sala_Intervalo]) VALUES (7, N'1', 12)
INSERT [Proceso].[Presencia_Intervalos] ([ID_Presencia_Intervalo], [ID_Usuario], [ID_Sala_Intervalo]) VALUES (8, N'1', 30)
INSERT [Proceso].[Presencia_Intervalos] ([ID_Presencia_Intervalo], [ID_Usuario], [ID_Sala_Intervalo]) VALUES (9, N'1', 35)
INSERT [Proceso].[Presencia_Intervalos] ([ID_Presencia_Intervalo], [ID_Usuario], [ID_Sala_Intervalo]) VALUES (10, N'1', 31)
INSERT [Proceso].[Presencia_Intervalos] ([ID_Presencia_Intervalo], [ID_Usuario], [ID_Sala_Intervalo]) VALUES (11, N'1', 38)
INSERT [Proceso].[Presencia_Intervalos] ([ID_Presencia_Intervalo], [ID_Usuario], [ID_Sala_Intervalo]) VALUES (12, N'1', 39)
INSERT [Proceso].[Presencia_Intervalos] ([ID_Presencia_Intervalo], [ID_Usuario], [ID_Sala_Intervalo]) VALUES (13, N'1', 41)
INSERT [Proceso].[Presencia_Intervalos] ([ID_Presencia_Intervalo], [ID_Usuario], [ID_Sala_Intervalo]) VALUES (14, N'1', 87)
SET IDENTITY_INSERT [Proceso].[Presencia_Intervalos] OFF
GO
SET IDENTITY_INSERT [Proceso].[Salas] ON 

INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (1, N'Sala del Profesor X', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, N'4', 0)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (4, N'Matematica Superior', CAST(N'2021-02-19T18:09:15.473' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (5, N'Matematica Superior', CAST(N'2021-02-19T23:43:49.483' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (6, N'Matematica Superior', CAST(N'2021-02-19T23:43:57.937' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (7, N'Matematica Superior', CAST(N'2021-02-19T23:44:08.687' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (8, N'Matematica Superior', CAST(N'2021-02-26T18:15:12.773' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (9, N'Sala de Tesis de los muyayos', CAST(N'2021-02-26T18:16:54.913' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (10, N'Sala de Tesis de los muyayos', CAST(N'2021-03-04T21:51:26.367' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (11, N'Sala de Tesis de los muyayos', CAST(N'2021-03-04T21:53:32.393' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (12, N'Sala de Tesis de los muyayos', CAST(N'2021-03-05T00:21:58.227' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (13, N'Sala de Tesis de los muyayos', CAST(N'2021-03-05T00:32:11.653' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (14, N'Sala de Tesis de los muyayos', CAST(N'2021-03-05T02:59:47.530' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (15, N'Sala de Tesis de los muyayos', CAST(N'2021-03-05T11:02:24.803' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (16, N'Sala de Tesis de los muyayos', CAST(N'2021-03-05T11:27:35.697' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (17, N'Clase De Silverio', CAST(N'2021-03-05T11:34:28.473' AS DateTime), 15, N'5', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (18, N'Clase De Silverio 135', CAST(N'2021-03-05T11:36:15.550' AS DateTime), 15, N'5', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (19, N'Clase De Silverio 140', CAST(N'2021-03-05T11:36:26.243' AS DateTime), 15, N'5', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (20, N'Clase De Silverio 79', CAST(N'2021-03-05T11:36:43.643' AS DateTime), 15, N'5', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (21, N'Clase De Silverio 79', CAST(N'2021-03-05T12:12:14.503' AS DateTime), 15, N'5', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (22, N'Clase De Silverio 79', CAST(N'2021-03-05T12:12:14.503' AS DateTime), 15, N'5', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (23, N'Clase De Silverio 79', CAST(N'2021-03-05T12:12:14.517' AS DateTime), 15, N'5', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (24, N'Clase De Bulin', CAST(N'2021-03-06T23:14:06.943' AS DateTime), 15, N'4', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (25, N'Clase De Bulin', CAST(N'2021-03-07T01:03:36.780' AS DateTime), 15, N'4', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (26, N'Clase De Bulin De Prueba', CAST(N'2021-03-07T01:24:04.090' AS DateTime), 15, N'4', 120)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (27, N'Clase De Solano', CAST(N'2021-03-07T10:36:44.013' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (28, N'Clase del Bulin', CAST(N'2021-03-09T22:57:04.050' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (29, N'Clase a last 2 ', CAST(N'2021-03-10T02:21:54.363' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (30, N'Clase De Harol', CAST(N'2021-03-10T02:23:57.633' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (31, N'Clase De Harol', CAST(N'2021-03-10T02:24:17.563' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (32, N'CLASE De Bulin', CAST(N'2021-03-10T02:30:23.767' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (33, N'CLASE De Bulin', CAST(N'2021-03-10T02:31:50.547' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (34, N'Clase De prueba', CAST(N'2021-03-10T02:37:00.960' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (35, N'Clase 5ta', CAST(N'2021-03-10T02:38:09.980' AS DateTime), 120, N'4', 12)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (36, N'Else k', CAST(N'2021-03-10T02:40:12.077' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (37, N'Gforce', CAST(N'2021-03-10T02:41:02.647' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (38, N'Clase De Matematicas', CAST(N'2021-03-11T19:10:08.243' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (39, N'Clase De Matematicas', CAST(N'2021-03-11T19:11:51.997' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (40, N'Rulin Class', CAST(N'2021-03-11T22:02:39.807' AS DateTime), 120, N'4', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (43, N'Sala de Tesis de los muyayos', CAST(N'2021-03-13T02:42:28.610' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (44, N'Sala de Tesis de los muyayos', CAST(N'2021-03-13T02:46:30.447' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (45, N'Sala de Tesis de los muyayos', CAST(N'2021-03-13T19:54:20.463' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (46, N'La clase del bulin', CAST(N'2021-03-13T21:03:22.047' AS DateTime), 0, N'4', 0)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (47, N'La clase del bulin', CAST(N'2021-03-13T21:05:01.760' AS DateTime), 0, N'4', 0)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (48, N'Clase De Bulin5', CAST(N'2021-03-13T21:09:01.267' AS DateTime), 150, N'4', 35)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (49, N'Clase De Bulin', CAST(N'2021-03-13T21:31:03.047' AS DateTime), 30, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (50, N'Clase De Bulin', CAST(N'2021-03-13T21:34:14.320' AS DateTime), 30, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (51, N'Us class', CAST(N'2021-03-13T21:39:00.100' AS DateTime), 30, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (52, N'Tempo class', CAST(N'2021-03-13T21:39:51.627' AS DateTime), 30, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (53, N'Nino class', CAST(N'2021-03-13T21:41:49.733' AS DateTime), 30, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (54, N'Clase del Bugatti Del Alfa', CAST(N'2021-03-13T21:53:25.333' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (55, N'Lui klok', CAST(N'2021-03-13T23:49:09.113' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (56, N'Lui klok', CAST(N'2021-03-13T23:51:07.227' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (57, N'Lui klok 2', CAST(N'2021-03-13T23:53:13.970' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (58, N'Guitarra pinunin', CAST(N'2021-03-13T23:57:28.383' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (59, N'Guitarra pinunin', CAST(N'2021-03-13T23:59:11.723' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (60, N'Guitarra pinunin', CAST(N'2021-03-14T00:04:45.370' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (61, N'Guitarra pinunin', CAST(N'2021-03-14T00:04:45.370' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (62, N'Guitarra pinunin', CAST(N'2021-03-14T00:04:45.370' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (63, N'Guitarra pinunin', CAST(N'2021-03-14T00:30:50.723' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (64, N'Guitarra pinunin', CAST(N'2021-03-14T00:30:50.723' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (65, N'Clase De Dream Girl', CAST(N'2021-03-14T01:01:08.507' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (66, N'Dale prendelo', CAST(N'2021-03-14T01:42:47.293' AS DateTime), 30, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (67, N'Dale prendelo', CAST(N'2021-03-14T01:44:48.350' AS DateTime), 90, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (68, N'Teteo', CAST(N'2021-03-14T01:55:02.030' AS DateTime), 60, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (69, N'Teteo 2', CAST(N'2021-03-14T01:57:00.897' AS DateTime), 60, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (70, N'Teteo 2', CAST(N'2021-03-14T01:57:45.393' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (71, N'Dedicatoria', CAST(N'2021-03-14T02:06:37.297' AS DateTime), 120, N'4', 30)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (72, N'5 minutes cada part De horas
', CAST(N'2021-03-14T03:55:25.893' AS DateTime), 180, N'4', 3)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (73, N'Sala de Tesis de los muyayos', CAST(N'2021-03-16T01:09:14.810' AS DateTime), 120, N'5', 15)
INSERT [Proceso].[Salas] ([ID_Sala], [Nombre], [MomentoIncio], [Duracion], [Host], [Intervalo]) VALUES (74, N'Sala de Tesis de los muyayos', CAST(N'2021-03-16T03:39:22.703' AS DateTime), 120, N'5', 15)
SET IDENTITY_INSERT [Proceso].[Salas] OFF
GO
SET IDENTITY_INSERT [Proceso].[Salas_Intervalos] ON 

INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (3, 43, CAST(N'2021-03-13T02:57:28.610' AS DateTime), CAST(N'2021-03-13T02:59:28.610' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (4, 43, CAST(N'2021-03-13T03:12:28.610' AS DateTime), CAST(N'2021-03-13T03:14:28.610' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (5, 43, CAST(N'2021-03-13T03:27:28.610' AS DateTime), CAST(N'2021-03-13T03:29:28.610' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (6, 43, CAST(N'2021-03-13T03:42:28.610' AS DateTime), CAST(N'2021-03-13T03:44:28.610' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (7, 43, CAST(N'2021-03-13T03:57:28.610' AS DateTime), CAST(N'2021-03-13T03:59:28.610' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (8, 44, CAST(N'2021-03-13T03:01:30.447' AS DateTime), CAST(N'2021-03-13T03:03:30.447' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (9, 44, CAST(N'2021-03-13T03:16:30.447' AS DateTime), CAST(N'2021-03-13T03:18:30.447' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (10, 44, CAST(N'2021-03-13T03:39:30.447' AS DateTime), CAST(N'2021-03-13T03:43:43.447' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (11, 44, CAST(N'2021-03-13T03:05:30.447' AS DateTime), CAST(N'2021-03-13T03:06:30.447' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (12, 44, CAST(N'2021-03-13T03:55:30.447' AS DateTime), CAST(N'2021-03-13T04:03:30.447' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (13, 44, CAST(N'2021-03-13T04:16:30.447' AS DateTime), CAST(N'2021-03-13T04:18:30.447' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (14, 44, CAST(N'2021-03-13T04:31:30.447' AS DateTime), CAST(N'2021-03-13T04:33:30.447' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (15, 44, CAST(N'2021-03-13T04:46:30.447' AS DateTime), CAST(N'2021-03-13T04:48:30.447' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (16, 45, CAST(N'2021-03-13T20:09:20.463' AS DateTime), CAST(N'2021-03-13T20:11:20.463' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (17, 45, CAST(N'2021-03-13T20:24:20.463' AS DateTime), CAST(N'2021-03-13T20:26:20.463' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (18, 45, CAST(N'2021-03-13T20:39:20.463' AS DateTime), CAST(N'2021-03-13T20:41:20.463' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (19, 45, CAST(N'2021-03-13T20:54:20.463' AS DateTime), CAST(N'2021-03-13T20:56:20.463' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (20, 60, CAST(N'2021-03-14T00:34:45.370' AS DateTime), CAST(N'2021-03-14T00:36:45.370' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (21, 61, CAST(N'2021-03-14T00:34:45.370' AS DateTime), CAST(N'2021-03-14T00:36:45.370' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (22, 62, CAST(N'2021-03-14T00:34:45.370' AS DateTime), CAST(N'2021-03-14T00:36:45.370' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (23, 60, CAST(N'2021-03-14T01:04:45.370' AS DateTime), CAST(N'2021-03-14T01:06:45.370' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (24, 61, CAST(N'2021-03-14T01:04:45.370' AS DateTime), CAST(N'2021-03-14T01:06:45.370' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (25, 61, CAST(N'2021-03-14T01:34:45.370' AS DateTime), CAST(N'2021-03-14T01:36:45.370' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (26, 60, CAST(N'2021-03-14T01:34:45.370' AS DateTime), CAST(N'2021-03-14T01:36:45.370' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (27, 62, CAST(N'2021-03-14T01:04:45.370' AS DateTime), CAST(N'2021-03-14T01:06:45.370' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (28, 62, CAST(N'2021-03-14T01:34:45.370' AS DateTime), CAST(N'2021-03-14T01:36:45.370' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (29, 64, CAST(N'2021-03-14T01:00:50.723' AS DateTime), CAST(N'2021-03-14T01:02:50.723' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (30, 63, CAST(N'2021-03-14T00:52:50.723' AS DateTime), CAST(N'2021-03-14T01:02:50.723' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (31, 63, CAST(N'2021-03-14T01:30:50.723' AS DateTime), CAST(N'2021-03-14T01:32:50.723' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (32, 64, CAST(N'2021-03-14T01:30:50.723' AS DateTime), CAST(N'2021-03-14T01:32:50.723' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (33, 63, CAST(N'2021-03-14T02:00:50.723' AS DateTime), CAST(N'2021-03-14T02:02:50.723' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (34, 64, CAST(N'2021-03-14T02:00:50.723' AS DateTime), CAST(N'2021-03-14T02:02:50.723' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (35, 65, CAST(N'2021-03-14T01:03:08.507' AS DateTime), CAST(N'2021-03-14T01:33:08.507' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (36, 65, CAST(N'2021-03-14T02:01:08.507' AS DateTime), CAST(N'2021-03-14T02:03:08.507' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (37, 65, CAST(N'2021-03-14T02:31:08.507' AS DateTime), CAST(N'2021-03-14T02:33:08.507' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (38, 67, CAST(N'2021-03-14T01:45:48.350' AS DateTime), CAST(N'2021-03-14T02:16:48.350' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (39, 70, CAST(N'2021-03-14T01:58:45.393' AS DateTime), CAST(N'2021-03-14T02:29:45.393' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (40, 70, CAST(N'2021-03-14T02:57:45.393' AS DateTime), CAST(N'2021-03-14T02:59:45.393' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (41, 71, CAST(N'2021-03-14T02:06:37.297' AS DateTime), CAST(N'2021-03-14T02:38:37.297' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (42, 71, CAST(N'2021-03-14T03:06:37.297' AS DateTime), CAST(N'2021-03-14T03:08:37.297' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (43, 71, CAST(N'2021-03-14T03:36:37.297' AS DateTime), CAST(N'2021-03-14T03:38:37.297' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (44, 72, CAST(N'2021-03-14T03:58:25.893' AS DateTime), CAST(N'2021-03-14T04:00:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (45, 72, CAST(N'2021-03-14T04:01:25.893' AS DateTime), CAST(N'2021-03-14T04:03:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (46, 72, CAST(N'2021-03-14T04:04:25.893' AS DateTime), CAST(N'2021-03-14T04:06:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (47, 72, CAST(N'2021-03-14T04:07:25.893' AS DateTime), CAST(N'2021-03-14T04:09:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (48, 72, CAST(N'2021-03-14T04:10:25.893' AS DateTime), CAST(N'2021-03-14T04:12:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (49, 72, CAST(N'2021-03-14T04:13:25.893' AS DateTime), CAST(N'2021-03-14T04:15:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (50, 72, CAST(N'2021-03-14T04:16:25.893' AS DateTime), CAST(N'2021-03-14T04:18:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (51, 72, CAST(N'2021-03-14T04:19:25.893' AS DateTime), CAST(N'2021-03-14T04:21:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (52, 72, CAST(N'2021-03-14T04:22:25.893' AS DateTime), CAST(N'2021-03-14T04:24:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (53, 72, CAST(N'2021-03-14T04:25:25.893' AS DateTime), CAST(N'2021-03-14T04:27:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (54, 72, CAST(N'2021-03-14T04:28:25.893' AS DateTime), CAST(N'2021-03-14T04:30:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (55, 72, CAST(N'2021-03-14T04:31:25.893' AS DateTime), CAST(N'2021-03-14T04:33:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (56, 72, CAST(N'2021-03-14T04:34:25.893' AS DateTime), CAST(N'2021-03-14T04:36:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (57, 72, CAST(N'2021-03-14T04:37:25.893' AS DateTime), CAST(N'2021-03-14T04:39:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (58, 72, CAST(N'2021-03-14T04:40:25.893' AS DateTime), CAST(N'2021-03-14T04:42:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (59, 72, CAST(N'2021-03-14T04:43:25.893' AS DateTime), CAST(N'2021-03-14T04:45:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (60, 72, CAST(N'2021-03-14T04:46:25.893' AS DateTime), CAST(N'2021-03-14T04:48:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (61, 72, CAST(N'2021-03-14T04:49:25.893' AS DateTime), CAST(N'2021-03-14T04:51:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (62, 72, CAST(N'2021-03-14T04:52:25.893' AS DateTime), CAST(N'2021-03-14T04:54:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (63, 72, CAST(N'2021-03-14T04:55:25.893' AS DateTime), CAST(N'2021-03-14T04:57:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (64, 72, CAST(N'2021-03-14T04:58:25.893' AS DateTime), CAST(N'2021-03-14T05:00:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (65, 72, CAST(N'2021-03-14T05:01:25.893' AS DateTime), CAST(N'2021-03-14T05:03:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (66, 72, CAST(N'2021-03-14T05:04:25.893' AS DateTime), CAST(N'2021-03-14T05:06:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (67, 72, CAST(N'2021-03-14T05:07:25.893' AS DateTime), CAST(N'2021-03-14T05:09:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (68, 72, CAST(N'2021-03-14T05:10:25.893' AS DateTime), CAST(N'2021-03-14T05:12:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (69, 72, CAST(N'2021-03-14T05:13:25.893' AS DateTime), CAST(N'2021-03-14T05:15:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (70, 72, CAST(N'2021-03-14T05:16:25.893' AS DateTime), CAST(N'2021-03-14T05:18:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (71, 72, CAST(N'2021-03-14T05:19:25.893' AS DateTime), CAST(N'2021-03-14T05:21:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (72, 72, CAST(N'2021-03-14T05:22:25.893' AS DateTime), CAST(N'2021-03-14T05:24:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (73, 72, CAST(N'2021-03-14T05:25:25.893' AS DateTime), CAST(N'2021-03-14T05:27:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (74, 72, CAST(N'2021-03-14T05:28:25.893' AS DateTime), CAST(N'2021-03-14T05:30:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (75, 72, CAST(N'2021-03-14T05:31:25.893' AS DateTime), CAST(N'2021-03-14T05:33:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (76, 72, CAST(N'2021-03-14T05:34:25.893' AS DateTime), CAST(N'2021-03-14T05:36:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (77, 72, CAST(N'2021-03-14T05:37:25.893' AS DateTime), CAST(N'2021-03-14T05:39:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (78, 72, CAST(N'2021-03-14T05:40:25.893' AS DateTime), CAST(N'2021-03-14T05:42:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (79, 72, CAST(N'2021-03-14T05:43:25.893' AS DateTime), CAST(N'2021-03-14T05:45:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (80, 72, CAST(N'2021-03-14T05:46:25.893' AS DateTime), CAST(N'2021-03-14T05:48:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (81, 72, CAST(N'2021-03-14T05:49:25.893' AS DateTime), CAST(N'2021-03-14T05:51:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (82, 72, CAST(N'2021-03-14T05:52:25.893' AS DateTime), CAST(N'2021-03-14T05:54:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (83, 72, CAST(N'2021-03-14T05:55:25.893' AS DateTime), CAST(N'2021-03-14T05:57:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (84, 72, CAST(N'2021-03-14T05:58:25.893' AS DateTime), CAST(N'2021-03-14T06:00:25.893' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (85, 73, CAST(N'2021-03-16T01:24:14.810' AS DateTime), CAST(N'2021-03-16T01:26:14.810' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (86, 73, CAST(N'2021-03-16T01:39:14.810' AS DateTime), CAST(N'2021-03-16T01:41:14.810' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (87, 73, CAST(N'2021-03-16T01:54:14.810' AS DateTime), CAST(N'2021-03-16T01:56:14.810' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (88, 73, CAST(N'2021-03-16T02:09:14.810' AS DateTime), CAST(N'2021-03-16T02:11:14.810' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (89, 73, CAST(N'2021-03-16T02:24:14.810' AS DateTime), CAST(N'2021-03-16T02:26:14.810' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (90, 73, CAST(N'2021-03-16T02:39:14.810' AS DateTime), CAST(N'2021-03-16T02:41:14.810' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (91, 73, CAST(N'2021-03-16T02:54:14.810' AS DateTime), CAST(N'2021-03-16T02:56:14.810' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (92, 74, CAST(N'2021-03-16T03:54:22.703' AS DateTime), CAST(N'2021-03-16T03:56:22.703' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (93, 74, CAST(N'2021-03-16T04:09:22.703' AS DateTime), CAST(N'2021-03-16T04:11:22.703' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (94, 74, CAST(N'2021-03-16T04:24:22.703' AS DateTime), CAST(N'2021-03-16T04:26:22.703' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (95, 74, CAST(N'2021-03-16T04:39:22.703' AS DateTime), CAST(N'2021-03-16T04:41:22.703' AS DateTime))
INSERT [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo], [ID_Sala], [Inicio], [Fin]) VALUES (96, 74, CAST(N'2021-03-16T04:54:22.703' AS DateTime), CAST(N'2021-03-16T04:56:22.703' AS DateTime))
SET IDENTITY_INSERT [Proceso].[Salas_Intervalos] OFF
GO
SET IDENTITY_INSERT [Proceso].[Salas_Usuarios] ON 

INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (5, 1, N'4', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (6, 1, N'4', 1)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (7, 1, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (8, 1, N'1', 1)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (11, 4, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (12, 9, N'2', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (13, 10, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (14, 12, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (15, 13, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (16, 13, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (17, 13, N'4', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (18, 13, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (19, 13, N'4', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (20, 13, N'4', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (21, 13, N'4', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (22, 14, N'4', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (23, 25, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (24, 25, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (25, 25, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (26, 25, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (27, 25, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (28, 25, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (29, 26, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (30, 26, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (31, 26, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (32, 27, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (33, 27, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (34, 27, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (35, 28, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (36, 39, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (37, 39, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (38, 40, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (39, 44, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (40, 43, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (41, 45, N'4', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (42, 54, N'4', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (43, 54, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (44, 56, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (45, 57, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (46, 63, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (47, 64, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (48, 65, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (49, 66, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (50, 67, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (51, 68, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (52, 70, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (53, 71, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (54, 71, N'5', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (55, 72, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (56, 73, N'1', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (57, 73, N'5', 0)
INSERT [Proceso].[Salas_Usuarios] ([ID_Salas_Usuarios], [ID_Sala], [ID_Usuario], [Presente]) VALUES (58, 74, N'1', 0)
SET IDENTITY_INSERT [Proceso].[Salas_Usuarios] OFF
GO
SET IDENTITY_INSERT [Seguridad].[Sesiones] ON 

INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (1, N'd5cebeef-0f49-46fe-bfe7-af54422c2321', CAST(N'2021-02-03T23:13:59.030' AS DateTime), N'123456', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (2, N'a70a53ec-f072-4231-a10c-261b95c8d241', CAST(N'2021-02-03T23:19:38.280' AS DateTime), N'123456', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (3, N'68ed77c1-ef5b-4cb7-a006-2165e7757737', CAST(N'2021-02-03T23:22:07.527' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (4, N'20f1bd88-4a26-4fef-985f-7626e8e24afa', CAST(N'2021-02-06T21:08:10.957' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (5, N'ad5a605d-7d05-4fa0-80cf-53ca090fa90c', CAST(N'2021-02-06T21:08:30.463' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (6, N'0bf29368-e8f1-4500-9a15-20b5510b4c1c', CAST(N'2021-02-06T21:08:35.427' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (7, N'efce0318-5ae8-4232-9184-0e8343d0edfa', CAST(N'2021-02-06T21:09:21.193' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (8, N'083553d8-4ebc-47c1-ab4e-da3bf206a5ca', CAST(N'2021-02-06T21:09:54.233' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (9, N'9ff1f5db-aa91-4693-b4bb-6a8f4704c08d', CAST(N'2021-02-06T21:09:55.240' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (10, N'9144940e-5a85-4bfd-a7ac-ac8210482191', CAST(N'2021-02-06T21:09:55.983' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (11, N'c7585086-740a-4314-9000-1c8c78b5c6dd', CAST(N'2021-02-06T21:09:56.667' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (12, N'c38f6966-0b53-47de-a4e1-a1e5f1142a55', CAST(N'2021-02-06T21:09:57.250' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (13, N'ce051804-3249-4c8c-9b13-bf35ee7832a4', CAST(N'2021-02-06T21:09:57.687' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (14, N'8fbf4b6e-3fb3-4ff3-8e22-55a240bfa09f', CAST(N'2021-02-06T21:09:58.180' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (15, N'97e82f16-542a-4d42-8dd5-8e6cf3fdda68', CAST(N'2021-02-06T21:26:51.933' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (16, N'971df9a9-00b6-434d-af9c-c8423f6324fc', CAST(N'2021-02-09T00:07:20.760' AS DateTime), N'123', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (17, N'1d993adc-34db-4b17-8a1d-da609ae18302', CAST(N'2021-02-11T18:39:52.010' AS DateTime), N'123', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (18, N'd9ea9f08-3618-4c92-8716-8fa05b94338d', CAST(N'2021-02-13T21:32:58.807' AS DateTime), N'123', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (19, N'91cc3c7c-acbb-4377-8306-ef53907f535f', CAST(N'2021-02-16T00:14:41.767' AS DateTime), N'123', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (20, N'4b76f585-b67c-492b-b18d-73615debf6c0', CAST(N'2021-02-16T00:16:05.900' AS DateTime), N'123', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (21, N'abfd378a-e6ee-429e-8d7e-c6ffeb2ee37f', CAST(N'2021-02-18T15:31:32.863' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (22, N'dda014ad-4f93-47a7-b821-c73941a2e21d', CAST(N'2021-02-19T10:28:34.787' AS DateTime), N'123', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (23, N'935c9e4d-7f76-4a47-9c24-cdf3c9702e85', CAST(N'2021-02-19T18:01:10.340' AS DateTime), N'123', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (24, N'42919328-2191-4345-8ac4-714bc2db62c8', CAST(N'2021-02-19T18:26:53.733' AS DateTime), N'8095655555', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (25, N'4c667274-b5b1-4ef8-98c4-79fbf3aec5e5', CAST(N'2021-02-19T23:43:31.897' AS DateTime), N'8095655555', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (26, N'efcf1700-c68d-4cfc-88a5-49269ae03e8b', CAST(N'2021-02-26T18:12:47.623' AS DateTime), N'8095655555', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (27, N'10f3efbb-b946-476c-a3e4-b70024282685', CAST(N'2021-02-26T18:14:54.500' AS DateTime), N'8095655555', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (28, N'e858d8e1-b6dd-4323-9b08-90ce4a16c465', CAST(N'2021-02-26T18:20:03.553' AS DateTime), N'8095655555', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (29, N'f8e82d83-6514-440e-b3d3-1f239de162e9', CAST(N'2021-03-02T00:15:11.240' AS DateTime), N'8095655555', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (30, N'abc667b7-cd27-4c5b-8861-83e827da9e61', CAST(N'2021-03-02T00:18:04.393' AS DateTime), N'8095655555', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (31, N'bb30146a-6975-4dff-862a-9d9773a29d77', CAST(N'2021-03-02T00:41:45.900' AS DateTime), N'8095655555', N'2')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (32, N'3a2dd656-3d59-4daa-bfa7-d49ccbc0b5ae', CAST(N'2021-03-02T00:43:06.593' AS DateTime), N'8095655555', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (33, N'33dc1663-076e-44e7-b4f1-0e14a33c736d', CAST(N'2021-03-02T00:58:57.973' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (34, N'04f41e15-5fd1-4125-ad0d-4cc8f0fcba01', CAST(N'2021-03-02T01:05:52.450' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (35, N'a1152717-a69b-48bd-8794-08ff366af298', CAST(N'2021-03-02T01:05:57.957' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (36, N'4ec5b7bf-70b1-480d-b68b-142e1f0f1959', CAST(N'2021-03-02T01:05:59.980' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (37, N'e4d9eceb-e79c-4870-8df1-98b8e6b2c381', CAST(N'2021-03-02T01:06:01.020' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (38, N'3f831708-7586-4144-9542-016080d96ae6', CAST(N'2021-03-02T01:06:02.133' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (39, N'dc96d2f8-3941-4e55-9fb9-e2b555bda29c', CAST(N'2021-03-02T22:44:28.757' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (40, N'69573479-981b-449b-8a65-e48aede6122f', CAST(N'2021-03-02T22:44:28.770' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (41, N'aefc6c49-fc16-43b3-87d7-abc791d7b60b', CAST(N'2021-03-02T22:44:28.757' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (42, N'b855a636-7395-44b4-b878-4f2c1ba494ff', CAST(N'2021-03-02T22:44:29.453' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (43, N'd43de6bf-a5a9-46ec-82b9-a1f30dc36323', CAST(N'2021-03-02T22:44:29.527' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (44, N'0350215b-1ff0-41a4-8a4a-9386759a64c3', CAST(N'2021-03-02T23:03:23.050' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (45, N'e3668454-32c0-4487-afa7-89e6b6bdb306', CAST(N'2021-03-02T23:04:16.477' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (46, N'afe86efc-e19d-4471-8910-a10e576db210', CAST(N'2021-03-02T23:58:21.547' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (47, N'602fdf94-91c5-48a5-a0e9-af5ade57514b', CAST(N'2021-03-02T23:59:45.580' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (48, N'52a85ae3-530a-4b92-8d11-c95b0615954c', CAST(N'2021-03-03T00:00:12.550' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (49, N'b8ae500c-a3cd-414e-b775-436d7da3c59f', CAST(N'2021-03-03T00:00:50.480' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (50, N'72bda823-1a15-47f8-b4f5-73ed541839d0', CAST(N'2021-03-03T00:59:12.890' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (51, N'7bd29274-bf07-41c6-b352-a95d024ead8c', CAST(N'2021-03-03T01:20:47.877' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (52, N'57059437-31e6-4232-8439-e13d7875c785', CAST(N'2021-03-03T01:38:23.020' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (53, N'bc2cbaee-0c09-43ac-b3ae-3d8e2121f5a8', CAST(N'2021-03-03T01:40:52.183' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (54, N'a0343bab-9226-4f75-8fad-5c2e99c3b3b7', CAST(N'2021-03-03T01:41:13.293' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (55, N'e815c065-e1ed-4b81-8b88-53c29d04430c', CAST(N'2021-03-03T01:42:42.917' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (56, N'f9706871-997d-4d02-b7a0-af6d3b2728ea', CAST(N'2021-03-03T01:45:57.957' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (57, N'7581e9b9-1c4b-4a00-9617-bc2a4443b4f2', CAST(N'2021-03-03T01:55:10.573' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (58, N'8e4d65e5-1786-465e-ab33-9eafbc1093ee', CAST(N'2021-03-03T01:55:22.337' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (59, N'28ed4d1d-910e-41ab-9bee-3489ae4e2347', CAST(N'2021-03-03T01:58:02.473' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (60, N'17bbab59-bd1a-4482-88a4-2a6a3f10dad1', CAST(N'2021-03-03T01:59:37.133' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (61, N'e3454da1-cfd0-431b-802c-6fea2ad32c7c', CAST(N'2021-03-03T22:12:30.840' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (62, N'6abab6de-d30b-475c-b0f4-ed71c75196fa', CAST(N'2021-03-04T01:45:29.013' AS DateTime), N'8095655555', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (63, N'ad42a615-375c-48b8-92bc-e8507ce20b00', CAST(N'2021-03-04T01:46:20.510' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (64, N'dd45aa34-7c19-4a35-9fc9-7eb403f878c7', CAST(N'2021-03-04T01:56:39.203' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (65, N'89f48188-6cdb-42e6-a3a7-9cef765291a2', CAST(N'2021-03-04T01:56:46.237' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (66, N'e6e3d698-9416-47b1-a7ff-a25357026cc1', CAST(N'2021-03-04T01:57:17.107' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (67, N'60699a80-ec4e-4c8b-ae2f-45749419f28e', CAST(N'2021-03-04T01:57:26.287' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (68, N'c699d820-d7d1-4ca7-a100-95bbe83ab533', CAST(N'2021-03-04T19:32:43.980' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (69, N'56a6e601-d38d-4e2a-bac0-91912052d722', CAST(N'2021-03-04T19:32:45.507' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (70, N'586dfa45-e529-4738-960b-ac31df8e8975', CAST(N'2021-03-04T19:32:49.793' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (71, N'c088a564-6ad8-4253-93c3-b2a4ba821f4d', CAST(N'2021-03-04T21:45:39.883' AS DateTime), N'123', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (72, N'f4ab9ea0-59e7-44da-8360-72869e75b37b', CAST(N'2021-03-04T22:29:03.507' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (73, N'656e4e50-ad35-42f7-bfec-7a7913836822', CAST(N'2021-03-04T22:39:50.253' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (74, N'64861d02-606f-4b4c-9b76-9f821f6980ee', CAST(N'2021-03-04T22:43:26.147' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (75, N'41fa14af-1bab-4345-a676-9de63e6c3b50', CAST(N'2021-03-04T22:43:36.137' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (76, N'5402e7cc-234a-4597-ae43-b44612486b51', CAST(N'2021-03-04T22:45:19.323' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (77, N'd341ed62-95c3-4662-ac8a-76ef6df949d2', CAST(N'2021-03-04T23:21:16.803' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (78, N'7c48e972-d0ef-412c-b922-bc1f14600301', CAST(N'2021-03-04T23:21:16.793' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (79, N'c9e4bb39-ef69-4bc7-8127-3fba95ffd624', CAST(N'2021-03-04T23:52:26.790' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (80, N'6698a5f5-7365-4674-b2db-9bc9176bc058', CAST(N'2021-03-04T23:52:27.780' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (81, N'751e37cd-d0e5-4bf8-8000-d32c8e55039d', CAST(N'2021-03-04T23:53:58.657' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (82, N'e09fe2be-072a-413d-b87a-9eccabc93ccd', CAST(N'2021-03-04T23:55:43.660' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (83, N'd093b163-45da-4e72-a7bb-adaa6707b8ff', CAST(N'2021-03-04T23:58:54.583' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (84, N'07e429d1-495e-4c9a-80e2-56052ca640d5', CAST(N'2021-03-05T00:01:42.100' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (85, N'917b20f6-b439-471b-bcee-1ae6c5147531', CAST(N'2021-03-05T00:01:45.093' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (86, N'7ea46b32-694f-4915-83e2-9e9de69b75e1', CAST(N'2021-03-05T00:02:06.593' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (87, N'4388da70-481e-4778-9433-052c10c8c833', CAST(N'2021-03-05T00:09:40.997' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (88, N'1c4d51df-dbc3-469c-a26a-8c11848b5090', CAST(N'2021-03-05T00:10:05.637' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (89, N'85a376c5-f607-423d-9067-783217e9c5f9', CAST(N'2021-03-05T00:13:22.943' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (90, N'c3721f40-f460-4c01-b5a1-fc0328ea6a40', CAST(N'2021-03-05T00:44:08.127' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (91, N'3882e141-b0ab-4034-91bd-6ff5224e90e8', CAST(N'2021-03-05T00:44:08.127' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (92, N'd4a2132d-719c-4555-a1d7-7d729c246a66', CAST(N'2021-03-05T00:51:39.407' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (93, N'63f078cc-5837-47b3-b1ef-bcda67354905', CAST(N'2021-03-05T00:51:54.627' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (94, N'f7c615d0-e161-4e83-aec8-d6a439380693', CAST(N'2021-03-05T01:00:11.993' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (95, N'64603699-ca14-47b0-bb47-47bed2712abc', CAST(N'2021-03-05T01:00:53.850' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (96, N'18adbdcb-8d91-4447-a038-3d5a44bb98c3', CAST(N'2021-03-05T01:02:40.960' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (97, N'bb2444d9-fd31-4054-b2c2-79c40ca3284e', CAST(N'2021-03-05T01:27:39.027' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (98, N'7d362769-40c9-45fc-b03f-b7d328c7b76d', CAST(N'2021-03-05T01:27:43.703' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (99, N'84083f46-5bcb-46d4-9b16-b222bbec1531', CAST(N'2021-03-05T02:41:27.417' AS DateTime), N'123456', N'4')
GO
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (100, N'd0961d0f-86dc-4d91-b8d6-ab3942f5ac97', CAST(N'2021-03-05T02:44:02.393' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (101, N'0fa60a12-f0ad-4b3e-b88c-a35f9d0f836a', CAST(N'2021-03-05T02:45:22.823' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (102, N'2d2cb864-d8fb-410f-9cc2-6e431bc7f1ab', CAST(N'2021-03-05T02:56:42.100' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (103, N'38c813eb-9bd6-4643-9cf4-c6ca1b86cf71', CAST(N'2021-03-05T02:57:26.713' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (104, N'2d23bc40-ace8-4cc2-9d2a-29ad548b3d1d', CAST(N'2021-03-05T03:03:48.067' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (105, N'8f32850b-aba1-4153-89ae-5ad91eb0e7bd', CAST(N'2021-03-05T09:30:48.120' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (106, N'ea8542d1-a66d-4ca3-848a-ca0b21653e63', CAST(N'2021-03-05T10:09:42.323' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (107, N'389c64a3-660e-435b-92d9-b960f5d9f85f', CAST(N'2021-03-05T10:23:59.600' AS DateTime), N'123456', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (108, N'6b518f22-4c00-487a-8c44-f89650cdb6fc', CAST(N'2021-03-05T10:25:07.407' AS DateTime), N'123', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (109, N'3a15cdc1-f06f-4c56-a46b-ef12bbd10aa6', CAST(N'2021-03-05T10:29:17.440' AS DateTime), N'123', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (110, N'31f15d20-a113-432e-8b2e-6a29f549adc2', CAST(N'2021-03-05T10:29:39.303' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (111, N'eebce648-5e81-426f-99f6-0824366e349c', CAST(N'2021-03-05T10:34:20.580' AS DateTime), N'123456', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (112, N'05e800fc-c5f5-48f7-8fea-762506477818', CAST(N'2021-03-05T10:34:35.517' AS DateTime), N'123456', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (113, N'e116ce9c-961e-4340-addf-45b594412e84', CAST(N'2021-03-05T10:43:00.800' AS DateTime), N'123456', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (114, N'f3ec1399-f41d-4f64-9adb-c715c1f3b9ae', CAST(N'2021-03-05T10:51:24.517' AS DateTime), N'123456', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (115, N'74919831-a2b3-4f54-b77c-7ab033194444', CAST(N'2021-03-05T11:27:38.317' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (116, N'b327f76c-7ffd-4e8c-89a3-661113068397', CAST(N'2021-03-05T11:31:33.643' AS DateTime), N'123456', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (117, N'cb55624c-2013-48ad-8b0e-7ed2e9a2360f', CAST(N'2021-03-05T11:32:13.270' AS DateTime), N'123456', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (118, N'9af4512e-eea7-4159-913b-d442298eef89', CAST(N'2021-03-05T11:34:12.097' AS DateTime), N'123456', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (119, N'de5ebd79-4dae-4dee-b2c9-34e541d59ce0', CAST(N'2021-03-06T22:06:28.110' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (120, N'54faeec7-fb14-4fbd-81be-713ba2e2af6c', CAST(N'2021-03-06T22:06:51.533' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (121, N'a42039d4-6a82-45f3-9434-d4e8278340ce', CAST(N'2021-03-06T22:07:57.483' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (122, N'893c6520-e8a0-4308-b2b7-b4a33c8806e2', CAST(N'2021-03-06T23:13:31.290' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (123, N'ec00737a-bf13-4e58-8498-cbc9c69b8074', CAST(N'2021-03-06T23:13:55.037' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (124, N'0708a4d5-5584-4f0c-8554-40728411d5bf', CAST(N'2021-03-07T00:59:01.357' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (125, N'0855f3fa-cc22-4a55-8c3a-f24832d0c21f', CAST(N'2021-03-07T00:59:01.320' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (126, N'953ec23a-58f3-4cef-aa4d-62fe996fa9ef', CAST(N'2021-03-07T00:59:06.450' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (127, N'754acf17-3a3b-4d60-a76b-e00d0773f3d1', CAST(N'2021-03-07T01:03:25.207' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (128, N'2e8e8d86-994e-4324-aa76-571d9533875c', CAST(N'2021-03-07T01:03:59.617' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (129, N'689d71db-fa7d-4a72-a79e-b4f8beef04b4', CAST(N'2021-03-07T01:14:32.160' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (130, N'93e49041-4360-4a07-9fa5-82aad8bdd9b3', CAST(N'2021-03-07T01:23:43.957' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (131, N'b1f8c754-1a02-4c6c-8055-784cee95be61', CAST(N'2021-03-07T01:25:26.627' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (132, N'a46a69f0-e24f-49ef-8449-452b53894548', CAST(N'2021-03-07T01:31:52.420' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (133, N'dcdc4593-a451-4423-a9dc-6eb8d23c903c', CAST(N'2021-03-07T10:35:51.733' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (134, N'6508e459-4943-4df1-8343-164d171b04c8', CAST(N'2021-03-07T10:35:51.733' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (135, N'f4f3a3fa-0e95-42bc-8886-250806ee28f0', CAST(N'2021-03-07T10:36:23.543' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (136, N'37040ad8-0d3c-4d79-8c5d-3e4ec52a9b12', CAST(N'2021-03-07T10:37:15.163' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (137, N'6cbfa5c9-0aa3-4f06-9829-c1f374ea001a', CAST(N'2021-03-09T22:56:10.697' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (138, N'476b3226-f0ed-4d40-8917-336fdcf75b68', CAST(N'2021-03-09T22:56:13.497' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (139, N'a8b0a6d1-db41-4904-afe5-99159e55792d', CAST(N'2021-03-09T22:56:47.703' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (140, N'7e98b921-2326-4a62-97b5-2cd1b483f9cd', CAST(N'2021-03-09T22:59:00.317' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (141, N'b6c9aafe-59a2-4b6a-ae27-527a416fad84', CAST(N'2021-03-09T22:59:42.403' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (142, N'154f4397-314f-49f3-863c-7c7bfa7a13bf', CAST(N'2021-03-10T02:21:33.857' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (143, N'cb39ff84-1c51-4485-b77c-306f88e785b6', CAST(N'2021-03-10T02:21:36.733' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (144, N'7739e728-124c-41d5-a3c9-f5a4a122c284', CAST(N'2021-03-10T02:23:45.673' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (145, N'11dcad5d-eeee-492d-b771-af32a06f6722', CAST(N'2021-03-10T02:30:02.010' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (146, N'126c3b0d-0f6d-4468-88ba-e8abbf14f3d4', CAST(N'2021-03-10T02:32:49.653' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (147, N'141ec8a4-e407-4169-9708-f173f85198ca', CAST(N'2021-03-10T02:36:20.983' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (148, N'9a86af18-d2c0-4513-ba68-3d63e99e3bc7', CAST(N'2021-03-10T02:36:33.130' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (149, N'093650d8-98ff-404a-8d6d-baef7c258ebe', CAST(N'2021-03-10T02:37:38.893' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (150, N'84194d34-471b-4b46-8a7c-51f428306a14', CAST(N'2021-03-10T02:40:00.180' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (151, N'3716f5ec-8988-4c2a-8f3f-8e039fd39305', CAST(N'2021-03-10T02:40:50.800' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (152, N'4d000c3c-2611-4d17-8583-fca9e92f8333', CAST(N'2021-03-11T19:09:23.047' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (153, N'cc44876b-5904-42c4-8468-74817119776c', CAST(N'2021-03-11T19:13:25.907' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (154, N'c8c8416e-3e24-4ed6-8a0e-68da8c587382', CAST(N'2021-03-11T22:00:47.603' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (155, N'1825b7ff-55df-422b-a66b-7d8cc418ca86', CAST(N'2021-03-11T22:00:57.647' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (156, N'bd291ebe-4f54-4c2b-b3ba-a10763b2e13c', CAST(N'2021-03-11T22:04:44.280' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (157, N'dfc53e93-064f-491d-9ca5-7db29f8795dd', CAST(N'2021-03-11T23:30:21.413' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (158, N'da1c52e6-69d3-44b5-9c90-68f5e3313f8a', CAST(N'2021-03-11T23:30:21.430' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (159, N'3bcf2072-aa08-4f91-b303-22839823c950', CAST(N'2021-03-13T01:15:28.897' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (160, N'b11eaa97-53b2-48b5-bf15-fa6d99e8657d', CAST(N'2021-03-13T01:16:03.683' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (161, N'adcd030f-8137-4214-8e14-3677ee753549', CAST(N'2021-03-13T02:35:12.693' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (162, N'eef3da71-db70-41d5-b7ae-649b7e706002', CAST(N'2021-03-13T02:35:57.743' AS DateTime), N'123', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (163, N'02b7f41e-ac8c-41d7-9f11-712ad43d5082', CAST(N'2021-03-13T19:53:28.793' AS DateTime), N'123', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (164, N'a0061b09-0d46-438e-ba80-d18a4b63e860', CAST(N'2021-03-13T21:02:55.920' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (165, N'dd1d0b53-5717-40f8-a6aa-8a9104e70a8c', CAST(N'2021-03-13T21:08:14.397' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (166, N'0e3e5f4c-74cb-4345-8afb-ace4fc30e45c', CAST(N'2021-03-13T21:18:14.640' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (167, N'3687fc59-470e-45de-a9a3-e55a508bcce7', CAST(N'2021-03-13T21:20:10.020' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (168, N'4ad15dce-9510-4666-9a09-d76861715b55', CAST(N'2021-03-13T21:30:48.607' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (169, N'046d4dab-b24f-4eea-9f88-e56edbd4e73e', CAST(N'2021-03-13T21:38:43.943' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (170, N'c7bc6c48-6c75-426c-b57f-75bdfb0f1833', CAST(N'2021-03-13T21:39:45.467' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (171, N'e44c51ca-dc3e-4be6-b858-4a4c5066abb2', CAST(N'2021-03-13T21:53:03.370' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (172, N'85bfbbb8-b64a-4924-9144-32878725bd62', CAST(N'2021-03-13T21:57:31.353' AS DateTime), N'123', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (173, N'49630fd1-97c7-4086-881e-9b9d7afaea41', CAST(N'2021-03-13T23:46:55.770' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (174, N'8fe2ab86-36d6-4885-8486-459bb2edb959', CAST(N'2021-03-13T23:48:09.560' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (175, N'f114457b-a3ae-4f7a-a47e-f01d22a5c1de', CAST(N'2021-03-13T23:56:56.423' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (176, N'08ec23ef-9c04-41a1-a259-3f05daf89494', CAST(N'2021-03-14T01:00:45.850' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (177, N'8ef096d5-0d1b-413c-b3fa-1e967cc18318', CAST(N'2021-03-14T01:31:15.540' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (178, N'f27effb5-9ac1-41b2-9058-05db2f45ac6c', CAST(N'2021-03-14T01:31:16.743' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (179, N'd10e9d6f-3004-4bef-abf2-33f6c0d4b407', CAST(N'2021-03-14T01:42:38.967' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (180, N'2f42522e-2663-484b-b1ba-b330607899ee', CAST(N'2021-03-14T01:54:41.487' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (181, N'4aecd759-3ceb-46eb-9a77-333328e40f32', CAST(N'2021-03-14T02:06:23.303' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (182, N'f5d18dfe-afe0-41a0-83e3-72c5ce187b6c', CAST(N'2021-03-14T02:14:50.330' AS DateTime), N'123', N'5')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (183, N'ab949cf7-5520-4235-8f09-de762d8d833b', CAST(N'2021-03-14T03:54:59.080' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (184, N'd0994708-ad1a-4a1b-bd20-87977a82b17e', CAST(N'2021-03-14T03:55:04.433' AS DateTime), N'123456', N'4')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (185, N'889a647e-e269-4465-bb9d-ac362b911021', CAST(N'2021-03-14T03:56:06.963' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (186, N'0bd7df9c-c4d7-4d15-99ed-68a234699dd8', CAST(N'2021-03-16T01:11:55.133' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (187, N'9c1a2e90-5deb-417b-8564-1b6400bc8172', CAST(N'2021-03-16T01:11:59.497' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (188, N'2c0eef11-ef23-45ac-8fb2-f916576ce832', CAST(N'2021-03-16T01:36:27.463' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (189, N'7ba905ce-4ee4-4cd8-a9da-f276faf39336', CAST(N'2021-03-16T01:42:23.493' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (190, N'82a6de52-676c-45f4-ae42-13692b28e00f', CAST(N'2021-03-16T01:53:57.063' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (191, N'9145ff3e-2539-4e18-b006-4b6f59d7a658', CAST(N'2021-03-16T01:54:01.340' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (192, N'c2c27e5d-a13f-455b-8f73-21c74c49c05e', CAST(N'2021-03-16T03:41:44.090' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (193, N'89075218-1d26-45b4-a580-af80ac91788d', CAST(N'2021-03-16T03:41:46.093' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (194, N'02515d81-2c9e-4dda-be0f-0ab61e00b21c', CAST(N'2021-03-16T03:47:31.230' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (195, N'4ac6f4e7-07a8-494e-bee9-6d453901699e', CAST(N'2021-03-16T03:48:13.867' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (196, N'e122009d-07fa-49f6-916e-d7ce7c69c2a9', CAST(N'2021-03-16T03:49:49.433' AS DateTime), N'123456', N'1')
INSERT [Seguridad].[Sesiones] ([ID_Sesion], [Token], [Vigencia], [ID_Dispositivo], [Usuario]) VALUES (197, N'cd692822-f7be-421a-ba4f-95929fca425c', CAST(N'2021-03-16T03:51:03.663' AS DateTime), N'123456', N'1')
SET IDENTITY_INSERT [Seguridad].[Sesiones] OFF
GO
INSERT [UserInfo].[Rol_Usuario] ([ID_Usuario], [ID_Rol]) VALUES (N'4', 2)
INSERT [UserInfo].[Rol_Usuario] ([ID_Usuario], [ID_Rol]) VALUES (N'5', 2)
GO
INSERT [UserInfo].[Roles] ([ID_Rol], [Descripcion]) VALUES (1, N'ESTUDIANTE')
INSERT [UserInfo].[Roles] ([ID_Rol], [Descripcion]) VALUES (2, N'PROFESOR')
GO
INSERT [UserInfo].[Usuarios] ([ID_Usuario], [Nombre], [Matricula], [Correo], [Password]) VALUES (N'1', N'Luis Delgado', N'20151064', N'delgado.tdp@gmail.com', N'12345')
INSERT [UserInfo].[Usuarios] ([ID_Usuario], [Nombre], [Matricula], [Correo], [Password]) VALUES (N'2', N'Samuel Peña', N'20151234', N'ersamu@gmail.com', N'123456')
INSERT [UserInfo].[Usuarios] ([ID_Usuario], [Nombre], [Matricula], [Correo], [Password]) VALUES (N'3', N'Ermosen', N'20154321', N'fasd@gmail.com', NULL)
INSERT [UserInfo].[Usuarios] ([ID_Usuario], [Nombre], [Matricula], [Correo], [Password]) VALUES (N'4', N'Bulin', N'2056641', N'bulin47@gmail.com', N'12')
INSERT [UserInfo].[Usuarios] ([ID_Usuario], [Nombre], [Matricula], [Correo], [Password]) VALUES (N'5', N'Radhames Silverio', N'20160564', N'rsilverio@hotmail.com', N'123456789')
GO
ALTER TABLE [Proceso].[Salas_Usuarios] ADD  CONSTRAINT [DF__Salas_Usu__Prese__2E1BDC42]  DEFAULT ((0)) FOR [Presente]
GO
ALTER TABLE [Proceso].[Presencia_Intervalos]  WITH CHECK ADD  CONSTRAINT [FK_Presencia_Intervalos_Usuarios] FOREIGN KEY([ID_Usuario])
REFERENCES [UserInfo].[Usuarios] ([ID_Usuario])
GO
ALTER TABLE [Proceso].[Presencia_Intervalos] CHECK CONSTRAINT [FK_Presencia_Intervalos_Usuarios]
GO
ALTER TABLE [Proceso].[Presencia_Intervalos]  WITH CHECK ADD  CONSTRAINT [FK_Presencia_Sala_Intervalo] FOREIGN KEY([ID_Sala_Intervalo])
REFERENCES [Proceso].[Salas_Intervalos] ([ID_Sala_Intervalo])
GO
ALTER TABLE [Proceso].[Presencia_Intervalos] CHECK CONSTRAINT [FK_Presencia_Sala_Intervalo]
GO
ALTER TABLE [Proceso].[Salas_Intervalos]  WITH CHECK ADD  CONSTRAINT [FK_Salas_Intervalos_Salas] FOREIGN KEY([ID_Sala])
REFERENCES [Proceso].[Salas] ([ID_Sala])
GO
ALTER TABLE [Proceso].[Salas_Intervalos] CHECK CONSTRAINT [FK_Salas_Intervalos_Salas]
GO
ALTER TABLE [Proceso].[Salas_Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_SalasUsuarios_Salas] FOREIGN KEY([ID_Sala])
REFERENCES [Proceso].[Salas] ([ID_Sala])
GO
ALTER TABLE [Proceso].[Salas_Usuarios] CHECK CONSTRAINT [FK_SalasUsuarios_Salas]
GO
ALTER TABLE [Proceso].[Salas_Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_SalasUsuarios_Usuarios] FOREIGN KEY([ID_Usuario])
REFERENCES [UserInfo].[Usuarios] ([ID_Usuario])
GO
ALTER TABLE [Proceso].[Salas_Usuarios] CHECK CONSTRAINT [FK_SalasUsuarios_Usuarios]
GO
ALTER TABLE [Seguridad].[Sesiones]  WITH CHECK ADD  CONSTRAINT [FK_Sesiones_Usuario] FOREIGN KEY([Usuario])
REFERENCES [UserInfo].[Usuarios] ([ID_Usuario])
GO
ALTER TABLE [Seguridad].[Sesiones] CHECK CONSTRAINT [FK_Sesiones_Usuario]
GO
USE [master]
GO
ALTER DATABASE [SAT] SET  READ_WRITE 
GO
