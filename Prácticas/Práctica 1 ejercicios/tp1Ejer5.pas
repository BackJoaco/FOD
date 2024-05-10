program tp1Ejer5;
type
	celular = record
		codigo : integer;
		nombre : string;
		descripcion : string;
		marca : string;
		precio : real;
		min_stock : integer;
		stock : integer;
	end;
	
	archivo = file of celular;

procedure leerCelular(var c : celular);
begin
	write('Codigo: ');
	readln(c.codigo);
	if (c.codigo <> 1111) then begin
		write('Nombre: ');
		readln(c.nombre);
		write('Descripcion: ');
		readln(c.descripcion);
		write('Marca: ');
		readln(c.marca);
		write('precio: ');
		readln(c.Precio);
		write('Stock minimo: ');
		readln(c.min_stock);
		write('Stock: ');
		readln(c.stock);
	end;
end;

procedure crearArchivo(var file_cel : archivo);
var
	c : celular;
begin
	rewrite(file_cel); // CREAR ARCHIVO
//	reset(file_cel); // ABRIR ARCHIVO
	leerCelular(c);
	while (c <> 1111) do begin
		write(file_cel, c);
		leerCelular(c);
	end;
end;

procedure listarFaltantes(var file_cel : archivo);
var
	c : celular
begin
	reset(file_cel);
	while (not eof(file_cel)) do begin
		read(file_cel, c);
		if (c.stock < c.min_stock) then imprimirCelular(c);
	end;
end;

procedure listarDesc(var file_cel : archivo);
var
	c : celular;
	aux : string;
begin
	reset(file_cel);
	write('Buscar por descripcion: ');
	readln(aux);
	while (not eof(file_cel)) do begin
		read(file_cel, c);
		if (c.descripcion = aux) then imprimirCelular(c);
	end;
end;

var
	file_cel : archivo;
begin
	assign(file_cel, 'celulares.txt');
	crearArchivo(file_cel);
end.
