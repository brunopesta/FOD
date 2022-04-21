{4. Dada la siguiente estructura:
type
reg_flor = record
nombre: String[45];
codigo:integer;
tArchFlores = file of reg_flor;
Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
a. Implemente el siguiente módulo:
Abre el archivo y agrega una flor, recibida como parámetro
manteniendo la política descripta anteriormente
procedure agregarFlor (var a: tArchFlores ; nombre: string;
codigo:integer);
b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
considere necesario para obtener el listado.

5. Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:
Abre el archivo y elimina la flor recibida como parámetro manteniendo
la política descripta anteriormente

procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
}

program ejer4;

const
    valorAlto = 9999;
type

    reg_flor = record
        nombre:string[45];
        cod:integer;
    end;

    tArchFlores = file of reg_flor;

procedure leerFlor(var f:reg_flor);
begin
    write('Ingrese el codigo de flor');
    readln(f.cod);
    if (f.cod <> valorAlto) then begin
        write('Ingrese el nombre de flor ');
        readln(f.nombre);
    end;
end;

procedure crearMaestro(var m:tArchFlores);
var
    f:reg_flor;
begin
    rewrite(m);
    f.cod:= 0; //Lista invertida
    write(m,f);
    leerFlor(f);
    while (f.cod <> valorAlto) do begin
        write(m,f);
        leerFlor(f);
    end;
    close(m);
end;

procedure leer(var m:tArchFlores; var dato:reg_flor);
begin
    if(not eof(m)) then 
        read(m,dato)
    else
        dato.cod:= valorAlto;
end;

procedure agregarFlor( var m:tArchFlores; nombre:string; cod:integer);
var
    cabecera,f:reg_flor;
begin
    reset(m);
    leer(m,cabecera);
    f.nombre:= nombre;
    f.cod:= cod;
    if (cabecera.cod = 0) then begin // Si tengo la cabecera vacia agrego al final del archivo
        seek(m,filesize(m));
        write(m,f);
    end
    else
        begin
            //EJ si el resutaldo es -5 voy a la pos -5
            // la cabecera siempre tiene que ser un nro negativo o 0
            Seek(m,(cabecera.cod *(-1)));
            //Una vez que me ubico en el lugar libre, remplazo el elemento
            read(m,cabecera);
            seek(m,FilePos(m)-1);
            write(m,f);
            seek(m,0);
            write(m,cabecera);
            //guardo el elemento que habia en la pos 5
        end;
    close(m);
end;

procedure listar_cont(var m:tArchFlores);
var
    f:reg_flor;
begin
    reset(m);
    while not eof(m) do begin
        read(m,f);
        if (f.cod > 0) then
            write('codigo de flor ',f.cod, ' Nombre de flor ', f.nombre,#10);
    end;
    close(m);
end;

procedure eliminarFlor(var m:tArchFlores; cod:integer);
var
    f,act:reg_flor;
    pos:integer;
begin
    reset(m);
    read(m,act);
    leer(m,f);
    while (f.cod <> cod)do// Busco hasta encontrar el numero
        leer(m,f);
    if (f.cod = cod) then begin // Si no encuentro guardo al Pos
        pos:= FilePos(m)-1;
        f:=act;
        seek(m,pos);
        write(m,f);//Soobrescribo la baja con los datoas de cabecera
        seek(m,0);
        write(m,act);
    end
    else   
        writeln('el codigo de la novela', cod,'No se encuentra en el archivo');
    close(m);
end;
var
    m:tArchFlores;
    cod:integer;

begin
    assign(m,'maestro');
    //crearMaestro(m);
    //agregarFlor(m,'Orquidia',3);
    listar_cont(m);
    writeln('Ingrese un codigo de flor a eliminar');
    readln(cod);
    eliminarFlor(m,cod);
end.