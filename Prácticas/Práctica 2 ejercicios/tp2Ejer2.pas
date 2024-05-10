program tp2Ejer2;
type
	alumno = record
		codigo : integer;
		nombre : string;
		apellido : string;
		cursadas : integer;
		finales : integer;
	end;
	maestro = file of alumno;
	materia = record
		codigo : integer;
		cursada : boolean;
		finall : boolean;
	end;
	detalle = file of materia;
procedure leerAlumno(var a : alumno);
begin
	write('codigo: ');
	readln(a.codigo);
	if (a.codigo <> 0) then begin
		write('nombre: ');
		readln(a.nombre);
		write('apellido: ');
		readln(a.apellido);
		write('cursadas: ');
		readln(a.cursadas);
		write('finales: ');
		readln(a.finales);
	end;
end;
procedure leerMateria(var m : materia);
var
	i : integer;
begin
	write('codigo: ');
	readln(m.codigo);
	if (m.codigo <> 0) then begin
		write('cursadas: ');
		readln(i);
		if (i > 0) then m.cursada:=true else m.cursada:=false;
		write('finales: ');
		readln(i);
		if (i > 0) then m.finall:=true else m.finall:=false;
	end;
end;
procedure crearArchivoMaestro(var arc : maestro);
var
	a : alumno;
begin
	rewrite(arc);
	//reset(arc);
	leerAlumno(a);
	while (a.codigo <> 0) do begin
		write(arc, a);
		leerAlumno(a);
	end;
	close(arc);
end;
procedure crearArchivoDetalle(var arc : detalle);
var
	m : materia;
begin
	rewrite(arc);
	//reset(arc);
	leerMateria(m);
	while (m.codigo <> 0) do begin
		write(arc, m);
		leerMateria(m);
	end;
	close(arc);
end;
procedure leerDetalle(var d : detalle; var m : materia);
begin
	if (not eof(d)) then
		read(d, m)
	else
		m.codigo:=0;
end;
procedure actualizarMaestro(var master : maestro; var detail : detalle);
var
	mat : materia;
	alu : alumno;
begin
	reset(master);
	reset(detail);
	leerDetalle(detail, mat);
	while (mat.codigo <> 0) do begin
		if (not eof(master)) then read(master, alu);
		while ((alu.codigo <> mat.codigo) and (not eof(master))) do read(master, alu);
		if (mat.cursada) then alu.cursadas:=alu.cursadas+1;
		if (mat.finall) then begin
			alu.finales:= alu.finales+1;
			alu.cursadas:=alu.cursadas-1;
		end;
		seek(master, FilePos(master)-1);
		write(master, alu);
		leerDetalle(detail,mat);
	end;
	close(master);
	close(detail);
end;

procedure imprimirAlumno(a : alumno);
begin
	writeln('codigo: ', a.codigo);
	writeln('nombre: ', a.nombre);
	writeln('apellido: ', a.apellido);
	writeln('cursadas: ', a.cursadas);
	writeln('finales: ', a.finales);
end;
procedure imprimirMateria(m : materia);
begin
	writeln('codigo: ', m.codigo);
	writeln('cursadas: ', m.cursada);
	writeln('finales: ', m.finall);
end;
procedure imprimirArchivo(var arc : maestro);
var
	a : alumno;
begin
	reset(arc);
	while (not eof(arc)) do begin
		read(arc, a);
		imprimirAlumno(a);
	end;
end;
var
	master : maestro;
	detail : detalle;
begin
	assign(master, 'infoAlumnos');
	assign(detail, 'infoDetalleAlumnos');
	{crearArchivoMaestro(master);}
	crearArchivoDetalle(detail);
	imprimirArchivo(master);
	writeln('--------------------------');
	actualizarMaestro(master, detail);
	imprimirArchivo(master);
end.
