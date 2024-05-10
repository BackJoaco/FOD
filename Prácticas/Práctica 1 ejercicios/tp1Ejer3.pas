program tp1Ejer3;
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
	writeln('Nombre: ', e.nombre, 'Apellido: ', e.apellido, 'DNI: ', e.DNI, 'Edad: ', e.edad, 'codigo: ', e.codigo);
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
			if (e.apellido = aux.apellido) then ok:=true;
		end;
		//si no existe lo agrego
		if (not ok) then begin
			seek(file_emp, filesize(file_emp));
			write(file_emp, e);
		end;
		leerEmpleado(e);
	end;
end;
var
	file_emp : archivo;
	e : empleados;
	clave : string;
begin
	assign(file_emp, 'archivo_empleados');
// SE CREA EL ARCHIVO
	rewrite(file_emp);
	leerEmpleado(e);
	while (e.apellido <> 'fin') do begin
		write(file_emp, e);
		leerEmpleado(e);
	end;
	close(file_emp);
	
// SE IMPRIME EL EMPLEADO FILTRADO POR APELLIDO O NOMBRE
	writeln('------------------------------------------------');
	reset(file_emp);
	write('Ingrese nombre o apellido que desea buscar: ');
	readln(clave);
	while (not eof(file_emp)) do begin
		read(file_emp, e);
		if ((e.apellido = clave) or (e.nombre = clave)) then imprimirEmpleado(e);
	end;

// SE IMPRIME EL ARCHIVO
	writeln('------------------------------------------------');
	reset(file_emp);
	while (not eof(file_emp)) do begin
		read(file_emp, e);
		imprimirEmpleado(e);
	end;

// SE IMPRIMEN LOS EMPLEADOS MAYORES DE 70 AÑOS
	writeln('------------------------------------------------');
	reset(file_emp);
	while (not eof(file_emp)) do begin
		read(file_emp, e);
		if (e.edad > 70) then imprimirEmpleado(e);
	end;
	
end.
