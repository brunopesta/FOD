{

11. A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
    archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
    alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
    agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
    localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
    necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
    NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
    pueden venir 0, 1 ó más registros por cada provincia


}
program parcial11;

const
    valor_alto := 'ZZZ';
    cant_detalle =2;

type

    reg_master = record
        nom_prov:string;
        cant_alfa:integer;
        tot_encu:integer;
    end;

    detail = record
        nom_prov:string;
        cod:integer;
        cant_alfa:integer;
        cant_encu:integer;
    end;

    maestro = file of reg_master;
    detalle = file of detail;

    array_detalle = array [1..cant_detalle] of detalle;

    array_reg = array [1..cant_detalle] of detail;


    procedure leerD(var d:detalle; regD:detail);
    begin
        if not(eof(d)) then 
            read(d,regD)
        else
            regD.nom_prov:= valor_alto;
    end;

    procedure minimo(var vecD:array_detalle; var leidos:array_reg; var  min:detail);
    var
        pos,i:integer;
    begin
        min.nom_prov:= valor_alto;
        for i:= 1 to cant_detalle do
            if(leidos[i].nom_prov < min.nom_prov) then begin
                min:= leidos[i];
                pos:=i;
            end;
        leer(vecD[pos],leidos[pos]);
    end;

    // OTRO TIPO DE MINIMO

    procedure minimo2( var r1,r2:detail; d1,d2:detalle; var min:detail);
    begin
        if(r1.nom_prov <= r2.nom_prov) then begin
            min:=r1;
            leer(d1,r1);
        end
        else
        begin
            min:= r2;
            leer(d2,r2);
        end

    procedure actualizarMaestro2(var m:maestro; d1,d2:detalle);
    var
        regM:reg_master;
        min,r1,r2:detail;
    begin
        reset(m);
        reset(d1);
        reset(d2);
        leer(d1,r1);
        leer(d2,r2);
        read(m,regM);
        minimo2(r1,r2,d1,d2,min);
        while (min.nom_prov <> valor_alto) then 
            while (min.nom_prov <> regM.nom_prov) do
                read(m,regM)
            
            while(min.nom_prov = regM.nom_prov) do begin
                regM.tot_encu:= regM.tot_encu + min.cant_encu;
                regM.cant_alfa:= regM.cant_alfa + min.cant_alfa;
                minimo(r1,r2,d1,d2,min);
            end;
            seek(m,filepos(m) - 1);
            write(m,regM);
        end;
        close(d1);
        close(d2);
        close(m);
    end;

    procedure actualizarMaestro (var m:maestro; var vecD:array_detalle);
    var
        i:integer;
        leidos:array_reg;
        regM:reg_master;
        min:detail;
    begin
        reset(m);
        for i:= 1 to cant_detalle do begin
            reset(vecD[i]);
            leer(vecD[i],leidos[i]);
        end;
        read(m,regM);
        minimo(vecD,leidos,min);
        while (min.nom_prov <> valor_alto) do begin
            while(min.nom_prov <> regM.nom_prov) do
                read(m,regM)

            while(min.nom_prov = regM.nom_prov) do begin
                regM.tot_encu:= regM.tot_encu + min.cant_encu;
                regM.cant_alfa:= regM.cant_alfa + min.cant_alfa;
                minimo(vecD,leidos,min);
            end;
            seek(m,filepos(m) - 1);
            write(m,regM);
        end;
        close(m);
        for i:= 1 to cant_detalle do 
            close(vecD[i])
    end;  