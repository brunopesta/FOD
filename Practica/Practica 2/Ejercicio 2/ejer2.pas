{2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
.
Actualizar el archivo maestro de la siguiente manera:
i. Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
ii. Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b.
Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.
}
program ejer2;

const
    valoralto=9999;
type

alumno = record
    cod:integer;
    apellido :string;
    nombre :string;
    cursadas:integer;
    final:integer;
    end;

    aprobo = record
        cod:integer;
        cursadas:Boolean;
        final:Boolean;
    end;

    archivo = file of alumno;

    detalle = file of aprobo;

procedure crearArchivoComisiones(var maestro: archivo);
    procedure leerComision(var c: alumno);
    begin
        write('Ingresar codigo del Alumno: ');
        readln(c.cod);
        if(c.cod <> -1)then begin
            write('Ingresar nombre del Alumno: ');
            readln(c.nombre);
            write('Ingresar el Apellido del alumno: ');
            readln(c.apellido);
            WriteLn('Ingrese la cantidad de cursadas que aprobo ');
            ReadLn(c.cursadas);
            WriteLn('Ingrese la cantedidad de materias con Final aprobado');
            ReadLn(c.final);
        end;
    end;
 var
    c: alumno;
begin
    rewrite(maestro);
    leerComision(c);
    while(c.cod <> -1)do begin
        write(maestro, c);
        leerComision(c);
    end;
    close(maestro);
end;

procedure crearDetalle(var de: detalle);
    procedure leerDetalle(var c:aprobo);
    begin
        writeln('INngrees un codigo de alumno distinto a -1');
        readln(c.cod);
        if (c.cod <> -1) then begin
          writeln('Ingrese la cantidad de cursadas que aprobo');
          readln(c.cursadas);
          writeln('Ingrese la cantidad de finales que aprobo');
          readln(c.final);
        end;
    end;
var
    c:aprobo;
begin
    Rewrite(de);
    leerDetalle(c);
    while (c.cod <> -1 ) do begin
        write(de,c);
        leerDetalle(c);
    end;
    close(de);
end;


procedure actualizarMaestro(var ma:archivo; d:detalle);
    procedure leerAlumno(var mae:detalle; var e:aprobo);
    begin
        if(not eof(arch))then
            read(arch, e)
        else
            e.cod := valoralto;
    end;

var
    e:aprobo;
    a:alumno;
begin
    Reset(ma);
    Reset(d);
    leerAlumno(d,e);
    while (a.cod <> valoralto) do begin
        read(m,a);
        while (a.cod = e.cod) do begin
            if(e.cursadas) then
                a.cursadas:= a.cursadas + 1;
            if (e.final ) then 
                a.final:=  a.final + 1;
            leerAlumno(d,e);
        end;
        Seek(ma, FilePos(ma)-1);
        Write(ma,a);
    end;
    close(m);
    close(d);
end;

procedure listar_en_txt(var mae:archivo);
var
    a:alumno;
    t:Text;
begin
    Assign(t,'masDeCuatroSinFinal');
    Rewrite(t);
    reset(mae);
    while (not eof(mae)) do begin
        read(mae,a);
        if (a.cursadas > 4) then 
            writeln(t, a.cod,' ',a.nombre,' ',a.apellido,' ', a.cursadas,' ',a.final);
    end;
    close(t);
    close(mae);
end;


var
mae:archivo;
det:detalle;

begin
    Assign(mae,'maestro_alumnos');
    //crearArchivoComisiones(mae);  //Ya creado
    Assign(det,'detalle_alumnos');
    //crearDetalle(det);

end.