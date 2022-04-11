{8. Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente.
Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la
empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta.
El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras.
}
program ejer8;
const
valor_alto= 9999;

type

fechas = record
    anio:integer;
    mes:String;
    dia:integer;
    end;

cliente  = record
    cod:integer;
    nombreyapellido:String;
    fecha:fechas;
    tot_men:real;
    end;

    maestro = file of cliente;

procedure leerCliente (var c:cliente );
begin
    write('Ingrese el cod del cliente');
    readln(c.cod);
    if (c.cod <> -1) then begin
        writeln('Ingrese total mensual gastado ');
        readln(c.tot_men);
        writeln('Ingrese el nombre y apellido del cliente ');
        readln(c.nombreyapellido);
        writeln('Ingrese a continuacion anio, fecha y dia de su compra');
        readln(c.fecha.anio);             
        readln(c.fecha.mes);
        readln(c.fecha.dia);
    end;
end;

procedure crearMaestro (var a:maestro);
var
    c:cliente;
begin
    rewrite(a);
    leerCliente(c);
    while(c.cod <> -1) do begin
        write(a,c);
        leerCliente(c);
    end;
    close(a);
end;

procedure leer(var arch: maestro; var rM: cliente);
    begin
        if not eof(arch) then
            read(arch,rM)
        else
            rM.cod := valor_alto;
end;

procedure listar(var a:maestro);
var
    c:cliente;
    monto_total_anio,total_gen,mensual:real;
    anio_aux,cod_aux:integer;
    mes:String;
begin
    reset(a);
    leer(a,c);
    total_gen:=0;
    while (c.cod <> valor_alto) do begin 
        writeln('codigo de cliente: ', c.cod);
        writeln('Nombre y apellido: ', c.nombreyapellido);
        cod_aux:= c.cod;
        while (c.cod = cod_aux) do begin
            writeln('anio ', c.fecha.anio);
            anio_aux:= c.fecha.anio;
            monto_total_anio:=0;
            while (c.cod = cod_aux) and (c.fecha.anio = anio_aux) do begin
                writeln('Mes: ',c.fecha.mes);
                mensual:=0;
                mes:= c.fecha.mes;
                while(c.cod = cod_aux) and (c.fecha.anio = anio_aux) and (c.fecha.mes = mes) do begin
                    mensual:= mensual + c.tot_men;
                    leer(a,c);
                end;
                writeln('Monto mensual: ', mensual:2:2);
                monto_total_anio:= monto_total_anio + mensual;
            end;
            writeln('Gastado por ano del cliente: ',monto_total_anio:2:2);          
        end;
        total_gen:= total_gen + monto_total_anio;
    end;
    writeln('Ganancia de la empresa: ',total_gen:2:2);
    close(a);
end;

var

a:maestro;
begin
    assign(a,'maestro');
    //crearMaestro(a);
    listar(a);

end.
