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
casos activos (las localidades pueden o no haber sido actualizadas).}

program parcial1;

const
    valor_alto = 9999;

    cant_detalles= 10;

type

    ministerio = record
        cod_loc:integer;
        cod_cepa:integer;
        activos:integer;
        nuevos:integer;
        recuperados:integer;
        fallecidos:integer;
    end;

    regM = record
        cod_loc:integer;
        nombre_loc:string;
        cod_cepa:integer;
        nombre_cepa:string;
        cant_activos:integer;
        cant_nuevos:integer;
        cant_recu:integer;
        cant_fallecidos:integer;
        end;

        maestro = file of regM;

        detalle = file of  ministerio;

        vec_d = array [1..cant_detalles] of detalle;

        vec_r = array [1..cant_detalles] of ministerio;


    procedure leer (var d:detalle; m:ministerio );
        begin
            if (not eof(d)) then
                read(d,m);
            else
                m.cod_loc := valor_alto;
        end;

    procedure minimo(var vecD:vec_d; var leidos:vec_r; var minimo:ministerio);
    var
        pos:integer;
        i:integer;
    begin
        pos:=0;
        minimo.cod_loc:=valor_alto;
        for i:= 1 to cant_detalles do 
            if (leidos[i].cod_loc < minimo.cod_loc) then begin
                minimo := leidos[i];
                pos:= i;
            end;
        leer(vecD[pos],leidos[pos]);
    end;


    procedure ActualizarMaestro(var m:maestro; var vecD:vec_d):
    var
        i,tot_falle,tot_recu,activos,nuevos:integer;
        leidos:vec_r;
        Act,min:ministerio;
        regM:regM;
        cant:integer;
    begin
        Reset(m);
        for i:= 1 to cant_detalles do begin
            Reset(vecD[i]);
            leer(vecD[i], leidos[i]);   
        end;
        cant:=0;
        minimo(vecD, leidos,min);
        
        while (min.cod_loc <> valor_alto)do begin
            Act.cod_loc := min.cod_loc;

            while (Act.cod_loc = min.cod_loc) do begin
                Act.cod_cepa := min.cod_cepa;
                tot_falle:=0;
                tot_recu:=0;
                nuevos:=0;
                activos:=0;
                tot_falle := min.fallecidos;
                tot_recu := min.recuperados;
                activos:= min.activos;
                nuevos:=  min.nuevos;
                minimo(vecD,leidos,min);
            end; 
        if (regM.cant_activos > 50) then
            cant := cant + 1;
        while (Act.cod_loc <> regM.cod_loc) and (Act.cod_cepa <> regM.cod_cepa) do 
            Read(m,regM);
        Seek(filePos(m) - 1);
        regM.tot_falle:= regM.tot_falle + tot_falle;
        regM.tot_recu:= regM.tot_recu + tot_recu;
        regM.cant_activos:= regM.cant_activos +  activos;
        regM.cant_nuevos := regM.cant_nuevos + nuevos;    
        Write(m, regM);
        end;
        close(m);
        writeln('La cantidad de localidades con mas de 50 casos activos es ',cant);
        for i:= 1 to cant_detalles do
            close(vecD[i]);
    end;

var
    m:maestro;
    vecD:vec_d;
begin
    assign(m,'maestro');
    for i:= 1 to cant_detalles do
        assign(vecD[i],'detalle' + i.toStirng): // La funcion toString convierte un numero entero en String.
    ActualizarMaestro(m,vecD);
end.