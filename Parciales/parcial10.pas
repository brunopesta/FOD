{
    8. Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
    los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
    cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, 
    el total mensual (mes por mes cuánto compró)
     y finalmente el monto total comprado en el año por el
    cliente.

    Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la
    empresa.

    El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
    mes, día y monto de la venta.

    El orden del archivo está dado por: cod cliente, año y mes.
    Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
    compras
}

program parcial10;

const
    valor_alto = 9999;

type

    fechas = record
        year:integer;
        mes:integer;
        day:integer;
    end;

    regM = record
        cod:integer;
        nombe:String;
        apellido:string;
        fecha:fechas;
        monto:real:
    end;

    maestro = file of regM;


    procedure leer(var m:maestro; r:regM);
    begin
        if not(eof(m)) then 
            read(m,r)
        else
            r.cod:= valor_alto
    end;

    procedure informar(var m:maestro);
    var
       aux,reg:regM;
       monto_tot_year,tot_men,monto_tot:real;
       


    begin
        reset(m);
        leer(m,reg);
        monto_tot:= 0;
        while (regM.cod <> valor_alto) do begin
            aux.cod:= regM.cod;
            writeln('Datos Personales del cliente: ','Cod:',aux.cod, #10, ' Nombre y apellido: ',aux.nombre,' ', aux.apellido, #10);
            while (aux.cod = regM.cod) do begin
                aux.year:= regM.year;
                writeln('year',aux.year);
                monto_tot_year:=0;

                while (aux.cod = regM.cod) and (aux.year = regM.year) do begin
                    writeln('mes',aux.mes);
                    aux.mes:= regM.mes;
                    tot_men:= 0;

                    while (aux.cod = regM.cod) and (aux.year = regM.year) and ( aux.mes = regM.mes) do begin
                        tot_men:= tot_men + r.monto;
                        leer(m,r);
                    end;

                    writeln('Monto mensual: ', tot_men:2:2);
                    monto_tot_year:= monto_tot_year + tot_men;
                end;

                writeln('Gastado year x cliente : ',monto_tot_year:2:2);
            end;

            total_gen:= total_gen + monto_tot_year;
        end;
        
        writeln('Ganancia de la empresa',total_gen);
        close(m);
    end;

var
    m:maestro;

begin
    assign(m,'maestro');
    informar(m);
end.