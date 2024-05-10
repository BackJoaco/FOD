program tp1Ejer2;
type
	archivo = file of integer;
var
	nombre : string;
	numeros : archivo;
	cant, prom, num : integer;
begin
	cant:=0;
	prom:=0;
	write('Ingrese el nombre del archivo a procesar: ');
	readln(nombre);
	assign(numeros, nombre);
	reset(numeros);
	while (not (EOF(numeros))) do begin
		read(numeros, num);
		writeln('Numero: ', num);
		if (num < 1500) then 
			cant:=cant+1;
		prom:= prom + num;
	end;
	prom:= prom div fileSize(numeros);
	writeln('Cantidad de archivos < 1500 = ', cant);
	writeln('Promedio: ', prom);
end.
