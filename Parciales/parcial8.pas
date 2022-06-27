{6- Se desea modelar la información necesaria para un sistema de recuentos de casos de
covid para el ministerio de salud de la provincia de buenos aires.

Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad casos
activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.

El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos
nuevos, cantidad recuperados y cantidad de fallecidos.

Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.

Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.


2. Idem anterior para los recuperados.

3. Los casos activos se actualizan con el valor recibido en el detalle.

4. Idem anterior para los casos nuevos hallados.

Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas)}

program parcial8;

const
    valor_alto = 9999;
    cant_detalle = 10;
type

    reg_det= record
        cod_loc:integer;
        cod_cepa:integer;
        cant_act:integer;
        cant_nuevos:integer;
        cant_recu:integer;
        cant_fallecidos:integer;
    end;


    reg_ma = record
        cod_loc:integer;
        nom_loc: string[25];
        cod_cepa:integer;
        nom_cepa: string[25];
        casos_act:integer;
        casos_nuev:integer;
        cant_recu:integer;
        cant_fallecidos:integer;
    end;

    maestro = file of reg_ma;

    detalle = file of reg_det;

    array_detalle = array [1..cant_detalle] of detalle;
    
    array_reg = array [1..cant_detalle] of reg_det;

    procedure leer(var d:detalle; regD:reg_det);
    begin
        if not(eof(d)) then
            read(d,regD)
        else
            regD.cod_loc:= valor_alto;
    end;

    procedure minimo(var vecD: array_detalle; var vecR: array_reg; var min: reg_det);
    var
        pos,i:integer;
    begin
        pos:= 1;
        min.cod_loc := valor_alto;
        min.cod_cepa := valor_alto;
        for i:= 1 to cant_detalles do begin
            if(vecR[i].cod_loc <= min.cod_loc) then 
                if(vecR[i].cod_cepa < min.cod_cepa) then begin 
                    min:= vecR[i];
                    pos:= 1;
                end;
        end;
        leer(vecD[pos],vecR[pos]);
    end;

    procedure actualizarMaestro(var m:maestro; vec:array_detalle);
    var
        regM: reg_ma;
        min: reg_det;
        leidos: array_reg;
        cant_localidades,i: integer;
    begin
        reset(m);
        for i:= 1 to cant_detalle do begin
            reset(vec[i]);
            leer(vec[i],leidos[i]);
        end;
        minimo(vecD,leidos,min);
        read(m,regM);
        while (min.cod_loc <> valor_alto) do begin


            while(regM.cod_loc <> min.cod_loc) and (regM.cod_cepa <> min.cod_cepa) do
                read(m,regM)
            

            while(regM.cod_loc = min.cod_loc) and (regM.cod_cepa = min.cod_cepa) do begin
                regM.casos_act := min.casos_act;
                regM.casos_nuev := min.cant_nuevos;
                regM.cant_fallecidos :=  regM.cant_fallecidos + min.cant_fallecidos;
                regM.cant_recuperados := regM.cant_recuperados + min.cant_recuperados;
                minimo(vecD,leidos,min);
            end;

            seek(m,filepos(m) - 1);
            write(m,regM);
        end;
        for i:= 1 to cant_detalle do begin
            close(vec[i]);
        end;
        close(m);
    end;



var
    m:maestro;
    vecD:array_detalle;
    i:integer;
    iStr:string;
begin
    assign(m,'maestro');
    for i:= 1 to cant_detalle do begin
        Str(i,iStr);
        assign(vecD[i],'detalle' + iStr);
    end;
    actualizarMaestro(m,vecD);
end.