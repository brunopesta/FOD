{Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:

a. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez

}

program parcial7;

const
    valor_alto = 9999;
type

    alumno = record
        cod:integer;
        nombre:string;
        apellido:string;
        cant_cursa:integer;
        cant_final:integer;
    end;

    materia = record
        cod:integer;
        estado_materia:boolean;  // TRUE APROBO FINAL, FALSE APROBO CURSADA
    end;

    maestro = file of alumno;

    detalle = file of materia;


    procedure leer( var d:detalle; m:materia);
    begin
        if (not(eof(m))) then 
            read(d,m)
        else
            m.cod:= valor_alto;
    end;

    procedure actualizarMaestro(var m:maestro; var d:detalle);
    var
        regM:alumno;
        regD:materia;
    begin
        reset(m);
        reset(d);
        leer(d,regD);
        read(m,regM);
        while (regD.cod <> valor_alto) do begin
            while(regD.cod <> regM.cod) do
                read(m,regM)
            
            while(regD.cod = regM.cod) do begin
                if (regD.estado_materia) then
                    regM.cant_final:= regM.cant_final + 1;
                else
                    regM.cant_cursa := regM.cant_cursa + 1;
                leer(d,regD);
            end;
            seek(m,filepos(m) - 1);
            write(m,regM);
        end;
        close(d);
        close(m);        
    end;

    procedure crear_txt(var m:maestro; txt:Text);
    var
        regM:alumno
    begin
        Reset(m);
        Rewrite(txt);
        while not(eof(m)) do begin
            read(m,regM);
            writeln(txt,'Codigo de alumno',regM.cod,#10,'Nombre',regM.nombre,#10,'Apellido',regM.apellido,#10,'Cantidad final',regM.cant_final,#10,'cant cursada',regM.cant_cursa);
        end;
        close(m);
        close(txt);
    end;


var
    m:maestro;
    d:detalle;
    txt:Text;
begin
    Assign(d,'detalle');
    Assign(m,'maestro');
    Assign(txt,'Archivo_Txt');
    actualizarMaestro(m,d);
    crear_txt(m,txt);
end.

