{
    3. Realizar un programa que genere un archivo de novelas filmadas durante el presente
    año. De cada novela se registra: código, género, nombre, duración, director y precio.
    El programa debe presentar un menú con las siguientes opciones:

    a Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
    utiliza la técnica de lista invertida para recuperar espacio libre en el
    archivo. Para ello, durante la creación del archivo, en el primer registro del
    mismo se debe almacenar la cabecera de la lista. Es decir un registro
    ficticio, inicializando con el valor cero (0) el campo correspondiente al
    código de novela, el cual indica que no hay espacio libre dentro del
    archivo. Listo

    b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
    inciso a., se utiliza lista invertida para recuperación de espacio. En
    particular, para el campo de  ́enlace ́ de la lista, se debe especificar los
    números de registro referenciados con signo negativo, (utilice el código de
    novela como enlace).Una vez abierto el archivo, brindar operaciones para:

    i. Dar de alta una novela leyendo la información desde teclado. Para
    esta operación, en caso de ser posible, deberá recuperarse el
    espacio libre. Es decir, si en el campo correspondiente al código de
    novela del registro cabecera hay un valor negativo, por ejemplo -5,
    se debe leer el registro en la posición 5, copiarlo en la posición 0
    (actualizar la lista de espacio libre) y grabar el nuevo registro en la
    posición 5. Con el valor 0 (cero) en el registro cabecera se indica
    que no hay espacio libre.                LISTO ---------------------------------------------------------------------


    ii. Modificar los datos de una novela leyendo la información desde
    teclado. El código de novela no puede ser modificado.
    paso

    iii. Eliminar una novela cuyo código es ingresado por teclado. Por
    ejemplo, si se da de baja un registro en la posición 8, en el campo
    código de novela del registro cabecera deberá figurar -8, y en el
    registro en la posición 8 debe copiarse el antiguo registro cabecera.

    c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
    representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”. ni apalo l hago
    NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
    proporcionado por el usuario.
}
program ejer3;
const
    valor_alto = 9999;
type

    novelas = record
        cod:integer;
        nombre:string;
        genero:string;
        duracion:real;
        director:string;
        precio:double;
    end;

    maestro = file of novelas;

    procedure leerMaestro(var m:maestro; n:novelas);
    begin
        if (not eof(m)) then 
            read(m,n)
        else
            n.cod:= valor_alto
    end;

    procedure alta(var m:maestro; nuevanov:novelas);
    var
        cabecera:novelas;
    begin
        reset(m);
        leerMaestro(m,cabecera);
        if(cabecera.cod = 0) then begin
            seek(m,filesize(m));
            write(m,nuevanov);
        end
        else
            begin 
                seek(m,filepos(cabecera.cod) * -1)
                leerMaestro(m,cabecera);  
                seek(m,filepos(m)-1);
                write(m,nuevanov);
                seek(m,0);
                write(m,cabecera); 
        end;
        close(m);
    end;

    procedure bajaLogica(var m:maestro; codElim:integer);
    var
        regM,cabecera:novelas;
        pos:integer;

    begin
        reset(m);
        leerMaestro(m,cabecera);
        while (not eof(m)) and (regM.cod <> codElim) do
            leerMaestro(m,regM);
        if (regM.cod = codElim) then begin 
            seek(m,filepos(m)-1);
            pos:= (filepos(m) * -1);
            write(m,cabecera);
            seek(m,0);
            cabecera.cod:= pos;
            write(m,cabecera);
        end
        else
            begin
                writeln('No se encontro la novela a eliminar.');
    end;

