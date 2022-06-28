{  Una empresa posee un archivo con información de los ingresos percibidos por diferentes
    empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
    nombre y monto de la comisión. La información del archivo se encuentra ordenada por
    código de empleado y cada empleado puede aparecer más de una vez en el archivo de
    comisiones.
    Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
    consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
    única vez con el valor total de sus comisiones.

    NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
    recorrido una única vez..
}
program ejer1;

const
    valor_alto = 9999;
type
    empresa = record
        cod_e:integer;
        nombre:string;
        monto:real;
    end;

    maestro = file of empresa;


    procedure leerM(var m:maestroDu; e:empresa);
    begin
        if (not eof(m)) then 
            read(m,e)
        else
            e.cod_e:= valor_alto;
    end;

    procedure compactarMaster(var viejoM:maestro; var nuevoM:maestro);
    var
        regM,regMaux:e;
        cont:integer;
        montoaux: real;
    begin
        reset(viejoM);
        rewrite(nuevoM);
        while not (eof(viejoM)) do begin
            leer(viejoM,regM);
            montoaux:=0;
            if (regM.cod_e = regMaux.cod_e) then 
                montoaux := montoaux + regM.monto;
                leerM(viejoM,regM);
            end;
            regM.monto:= montoaux
            write(nuevoM,regM);
        end;
        close(viejoM);
        close(nuevoM);
    end;

var
    viejoM,nuevoM:maestro;
begin
    assign(viejoM,'Viejo Maestro');
    assign(nuevoM,'Maestro compactado');
    compactarMaster(viejoM,nuevoM);
end.