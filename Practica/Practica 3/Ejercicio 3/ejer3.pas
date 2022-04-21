{3. Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:
a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.

b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de    ( Agregarles la pos en negativo para ir sabiendo donde estan)
novela como enlace).Una vez abierto el archivo, brindar operaciones para:

i. Dar de alta una novela leyendo la información desde teclado. Para
esta operación, en caso de ser posible, deberá recuperarse el
espacio libre. Es decir, si en el campo correspondiente al código de
novela del registro cabecera hay un valor negativo, por ejemplo -5,
se debe leer el registro en la posición 5, copiarlo en la posición 0
(actualizar la lista de espacio libre) y grabar el nuevo registro en la
posición 5. Con el valor 0 (cero) en el registro cabecera se indica
que no hay espacio libre.

ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.

iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.

c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario

}

program ejer3p3;
const
valorAlto = 9999;

type  
novelas = record
    cod:integer;
    genero:string;
    duracion:real;
    nombre:string;
    director:string;
    precio:double;
end;

maestro = file of novelas;
procedure cargarMaestro(var n:novelas);
begin
    writeln('Ingrese un codigo de novela');
    readln(n.cod);
    if (n.cod <> valorAlto) then begin
        writeln('Ingrese un genero de pelicula');
        readln(n.genero);
        writeln('Ingrese el nombre de la pelicula');
        readln(n.nombre);
        writeln('Ingrese la duracion de la pelicula');
        readln(n.duracion);
        writeln('Ingrese el nombre del director de la pelicula');
        readln(n.director);
        writeln('Ingrese el precio de la novela');
        readln(n.precio);
    end;
end;


procedure crearMaestro(var m:maestro);
var
    n:novelas;
begin
    assign(m,'maestro');
    rewrite(m);
    n.cod:=0;  //Lista invertida
    write(m,n);
    cargarMaestro(n);
    while (n.cod <> valorAlto) do 
    begin
        write(m,n);
        cargarMaestro(n);
    end;
    close(m);
end;

procedure leer(var m:maestro; var dato:novelas);
begin
    if(not EOF(m)) then     
        read(m,dato)
    else
        dato.cod:=valorAlto;
end;

procedure alta(var m:maestro);
var
    cabecera,n:novelas;
begin
    Reset(m);
    leer(m,cabecera);
    cargarMaestro(n);
    if(cabecera.cod = 0) then begin //Si tengo la cabecera vacia agrego el elemento al final
        Seek(m,filesize(m));
        write(m,n);
    end
    else
        begin
            //EJ si el resultado es -5 voy a la posicion 5
            //(La cabecera siempre tiene que ser un nro negativo o 0)
            Seek(m,(cabecera.cod *(-1)));
            //Una vez que me ubico en el lugar libre, remplazo el elemento
            read(m,cabecera);
            Seek(m,FilePos(m)-1);
            write(m,n);
            Seek(m,0);
            write(m,cabecera);
            //guardo el elemento que habia en la posicion 5
        end;
    close(m);
end;

procedure modificar(var m:maestro);
var
    n:novelas;
    cod:integer;
begin
    writeln('INgrese el codigo de la novela  a modificar');
    readln(cod);
    reset(m);
    leer(m,n);
    if (n.cod <> valorAlto) then begin
        while(n.cod <> cod)do 
            leer(m,n);
        n.cod:= cod;
        write('Genero de novela'); readln(n.genero);
        write('Nombre de novela'); readln(n.nombre);
        write('Duracion de la novela');readln(n.duracion);
        write('Director de la novela'); readln(n.director);
        write('Precio de la novela'); readln(n.precio);
        Seek(m,FilePos(m)-1);
        write(m,n);
    end;
    close(m);
end;

procedure baja(var m:maestro);
var
    n,act:novelas;
    cod,pos:integer;
begin
    reset(m);
    read(m,act);
    writeln('Ingrese el codigo de la novela a eliminar');
    readln(cod);
    leer(m,n);
    while (n.cod <> cod) do //Busco hasta encontrar el numero
        leer(m,n);
    if (n.cod = cod) then begin //Si lo encuentro guardo la posicion
        pos:= FilePos(m)-1;
        n:=act;
        seek(m,pos);
        write(m,n);//Sobrescribo la baja con los datos de cabecera
        act.cod:= -pos;
        seek(m,0);//Me paro en el principio de la lista
        write(m,act);
    end
    else
        writeln('No se encuentra el codigo');
    close(m);
end;

procedure Menu(var m:maestro);
var
    opcion:integer;
begin
    opcion:=0;
    while (opcion <= 3) do begin
        writeln('1/ Dar de a');
        writeln('2/ Modificar');
        writeln('3/ Baja');
        writeln('4/ Cerrar Programa');
        readln(opcion);
        case opcion of
            1: alta(m);
            2: modificar(m);
            3: baja(m);
        end;
    end;
end;

procedure exportarTxt(var x:maestro);
var 
    carga:Text;
    datox:novelas;
begin
    assign(carga,'novelas.txt');
    rewrite(carga);
    reset(x);
    while not eof(x) do begin
        read(x,datox);
        with datox do writeln(carga,cod,' ',nombre,' ', genero);
    end;
    close(x);
    close(carga);
end;
 //-------------------------------------------------------------------------------------
var
    m:maestro;

begin
    //crearMaestro(m);
    Menu(m);
   // exportarTxt(m);

end.