program tp3Ejer3;
const
	valorAlto = 31000;
type
	novela = record
		codigo : integer;
		genero : string;
		nombre : string;
		duracion : integer;
		director : string;
		precio : real;
	end;
	archivo = file of novela;
	
procedure leerNovela(var n : novela);
begin
	write('Codigo: ');
	readln(n.codigo);
	if (n.codigo <> valorAlto) then begin
		write('genero: ');
		readln(n.genero);
		write('nombre: ');
		readln(n.nombre);
		write('duracion: ');
		readln(n.duracion);
		write('director: ');
		readln(n.director);
		write('precio: ');
		readln(n.precio);
	end;
end;

procedure crearArchivo();
var
	arc : archivo;
	n : novela;
	nombre : string;
begin
	writeln('Nombre del archivo: ', nombre);
	assign(arc, nombre);
	rewrite(arc);
	n.codigo:=0;
	write(arc, n);
	leerNovela(n);
	while (n.codigo <> valorAlto) do begin
		write(arc, n);
		leerNovela(n);
	end;
	close(arc);
end;

procedure agregarNovela(var arc : archivo);
var
	n, aux : novela;
begin
	read(arc, aux);
	leerNovela(n);
	if (aux.codigo = 0) then begin
		//Se agrega al final del archivo
		seek(arc, filesize(arc) - 1);
		write(arc, n);
		close(arc);
	end else begin
		//Se Agrega en un espacio libre
		seek(arc, (aux.codigo * -1));
		read(arc, aux);
		seek(arc, FilePos(arc) - 1);
		write(arc, n);
		seek(arc, 0);
		write(arc, aux);
	end;
	writeln('Agregado correctamente');
end;

procedure modificarNovela(var arc : archivo);
var
	n, aux : novela;
	encontre : boolean;
begin
	encontre:=false;
	leerNovela(n);
	while ((not eof(arc)) and (not encontre)) do begin
		read(arc, aux);
		if (aux.codigo = n.codigo) then encontre:= true;
	end;
	if (encontre) then begin
		seek(arc, FilePos(arc) - 1);
		write(arc, n);
		writeln('Modificado correctamente');
	end else writeln('El codigo ingresado no es valido');
end;

procedure eliminarNovela(var arc : archivo);
var
	aux : novela;
	pos, pos2: integer;
	cod : integer;
	encontre : boolean;
begin
	encontre:=false;
	writeln('Codigo de la novela que desea eliminar: ', cod);
	// Busco La novela que quiero borrar
	while((not eof(arc)) and (not encontre)) do begin
		read(arc, aux);
		if (aux.codigo = cod) then encontre:= true;
	end;
	if (encontre) then begin
		pos:=FilePos(arc) - 1; // Pos = posicion del archivo a borrar
		seek(arc,0); // me posiciono en la cabecera
		read(arc,aux); // leo la cabecera
		pos2:= aux.codigo; // copio el codigo de la cabecera
		aux.codigo:=pos * -1; // aux = posicion del archivo a borrar
		seek(arc, FilePos(arc) - 1);
		write(arc, aux); // pongo en la cabecera la pocision del archivo borrado
		seek(arc, pos); // Muevo el puntero a la posicion del archivo borrado
		aux.codigo:= pos2;
		write(arc, aux);
	end else writeln('Novela no encontrada');
end;
	
procedure abrirArchivo();
var
	arc : archivo;
	nombre : string;
begin
	writeln('Nombre del arhivo: ', nombre);
	assign(arc, nombre);
	reset(arc);
	
end;

var
	num : integer;
begin
	num:=0;
	while (num <> 4) do begin
		writeln('---------- MENU ------------');
		writeln(' 1. Crear un archivo');
		writeln(' 2. Abrir un archivo');
		writeln(' 3. Imprimir archivo');
		writeln(' 4. Fin');
		writeln('----------------------------');
		write('Que desea hacer: ');
		readln(num);
		case num of
			1 : writeln('En desarrollo');
			2 : writeln('En desarrollo');
			3 : writeln('En desarrollo');
			4 : break;
		else 
			writeln('La opcion ingresada no es valida');
		end;
	end;
end.
