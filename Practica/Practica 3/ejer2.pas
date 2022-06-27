{

    Definir un programa que genere un archivo con registros de longitud fija conteniendo
    información de asistentes a un congreso a partir de la información obtenida por
    teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
    nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
    archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
    asistente inferior a 1000.
    Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
    String a su elección. Ejemplo: ‘@Saldaño’.
}

program ejer2;

const
    valor_alto = 9999;

type

    regM = record
        nro_asis:integer;
        apellido:string;
        nombre:string;
        email:string;
        telefono:integer;
        dni:string[8];
    end;

    maestro = file of regM;

    procedure leer(var m:maestro; r:regM);
    begin
        if not(eof(m)) then 
            read(m,r);
        else
            r.nro_asis:= valor_alto;
    end;


    procedure bajaLogica(var m:maestro);
    var
        reg:regM;
    begin
        reset(m);
        leer(m,reg);
        while not eof(m) do begin
            if (reg.nro_asis < 1000) then begin
                reg.email:= '@' + reg.email;
                seek(m,filepos(m)-1);
                write(m,reg);
            end;
            leer(m,reg);
        end;
        close(m);
    end;