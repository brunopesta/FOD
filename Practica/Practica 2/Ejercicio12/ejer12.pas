{12. La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio de
la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se
realizan al sitio.
La información que se almacena en el archivo es la siguiente: año, mes, dia, idUsuario y
tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado por los
siguientes criterios: año, mes, dia e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará
el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato
mostrado a continuación:

Año : ---
Mes:-- 1
día:-- 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
--------
idusuario N Tiempo total de acceso en el dia 1 mes 1
Tiempo total acceso dia 1 mes 1
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 1
--------
idusuario N Tiempo total de acceso en el dia N mes 1
Tiempo total acceso dia N mes 1
Total tiempo de acceso mes 1
------
Mes 12
día 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
--------
idusuario N Tiempo total de acceso en el dia 1 mes 12
Tiempo total acceso dia 1 mes 12
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 12
--------
idusuario N Tiempo total de acceso en el dia N mes 12
Tiempo total acceso dia N mes 12
Total tiempo de acceso mes 12
Total tiempo de acceso año

Se deberá tener en cuenta las siguientes aclaraciones:
- El año sobre el cual realizará el informe de accesos debe leerse desde teclado.
- El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año
no encontrado”.
- Debe definir las estructuras de datos necesarias.
- El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.}

program ejer12;

const
    valor_alto = 9999;
type

    dias = 1..31;
    meses = 1..12;
    aM = record
        dia:dias;
        mes:meses;
        anio:integer;
        id:string;
        cant_tiempo:integer;
    end;

    maestro = file of aM;

procedure cargarMaestro (var m:aM);
begin
    writeln('Ingrese el anio');
    readln(m.anio);
    if (m.anio <> valor_alto) then begin
        writeln('Ingrese el mes');
        readln(m.mes);
        writeln('Ingrese el dia');
        readln(m.dia);
        writeln('Ingrese el id del usuario');
        readln(m.id);
        writeln('Ingrese la cantidad de tiempo conectado del usuario');
        readln(m.cant_tiempo);
    end;
end;

procedure crearMaestro(var a:maestro);
var
    rM:aM;
begin
    rewrite(a);
    cargarMaestro(rM);
    while (rM.anio <> valor_alto) do begin
        write(a,rM);
        cargarMaestro(rM);
    end;
    close(a);
end;

procedure leer(var arch: maestro; var rM: aM);
begin
    if not eof(arch) then
        read(arch,rM)
    else
        rM.anio := valor_alto;
end;

function  esta  (anio:integer; var a:maestro):boolean;
var
    regM:aM;
    ok:boolean;
begin
    reset(a);
    while not eof (a) do begin
        read(a,regM);
        if (regM.anio = anio) then  
            ok:= true
        else
            ok:= false;
    end;
    esta:= ok;
end;


procedure listar(var a:maestro; anio:integer);
var
    regM:aM;
    dia_aux,mes_aux:integer;
    id_aux:string;
    tot_acceso_dia,tot_anio,tot_mes:integer;
begin
    reset(a);
    leer(a,regM);
    while (regM.anio <> valor_alto) do begin
        while (regM.anio <> anio) do begin
            leer(a,regM);
        end;
        write('Anio', regM.anio);
        tot_anio:=0;
        while ( anio = regM.anio) do begin
            writeln('mes :',regM.mes);
            mes_aux:= regM.mes;
            tot_mes:=0;
            while (anio = regM.anio) and (mes_aux = regM.mes) do begin
                writeln('Dia :',regM.dia);
                dia_aux:= regM.dia;
                tot_acceso_dia:=0;
                while (anio = regM.anio) and (mes_aux = regM.mes) and (dia_aux = regM.dia) do begin
                    id_aux:= regM.id;
                    write('Id de usuario ',regM.id);
                    while (anio = regM.anio) and (mes_aux = regM.mes) and (dia_aux = regM.dia) and (id_aux = regM.id) do begin
                        tot_acceso_dia:= tot_acceso_dia + regM.cant_tiempo;
                        write('Tiempo total de acceso en el dia:',dia_aux,' mes:',mes_aux);
                        writeln(regM.cant_tiempo);
                        leer(a,regM);
                    end;
                end;
            tot_mes:= tot_mes + tot_acceso_dia;
            writeln('Total de acceso al mes',mes_aux);
            writeln(tot_mes);
            end;
        tot_anio:= tot_anio  + tot_mes;
        end;
    writeln('Total tiempo de acceso al anio');
    writeln(tot_anio);
    end;           
end;

var

    a:maestro;
    anio:integer;
begin
    assign(a,'maestro');
    //crearMaestro(a);
    writeln('Ingrese un anio para buscar');
    readln(anio);
    if (esta(anio,a)) then
        listar(a,anio)
    else
        writeln('El anio',anio,'ingresado no se encuentra');
end.