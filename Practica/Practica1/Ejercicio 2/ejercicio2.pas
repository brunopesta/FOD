{
   2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.
}


program ejer2bruno;
type 

archivo = file of integer;

procedure imprimir (var arc_num:archivo);
var
    n:integer;
    cant:integer;
    suma:real;
begin
    suma:=0;
    cant:=0;
    while not eof(arc_num) do begin
        read(arc_num,n);
        if (n < 1500) then 
            cant:= cant + 1;
        suma := n + suma;
    end;
    writeln('el promedio es ', (suma / FileSize(arc_num)):2:2);
    writeln('la cantidad de elementos son ', cant);
    close(arc_num);
end;

var
    arc_num:archivo;
    nombre: string;
begin	
    write('Ingresar nombre: ');
    readln(nombre);
    assign(arc_num, nombre);
    reset(arc_num);
    imprimir(arc_num);
end.
