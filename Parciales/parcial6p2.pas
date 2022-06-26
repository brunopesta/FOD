{
    Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
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
    NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.

}

program parcial;
const
    valor_alto = 9999;
type
    alumno = record
        cod:integer;
        apellido: string[25];
        nombre: string[25];
        cant_sin_final: integer;
        cant_con_final: integer;
    end;

    detalle = record
        cod:integer;
        nota: string[15];
    end;

    archivo_maestro = file of alumno;
    archivo_detalle = file of detalle;

    procedure leerD(var d:archivo_detalle; regd:detalle);
    begin
        if not eof(d) then
            read(d,regd)
        else
            regd.cod := valor_alto;
    end;

    procedure actualizar(var archivoM: archivo_maestro; var archivoD: archivo_detalle; var archivo_texto: Text);
    var 
        regM: alumno;
        regD: detalle;
    begin
        reset(archivoM);
        reset(archivoD);
        leerD(archivoD,regD);
        while(regD.cod <> valor_alto) do begin
            read(archivoM,regM);
            while(regM.cod <>  regD.cod) do begin
                read(archivoM,regM);
            end;

            while(regM.cod = regD.cod) do begin
                if(regD.nota = 'promocion') then
                    regM.cant_con_final := regM.cant_con_final + 1
                else
                    regM.cant_sin_final := regM.cant_sin_final + 1;
            end;
            seek(archivoM,filepos(archivoM) - 1);
            write(archivoM,regM);
        end;
        close(archivoM);
        close(archivoD);
    end;

    procedure crear_txt(var m:maestro; var text:archivo_texto)
    var
        regM: alumno;
    begin
        reset(m);
        rewrite(text);
        while (not eof(m)) do begin
            read(m,regM);
            if(regM.cant_sin_final > 4) then
                writeln(archivo_texto,'Codigo de alumno: ' , regM.cod, #10, 'Nombre: ', regM.nombre, #10,'Apellido: ', regM.apellido, #10,'Cantidad de materias sin final: ', regM.cant_sin_final,#10,'Cantidad de materias con final: ', regM.cant_con_final);
        end;
        close(m);
        close(text);    
    end;
var
    archivoM: archivo_maestro;
    archivoD: archivo_detalle;
    archivoTxt: Text;
begin
    Assign(archivoM,'maestro');
    Assign(archivoD,'detalle');
    Assign(archivoTxt,'alumnos.txt');
    actualizar(archivoM,archivoD,archivoTxt);
    crear_txt(archivoM,archivoTxt);
end.
