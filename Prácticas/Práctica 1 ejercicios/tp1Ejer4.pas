program tp1Ejer4;
type
	empleados = record
		codigo : integer;
		apellido : string;
		nombre : string;
		edad : integer;
		DNI : integer;
	end;
	archivo = file of empleados;
	
procedure leerEmpleado(var e : empleados);
begin
	write('Apellido: ');
	readln(e.apellido);
	if (e.apellido <> 'fin') then begin
		write('Nombre: ');
		readln(e.nombre);
		write('Edad: ');
		readln(e.edad);
		write('DNI: ');
		readln(e.DNI);
		write('Codigo: ');
		readln(e.codigo);
	end;
end;

procedure imprimirEmpleado(e : empleados);
begin
	writeln('Nombre: ', e.nombre, ' Apellido: ', e.apellido, ' DNI: ', e.DNI, ' Edad: ', e.edad, ' codigo: ', e.codigo);
end;

procedure imprimirArchivo(var file_emp : archivo);
var
	e : empleados;
begin
	reset(file_emp);
	while (not eof(file_emp)) do begin
		read(file_emp, e);
		imprimirEmpleado(e);
	end;
end;

procedure anadirEmpleado(var file_emp : archivo);
var
	e, aux : empleados;
	ok : boolean;
begin
	reset(file_emp);
	leerEmpleado(e);
	while (e.apellido <> 'fin') do begin
		ok:=false;
		//verifico si el empleado ya existe
		while ((not eof(file_emp)) and (not ok)) do begin
			read(file_emp, aux);
			if (e.DNI = aux.DNI) then ok:=true;
		end;
		//si no existe lo agrego
		if (not ok) then begin
			seek(file_emp, filesize(file_emp));
			write(file_emp, e);
		end else
			writeln('No se pueden anadir empleados ya existentes');
		leerEmpleado(e);
	end;
end;

procedure aumentarEdad(var file_emp : archivo);
var
	e : empleados;
	aux : integer;
	ok : boolean;
begin
	reset(file_emp);
	write('Ingrese DNI que desea aumentar: ');
	readln(aux);
	read(file_emp, e);
	ok:=true;
	while ((not eof(file_emp)) and ok) do begin
		if (e.DNI = aux) then begin
			ok := true;
			e.edad:= e.edad + 1;
			seek(file_emp, (Filepos(file_emp)-1));
			write(file_emp, e);
		end;
		read(file_emp, e);
	end;
end;

procedure exportarTxt(var file_emp : archivo);
var
	file_new : archivo;
	e : empleados;
begin
	reset(file_emp);
	assign(file_new, 'todos_empleados.txt');
	rewrite(file_new);
	while (not eof(file_emp)) do begin
		read(file_emp, e);
		write(file_new, e);
	end;
	close(file_new);
end;

var
	file_emp : archivo;
	e : empleados;
begin
	assign(file_emp, 'archivo_empleados');
	imprimirArchivo(file_emp);
	
// AÑADIR EMPLEADO A ARCHIVO EXISTENTE
	{writeln('anadir empleados');
	anadirEmpleado(file_emp);}
	
// AUMENTAR EDAD DE UN EMPLEADO DADO
	{aumentarEdad(file_emp);}

// EXPORTAR ARCHIVO A TXT
	exportarTxt(file_emp);

	{imprimirArchivo(file_emp);}
end.
