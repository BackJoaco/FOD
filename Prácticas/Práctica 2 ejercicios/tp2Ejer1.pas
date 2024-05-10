program tp2Ejer1;
type 
	empleado = record
		codigo : integer;
		nombre : string;
		monto : real;
	end;
	
	archivo = file of empleado;

procedure leerEmpleado(var e : empleado);
begin
	write('Codigo: ');
	readln(e.codigo);
	write('Nombre: ');
	readln(e.nombre);
	write('Monto: ');
	readln(e.monto);
end;

procedure cargar (var file_emp : archivo);
var
	e : empleado;
begin
	rewrite(file_emp);
	repeat
		leerEmpleado(e);
		write(file_emp, e);
	until (e.nombre = 'joaquin');
end;

procedure compactar (var file_emp : archivo; var compact_emp : archivo);
var
	e, aux : empleado;
	suma : real;
begin
	reset(file_emp);
	assign(compact_emp, 'lista_compactada');
	rewrite(compact_emp);
	while (not eof(file_emp)) do begin
		read(file_emp, e);
		suma:=0;
		aux:= e;
		while ((not eof(file_emp)) and (e.codigo = aux.codigo)) do begin
			suma:=suma + e.monto;
			writeln('e');
			read(file_emp, e);
		end;
		//seek(file_emp, filePos(file_emp)-1);
		aux.monto:=suma;
		write(compact_emp, aux);
	end;
	close(compact_emp);
end;

procedure imprimirArchivos(var arch : archivo);
var
	e : empleado;
begin
	reset(arch);
	while (not eof(arch)) do begin
		read(arch, e);
		writeln('Cod: ', e.codigo, ' Nombre: ', e.nombre, ' Monto: $', e.monto);
	end;
end;

var
	file_emp, compact_emp : archivo;
begin
	assign(file_emp, 'empleados');
	//cargar(file_emp);
	writeln('----------------------------');
	compactar(file_emp, compact_emp);
	writeln('----------------------------');
	imprimirArchivos(file_emp);
	writeln('----------------------------');
	imprimirArchivos(compact_emp);
end.
	
