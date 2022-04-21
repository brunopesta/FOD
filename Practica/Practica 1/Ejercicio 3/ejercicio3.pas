{3. Realizar un programa que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una
única vez.}

program ej3;

type

empleado = record
    nombre:string[15];
    apellido:string[15];
    dni:string[8];
    edad:integer;
    num:integer;
    end;

archivo = file of empleado;

procedure leer_empleado(var e:empleado);
    begin
        write('Ingrese el apellido del empleado');
        readln(e.apellido);
        if (e.apellido <> 'fin') then begin
            write('Ingrese nombre del empleado');
            readln(e.nombre);
            write('Ingrese el dni del empleado');
            readln(e.dni);
            write('Ingrese la edad del empleado');
            readln(e.edad);
            write('Ingrese el numero del empleado');
            readln(e.num);
        end;
    end;

procedure crear_arch_empleados(var arc_emp:archivo);
var
    e:empleado;
    arc_fisico:string;
    begin
    leer_empleado(e);
    while (e.apellido <> 'fin') do begin    
        write(arc_emp,e);
        leer_empleado(e);
    end;
    close(arc_emp);
    readln();
end;

procedure listar_emp (emp:empleado);
    begin
    writeln(#9+'Apellido: '+ emp.apellido + ' Nombre: '+ emp.nombre+ ' Numero de empleado: ', emp.num ,' Edad: ',emp.edad,' Dni: '+ emp.dni);
    end;

procedure  listar_nombre_apellido(var arc_emp:archivo);
var
    e:empleado;
    n:string;
    arc_nombre:string;
begin
    write('Ingrese el nombre del archivo que desea abrir');
    readln(arc_nombre);
    assign(arc_emp,arc_nombre);
    write('Ingrese nombre o apellido a buscar');
    readln(n);
    writeln('Empleados que coincidan con el nombre o apellido ingresado');
    reset(arc_emp);
    while (not eof(arc_emp)) do begin
        read(arc_emp,e);
        if (e.nombre = n) or (e.apellido = n) then 
            listar_emp(e);
    end;
    close(arc_emp);
    readln();
end;

procedure listar_todos(var arc_emp:archivo);
var 
    e:empleado;
    arc_nombre:string;
begin
    write('Ingrese el nombre del archivo que desesa abrir');
    readln(arc_nombre);
    assign(arc_emp,arc_nombre);
    writeln('Listado de todos los empleados');
    reset(arc_emp);
    while (not eof(arc_emp)) do begin
        read(arc_emp,e);
        listar_emp(e);
    end;
    readln();
end;

procedure listar_emp_mayores(var arc_emp:archivo);
var 
    e:empleado;
    arc_nombre:string;
begin
    write('Ingrese el nombre del archivo que desesa abrir');
    readln(arc_nombre);
    assign(arc_emp,arc_nombre);
    writeln('Listado de empleados con mas de 70 años');
    reset(arc_emp);
    while (not eof(arc_emp)) do begin
        read(arc_emp,e);
        if (e.edad > 70) then
        listar_emp(e);
    end;
    close(arc_emp);
    readln();
end;

procedure show_menu(var arc_emp:archivo);
var
opcion:string;
begin
    writeln(#10+'================== MENU ==================');
    writeln('1. Crear un archivo de empleados.');
    writeln('2. Listar nombre o apellido de empleado determinado.');
    writeln('3. Listar todos los empleados.');
    writeln('4. Listar empleados mayores a 70 años.');
    writeln('5. Salir.');
    writeln('Ingrese una opcion: ');
    readln(opcion);
    case opcion of
        '1': crear_arch_empleados(arc_emp);
        '2': listar_nombre_apellido(arc_emp);
        '3': listar_todos(arc_emp);
        '4': listar_emp_mayores(arc_emp);
        '5': halt;
        else begin
            writeln('Ingreso una opcion invalida.');
        end;
    end;
    show_menu(arc_emp);
end;
var
arc:archivo;
arc_fisico:string;
begin
	write(#10+'Ingrese el nombr que tendra el archivo');
    readln(arc_fisico);
    assign(arc_emp,arc_fisico);
    rewrite(arc_emp);
    show_menu(arc);
    close(arc_emp);
end.
