{Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.}
program ejer2;

const
    valor_corte = 1000;
type

asistentes = record
    nro_asis:integer;
    nombre_apellido :string[30];
    email:string;
    telefono:integer;
    dni:string[8];
    end;

    maestro = file of asistentes;

procedure cargar_Asistentes(var r:asistentes);
begin
    writeln('Ingrese el numero de asistente');
    readln(r.nro_asis);
    if (r.nro_asis <> -1) then begin 
        writeln('Ingrese el nombre y apellido del asistente');
        readln(r.nombre_apellido);
        writeln('Ingrese el email del asistente');
        readln(r.email);
        writeln('Ingrese el telefono del asistente');
        readln(r.telefono);
        writeln('Ingrese el dni del asistente');
        readln(r.dni);
    end;
end;

procedure crearArchivo(var ma:maestro);
var
    regM:asistentes;
begin
    rewrite(ma);
    cargar_Asistentes(regM);
    while (regM.nro_asis <> -1) do begin
        write(ma,regM);
        cargar_Asistentes(regM);
    end;
    close(ma);
end;



procedure eliminar_asistente(var ma:maestro);
var
    reg_m:asistentes;
begin
    reset(ma);
    while not eof(ma) do begin
        read(ma,reg_m);
        if (reg_m.nro_asis < valor_corte) then begin
            reg_m.dni:= '#'+ reg_m.dni;
            seek(ma,FilePos(ma) - 1);
            write(ma,reg_m);
        end;
    end;
    close(ma);
end;

procedure imprimir_asistente(reg_m: asistentes);
begin
    writeln('');
    writeln('Numero del asistente: ', reg_m.nro_asis);
    writeln('Nombre y apellido del asistente : ', reg_m.nombre_apellido);
    writeln('Email del asistente: ', reg_m.email);
    writeln('Telefono del asistente: ', reg_m.telefono);
    writeln('Dni del asistente: ', reg_m.dni);
    writeln('');
end;

procedure imprimir_maestro(var m:maestro);
var
    reg_m: asistentes;
begin
    reset(m);
    while not eof(m) do begin
        read(m, reg_m);
        imprimir_asistente(reg_m);
    end;
    close(m);
end;
procedure imprimir_maestro_eliminados(var m:maestro);
var
    reg_m: asistentes;
begin
    reset(m);
    while not eof(m) do begin
        read(m, reg_m);
        if (pos('####',reg_m.dni) = 0) then
            imprimir_asistente(reg_m);
    end;
    close(m);
end;

var

arch:maestro;

begin
    assign(arch,'maestro');
    //crearArchivo(arch);
    eliminar_asistente(arch);
    writeln('No eliminados');
    imprimir_maestro(arch);
    writeln('Eliminados');
    imprimir_maestro_eliminados(arch);
end.