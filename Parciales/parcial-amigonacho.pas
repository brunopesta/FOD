{

    Archivos
    RECUERDE QUE DEBE ADJUNTAR UNA FOTO CON SU RESOLUCIÓN DE PUÑO Y LETRA DENTRO DE LOS 75 MINUTOS DE LA TAREA, LUEGO DE CERRADA LA TAREA NO PODRÁ ADJUNTAR SU SOLUCIÓN.


    Una concesionaria de motos de la Ciudad de Chascomús, posee un archivo con información de las motos que posee a la venta. De cada moto se registra: código, nombre, descripción,
    modelo, marca y stock actual. Mensualmente se reciben 10 archivos detalles con información de las ventas de cada uno de los 10 empleados que trabajan. 
    De cada archivo detalle se dispone de la siguiente información: código de moto, precio y fecha de la venta. Se debe realizar un proceso que actualice 
    el stock del archivo maestro desde los archivos detalles. Además se debe informar que moto fue la más vendida.

    NOTA: Todos los archivos están ordenados por código de la  moto y el archivo maestro debe ser recorrido sólo una vez y en forma simultánea con los detalles.
    Árboles
    RECUERDE QUE DEBE ADJUNTAR UNA FOTO CON SU RESOLUCIÓN DE PUÑO Y LETRA DENTRO DE LOS 25 MINUTOS DE LA TAREA, LUEGO DE CERRADA LA TAREA NO PODRÁ ADJUNTAR SU SOLUCIÓN.


} 

program ejer1;

const
    valor_alto = 9999;

    cant_detalles = 10;
type

    maeR = record
        cod:integer;
        nombre:string;
        desc:string;
        modelo:string;
        marca:string;
        stock_Act:integer;
    end;
    
    fechas = record
        dia:1..31;
        mes: 1..12;
        anio: integer;
    end;

    deta = record
        cod:integer;
        precio:real;
        fecha: fechas;
    end;
    
    maestro = file fo maeR;
    
    detalle = file of deta;
    
    array_det = array [1..cant_detalles] of detalle;

    array_reg = array [1..cant_detalles] of deta;
    


    procedure leerD(var d:detalle; regD:deta);
    begin
        if (not eof(d)) then 
            read(d,regD)
        else
            regD.cod:= valor_alto
    end;

    procedure leerM(var m:maestro; regM:maeR);
    begin
        if (not eof(m)) then 
            read(m,regM)
        else
            regM.cod:= valor_alto
    end;

    procedure minimo(var archivoD: array_det;var leidosD:array_reg ; var min: deta)
    var
        pos,i:integer;
    begin
        min.cod:= 9999;
        pos:= 1;
        for i:= 1 to cant_detalles do begin
            if(leidosD[i].cod < min.cod) then begin
                min:= leidos[i];
                pos:= i;
            end;
        end;

        leerD(archivoD[pos],leidos[pos]);
    
    end;

    procedure actualizarMaestro(var m:maestro; var vecD:array_det);
    var
        regM:maestro;
        leidos:array_reg;
        i,min_stock:integer;
        min:deta;
        max:maeR;
    begin
        reset(m);
        for i:= 1 to cant_detalles do begin
            reset(vecD[i]);
            leerD(vecD[i],leidos[i]);
        end;
        leerM(m,regM);
        minimo(vecD,leidos,min);
        min_stock:= 9999;
        while (min.cod <> valor_alto ) do begin
            while (regM.cod <> min.cod)do
                leerM(m,regM)

            while (regM.cod = min.cod) do begin
                regM.stock_Act := min.stock_Act;
                minimo(vecD,leidos,min);
            end;
            seek(m,filepos(m)-1);
            write(m,regM);

            if(regM.stock_Act < min_stock) then begin
                max:= regM;
                min_stock:= regM.stock_Act
            end;
        end;

        write('La moto mas vendida fue: ', max.nombre);

        for i:= 1 to cant_detalles do begin
            close(vecD[i]);
        end;
        close(m);
    end;
var
    archivo: maestro;
    arhcivoD: array_det;
    i:integer;
    i_str:string[25];
begin
    Assign(archivo,'maestro');
    for i:= 1 to cant_detalles do begin
        Str(i,i_str);
        Assign(archivoD[i],'Detalle: ' + i_str);
    end;
    actualizarMaestro(archivo,archivoD);
end.