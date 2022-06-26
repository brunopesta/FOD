{
    Una empresa posee un archivo con información de los ingresos percibidos por diferentes
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
program parcial2;

const
    valor_alto = 9999;
type

    empleado = record
        cod:integer;
        nombre: string[25];
        monto: real;
    end;

    detalle = file of empleado;

    maestro = file of empleado;

    procedure leer(var d:detalle; e:empleado);
    begin
        if not (eof(d)) then 
            read(d,e);
        else
            e.cod:= valor_alto;
    end;

    procedure crear_maestro(var archivoM: maestro; var archivoD: detalle);
    var
        regD,regM:empleado;
    begin
        reset(archivoD);
        rewrite(archivoM);
        leer(archivoD,regD);
        while(regD.cod <> valor_alto) do begin
            regM := regD;
            regM.monto := 0;
            while(regM.cod = regD.cod) do begin
                regM.monto:= regM.monto + regD.monto;
                leer(archivoD,regD);
            end;
            write(archivoM,regM);
        end;
        close(archivoD);
        close(archivoM);
    end;

var
    archivoM: maestro;
    archivoD: detalle;
begin
    Assign(archivoM,'maestro');
    Assign(archivoD,'detalle');
    crear_maestro(archivoM,archivoD);
end;