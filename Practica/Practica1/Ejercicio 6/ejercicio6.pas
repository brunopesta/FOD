
 {  6. Agregar al menú del programa del ejercicio 5, opciones para:
---------------a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado. 

b. Modificar el stock de un celular dado.

c. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.
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

    procedure cargar_datos_celular(var c: celular);
begin
    write('Ingrese codigo de celular: ');
    readln(c.codigo);
    if(c.codigo <> -1) then begin
        write('Ingrese nombre del celular: ');
        readln(c.nombre);
        write('Ingrese descripcion del celular: ');
        readln(c.descripcion);
        write('Ingrese marca del celular: ');
        readln(c.marca);
        write('Ingrese precio del celular: ');
        readln(c.precio);
        write('Ingrese stock minimo del celular: ');
        readln(c.stock_minimo);
        write('Ingrese stock disponible: ');
        readln(c.stock_disponible);
    end;
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

    procedure agregarCelular(var arc:celu_file);
    c:celular;
    begin
        reset(arc);
        seek(arc,filesize(arc));
        cargar_datos_celular(c);
        while (c.codigo <> -1) do begin
            write(arc,c);
            cargar_datos_celular(c);
        end;
        close(arc);
    end;

    procedure modify_stock_celular(var p:celu_file);
var
    c: celular;
    nombre: string;
    encontro: boolean;
    stock: integer;
begin
    write('Ingrese nombre del celular: ');
    readln(nombre);
    reset(p);
    while not (eof(p)) do begin
        read(p,c);
        if(c.nombre = nombre) then begin
            write('Se encontro el celular: ');
            imprimir_celular(c);
            write('Ingrese stock disponible: ');
            readln(stock);
            seek(p,FilePos(p)-1);
            c.stock_disponible := stock;
            write(p,c);
            encontro:= True
        end;
    end;
    if (encontro) then
        writeln('Se modifico el stock correctamente.')
    else
        writeln('No se encontro el nombre del celular.');
    close(p);
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

procedure exportar_no_stock(var pfile: celu_file);
var
    archivo_texto: Text;
    c: celular;
    precio: string;
begin
    reset(pfile);
    Assign(archivo_texto, 'SinStock.txt');
    Rewrite(archivo_texto);
    while(not eof(pfile)) do begin
        read(pfile,c);
        if(c.stock_disponible = 0) then begin
            str(c.precio:2:2, precio);
            writeln(archivo_texto, c.codigo,' ',precio, c.marca);
            writeln(archivo_texto, c.stock_disponible,' ',c.stock_minimo, c.descripcion);
            writeln(archivo_texto, c.nombre);
        end; 
    end;
    close(pfile);
    close(archivo_texto);
    writeln('Se exporto el archivo "SinStock.txt" correctamente.');
end;

procedure showMenu(var pfile: phone_file);
var
    option: string;
begin
    writeln('======== MENU ========');
    writeln('1. Crear archivo binario.');
    writeln('2. Listar celulares con stock menor al minimo.');
    writeln('3. Listar celulares con determinada descripcion.');
    writeln('4. Exportar archivo binario a texto.');
    writeln('5. Cargar celulares.');
    writeln('6. Modificar el stock de un celular.');
    writeln('7. Exportar la informacion de celulares sin stock a un archivo de texto.');
    writeln('8. Salir.');
    writeln('======================');
    write('Ingrese una opcion: ');
    readln(option);
    case option of 
        '1': crear_archivo(pfile);
        '2': listar_minimo_stock(pfile);
        '3': listar_con_descripcion(pfile);
        '4': exportar_archivo(pfile);
        '5': add_celular(pfile);
        '6': modify_stock_celular(pfile);
        '7': exportar_no_stock(pfile);
        '8': halt;
        else begin
            write('Ingreso una opcion invalida. Vuelva a intentar.');
            showMenu(pfile);
        end;
    end;
    showMenu(pfile);
end;