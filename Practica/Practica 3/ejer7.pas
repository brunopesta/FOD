{
    Se cuenta con un archivo que almacena información sobre especies de aves en
    vía de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
    descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
    un programa que elimine especies de aves, para ello se recibe por teclado las especies a
    eliminar. 
    Deberá realizar todas las declaraciones necesarias, implementar todos los
    procedimientos que requiera y una alternativa para borrar los registros. Para ello deberá
    implementar dos procedimientos, uno que marque los registros a borrar y posteriormente
    otro procedimiento que compacte el archivo, quitando los registros marcados. Para
    quitar los registros se deberá copiar el último registro del archivo en la posición del registro
    a borrar y luego eliminar del archivo el último registro de forma tal de evitar registros
    duplicados.
    Nota: Las bajas deben finalizar al recibir el código 500000
}

program parcial;
const
    valor_alto = 9999;
type
    ave = record
        codigo: integer;
        nombre: string[25];
        familia: string[25];
        descripcion: string[25];
        zona: string[25];
    end;

    procedure leerMaestro(var m:maestro; a:ave);
    begin
        if (not eof(m)) then 
            read(m,a)
        else    
            a.cod:= valor_alto;
    end;

    procedure crear

    procedure bajaLogica(m:maestro);
    var
        a:ave;
        regM:ave;
    begin
        reset(m);
        leerAve(a);
        while(a.codigo <> 500000) do begin
            leerMaestro(m,regM);
            while(regM.codigo <> a.codigo) do
                leerMaestro(m,regM);
            if(regM.codigo = a.codigo) then
                regM.nombre:= '#'; 
            else
                writeln('El ave con codigo: ', a.codigo, ' no se encuentra en el archivo.');
            leerAve(a);
        end;
        
        close(m);
    end;

    procedure compactar(var m:maestro; var a:maestro);
    var
        pos:integer;
        regM,aux:ave;
    begin
        reset(m);
        rewrite(a);
        leerMaestro(m,regM);
        while not eof(m) do begin
            if(regM.nombre = '#') then begin
                pos:=(filepos(m)-1);
                seek(m,filesize(m)-1);
                read(m,aux);
                seek(m,filepos(m) - 1);
                truncate(m);
                seek(m,pos);
                write(m,aux);
            end;
            leerMaestro(m,regM);
        end;
        close(m);
    end;

var

begin

end.