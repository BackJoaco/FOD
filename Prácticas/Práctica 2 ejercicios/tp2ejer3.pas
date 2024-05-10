program tp2Ejer3;
type
	producto = record
		codigo : integer;
		nombre : string;
		precio : real;
		stock_actual : integer;
		stock_minimo : integer;
	end;
	productos = file of producto;
	venta = record
		codigo : integer;
		cant_ventas : integer;
	end;
	ventas = file of venta;
procedure leerProducto(var p : producto);
begin
	write('codigo: ');
	readln(p.codigo);
	if (p.codigo <> 0) then begin
		write('nombre: ');
		readln(p.nombre);
		write('precio: ');
		readln(p.precio);
		write('stock actual: ');
		readln(p.stock_actual);
		write('stock minimo: ');
		readln(p.stock_minimo);
	end;
end;
procedure leerVenta(var v : venta);
begin
	write('codigo: ');
	readln(v.codigo);
	if (v.codigo <> 0) then begin
		write('Cantidad vendida: ');
		readln(v.cant_ventas);
	end;
end;
procedure crearArchivoProductos(var arc : productos);
var
	p : producto;
begin
	writeln(' ****************************');
	writeln(' *** LECTURA DE PRODUCTOS ***');
	writeln(' ****************************');
	//reset(arc);
	rewrite(arc);
	leerProducto(p);
	while (p.codigo <> 0) do begin
		writeln('-----------------------------');
		write(arc, p);
		leerProducto(p);
	end;
	writeln('----------   FIN   ----------');
	writeln();
	writeln();
	writeln();
	close(arc);
end;
procedure crearArchivoVentas(var arc : ventas);
var
	v : venta;
begin
	writeln(' ****************************');
	writeln(' ***   LECTURA DE VENTAS  ***');
	writeln(' ****************************');
	//reset(arc);
	rewrite(arc);
	leerVenta(v);
	while (v.codigo <> 0) do begin
		writeln('-----------------------------');
		write(arc, v);
		leerVenta(v);
	end;
	close(arc);
	writeln('----------   FIN   ----------');
	writeln();
	writeln();
	writeln();
end;
procedure leerDetalle(var arc : ventas; var v : venta);
begin
	if (not eof(arc)) then
		read(arc, v)
	else
		v.codigo:=0;
end;
procedure actualizarProductos(var maestro : productos; var detalle : ventas);
var
	v : venta;
	p : producto;
begin
	reset(detalle);
	reset(maestro);
	leerDetalle(detalle, v);
	while (v.codigo <> 0) do begin
		if ((p.codigo <> v.codigo) and (not eof(maestro))) then read(maestro, p);
		while ((p.codigo <> v.codigo) and (not eof(maestro))) do read(maestro, p);
		p.stock_actual:= p.stock_actual - v.cant_ventas;
		seek(maestro, FilePos(maestro)-1);
		write(maestro, p);
		leerDetalle(detalle, v);
	end;
	close(detalle);
	close(maestro);
end;
procedure imprimirProducto(var p : producto);
begin
	writeln();
	writeln('codigo: ', p.codigo);
	writeln('nombre: ', p.nombre);
	writeln('precio: ', p.precio:0:2);
	writeln('stock actual: ', p.stock_actual);
	writeln('stock minimo: ', p.stock_minimo);
	writeln();
end;
procedure imprimirProductos(var arc : productos);
var
	p : producto;
begin
	reset(arc);
	while (not eof(arc)) do begin
		read(arc, p);
		imprimirProducto(p);
	end;
	close(arc);
end;
var
	file_ventas : ventas;
	file_productos : productos;
begin
	assign(file_productos, 'productos');
	assign(file_ventas, 'ventas');
	crearArchivoProductos(file_productos);
	crearArchivoVentas(file_ventas);
	writeln(' **********************************');
	writeln(' *** ACTUALIZACION DE PRODUCTOS ***');
	writeln(' **********************************');
	actualizarProductos(file_productos, file_ventas);
	imprimirProductos(file_productos);
end.
