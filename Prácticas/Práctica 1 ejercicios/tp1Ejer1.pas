program tp1Ejer1;
type
	archivo = file of integer;
var
	numeros : archivo;
	nombre : string;
	num : integer;
begin
	write('Nombre del archivo: ');
	readln(nombre);
	assign(numeros, nombre);
	rewrite(numeros);
	write('Ingrese un numero: ');
	readln(num);
	while (num <> 30000) do begin
		write(numeros, num);
		write('Ingrese un numero: ');
		readln(num);
	end;
	close(numeros);
end.
