{
1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.
   
   
}


program untitled;

type 

archivo = file of integer;
	
procedure cargarArchivo(var arc_logico:archivo);
var
	n:integer;
BEGIN
	writeln('Ingrese numeros a cargar , El corte de condicion es 30.000');
	readln(n);
		while (n <> 30000) do begin
			write(arc_logico,n);  
			readln(n);
		end;	
END;
var
	logico:archivo;
	nF:string[12];
begin
	writeln('Ingrese el nombre del archivo');
	readln(nF);
	assign(logico,nF);
	rewrite(logico);
	cargarArchivo(logico);
	close(arc_logico);
end.

