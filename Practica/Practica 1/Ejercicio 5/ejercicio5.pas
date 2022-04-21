{
    5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:

--------a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripcion, marca, precio, stock mínimo y el stock disponible.

-----b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.


-----c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.

d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo.

--------NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
una única vez.

---------NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”
}

program ejer5;

type

    celular = record
        codigo:integer;
        nombre:string[30];
        descripcion:string;
        marca:string[20];
        precio:real;
        stock_minimo:integer;
        stock_disponible:integer;
    end;
    celu_file = file of celular;

    procedure crear_archivo(var arc:celu_file);
    var
        txt:text;
        c:celular;
        nombre:string;
    begin
        writeln('Ingrese el nombre del archivbo txt creado por usted');
        readln(nombre);
        assign(txt,nombre);
        reset(txt);
        writeln('llego');
        rewrite(arc);
        while (not eof (arc)) do begin
            readln(txt, c.codigo, c.precio, c.marca);
            readln(txt, c.stock_disponible, c.stock_minimo, c.descripcion);
            readln(txt, c.nombre);
            write(arc,C);
        end;
        close(txt);
        close(arc);
    end;

    procedure imprimir_celular(c:celular);
    begin
        writeln('Codigo del celular - ',c.codigo);
        writeln('Nombre del celular - ',c.nombre);
        writeln(' Descripcion del celular - ',c.descripcion);
        writeln(' Marca del celular - ',c.marca);
        writeln(' Precio del celular - ',c.precio);
        writeln(' Stock Minimo - ',c.stock_minimo);
        writeln(' Stock Disponible del celular - ',c.stock_disponible);
        writeln();
    end;

    procedure listar_minimo(var arc:celu_file);
    var
        c:celular;
    begin
        reset(arc);
        while (not eof(arc))do begin
            read(arc,c);
            if (c.stock_disponible < c.stock_minimo) then
                imprimir_celular(c);  
        end;
    end;


    procedure listar_con_descripcion(var arc:celu_file);
    var
        c:celular;
        cadena:string;
        encontro:boolean;
    begin
        encontro:= false;
        write('Ingrese la cadena de texto');
        readln(cadena);
        writeln('Resultados que coinciden');
        reset(arc);
        while (not eof (arc)) do begin
            read(arc,c);
            if ( pos(cadena,c.descripcion) <> 0) then begin
                imprimir_celular(c);
                if (not encontro )then
                    encontro:= true;
            end;
        end;
        if( not encontro) then
            writeln('La cadena que ingreso no coincide con ninguna descripcion. ');
        close(arc);
    end;

    procedure exportar_archivo(var arc:celu_file);
    var
        c:celular;
        arc_guardo:text;
    begin
        reset(arc);
        assign(arc_guardo,'celulares.txt');
        rewrite(arc_guardo);
        while (not eof(arc)) do begin
            read(arc,c);
            write(arc_guardo,'Codigo' , c.codigo, #10 + 'Nombre:' + c.nombre + #10 + 'Descripcion: ' + c.descripcion + #10 + 'Marca: ' + c.marca + #10 + 'Precio: ' ,c.precio, #10, 'Stock minimo: ', c.stock_minimo, #10 + 'Stock disponible: ', c.stock_disponible);
        end;
        close(arc);
        close(arc_guardo);
        writeln('Se creo el archivo binario a texto como "celulares.txt" .');
    end;

procedure showMenu(var arc:celu_file);
var
    option: string;
begin
    writeln('======== MENU ========');
    writeln('1. Crear archivo binario.');
    writeln('2. Listar celulares con stock menor al minimo.');
    writeln('3. Listar celulares con determinada descripcion.');
    writeln('4. Exportar archivo binario a texto.');
    writeln('5. Salir.');
    writeln('======================');
    readln(option);
    case option of 
        '1': crear_archivo(arc);
        '2': listar_minimo(arc);
        '3': listar_con_descripcion(arc);
        '4': exportar_archivo(arc);
        '5': halt;
        else begin
            write('Ingreso una opcion invalida. vuelva a intentar');
            showMenu(arc);
        end;
    end;
    showMenu(arc);
end;

var
arc:celu_file;
nombre:string;

begin
    write('Ingrese el nombre del archivo binario con el que desea trabajar');
    readln(nombre);
    assign(arc,nombre);
    rewrite(arc);
    showMenu(arc);
end.
