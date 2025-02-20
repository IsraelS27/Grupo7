

create database DBCarrito

GO
USE DBCarrito
GO

CREATE TABLE CATEGORIA(
IdCategoria int primary key identity,
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go

CREATE TABLE MARCA(
IdMarca int primary key identity,
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go

CREATE TABLE PRODUCTO(
IdProducto int primary key identity,
Nombre varchar(500),
Descripcion varchar(500),
IdMarca int references Marca(IdMarca),
IdCategoria int references Categoria(IdCategoria),
Precio decimal(10,2) default 0,
Stock int,
RutaImagen varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go

CREATE TABLE USUARIO(
IdUsuario int primary key identity,
Nombres varchar(100),
Apellidos varchar(100),
Correo varchar(100),
Contrasena varchar(100),
EsAdministrador bit,
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go


CREATE TABLE CARRITO(
IdCarrito int primary key identity,
IdUsuario int references USUARIO(IdUsuario),
IdProducto int references PRODUCTO(IdProducto)
)

go



create table COMPRA(
IdCompra int primary key identity,
IdUsuario int references USUARIO(IdUsuario),
TotalProducto int,
Total decimal(10,2),
Contacto varchar(50),
Telefono varchar(50),
Direccion varchar(500),
IdDistrito varchar(10),
FechaCompra datetime default getdate()
)

go

create table DETALLE_COMPRA(
IdDetalleCompra int primary key identity,
IdCompra int references Compra(IdCompra),
IdProducto int references PRODUCTO(IdProducto),
Cantidad int,
Total decimal(10,2)
)

go

CREATE TABLE DEPARTAMENTO (
  IdDepartamento varchar(2) NOT NULL,
  Descripcion varchar(45) NOT NULL
) 

go

CREATE TABLE PROVINCIA (
  IdProvincia varchar(4) NOT NULL,
  Descripcion varchar(45) NOT NULL,
  IdDepartamento varchar(2) NOT NULL
) 

go

CREATE TABLE DISTRITO (
  IdDistrito varchar(6) NOT NULL,
  Descripcion varchar(45) NOT NULL,
  IdProvincia varchar(4) NOT NULL,
  IdDepartamento varchar(2) NOT NULL
)
go
CREATE TABLE PEDIDOS (
    PedidoID INT IDENTITY(1,1) PRIMARY KEY,
    FechaPedido DATETIME DEFAULT GETDATE(),
    EstadoPedido VARCHAR(50) CHECK (EstadoPedido IN ('Pendiente', 'En Proceso', 'Completado', 'Cancelado')),
    Total DECIMAL(10,2) NOT NULL,
    MetodoPago VARCHAR(50),
    DireccionEnvio VARCHAR(255)
)
go
CREATE TABLE ENVIO (
    IdEnvio INT IDENTITY(1,1) PRIMARY KEY,
    IdPedido INT REFERENCES PEDIDOS(PedidoID),
    IdUsuario INT REFERENCES USUARIO(IdUsuario),
    FechaEnvio DATETIME DEFAULT GETDATE(),
    EstadoEnvio VARCHAR(50) CHECK (EstadoEnvio IN ('Pendiente', 'En Camino', 'Entregado'))
);

CREATE TABLE PAGO (
    IdPago INT IDENTITY(1,1) PRIMARY KEY,
    IdCompra INT REFERENCES COMPRA(IdCompra),
    MetodoPago VARCHAR(50),
    Monto DECIMAL(10,2) NOT NULL,
    EstadoPago VARCHAR(50) CHECK (EstadoPago IN ('Pendiente', 'Pagado', 'Rechazado')),
    FechaPago DATETIME DEFAULT GETDATE()
);

CREATE TABLE RESENAS (
    IdResena INT IDENTITY(1,1) PRIMARY KEY,
    IdUsuario INT REFERENCES USUARIO(IdUsuario),
    IdProducto INT REFERENCES PRODUCTO(IdProducto),
    Calificacion INT CHECK (Calificacion BETWEEN 1 AND 5),
    Comentario VARCHAR(500),
    FechaResena DATETIME DEFAULT GETDATE()
);

