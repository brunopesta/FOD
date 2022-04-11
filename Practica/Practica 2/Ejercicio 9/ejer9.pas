{9. Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información se encuentra ordenada por código de provincia y código de
localidad.}

program ejer9;

const
valor_alto=9999;

type

mesas = record
    cod_loc:integer;
    cod_prov:integer;
    num_mesa:integer;
    cant_votos:integer;
    end;

    maestro = file of mesas;


procedure crearVotante(var m:mesas);
begin
    writeln('Ingrese el codigo de provincia');
    readln(m.cod_prov);
    if (m.cod_prov <> -1) then begin
        writeln('Ingrese el codigo de localidad');
        readln(m.cod_loc);
        writeln('Ingrese el numero de mesa');
        readln(m.num_mesa);
        writeln('Ingrese la cantidad de votos');
        readln(m.cant_votos);
    end;
end;

procedure crearMaestro(var arc:maestro);
var
    m:mesas;
begin
    rewrite(arc);
    crearVotante(m);
    while (m.cod_prov <> -1) do begin
        write(arc,m);
        crearVotante(m);
    end;
    close(arc);
end;

procedure leer(var arch: maestro; var rM: mesas);
    begin
        if not eof(arch) then
            read(arch,rM)
        else
            rM.cod_prov := valor_alto;
    end;

procedure listadoVotantes(var a:maestro);
var
    m:mesas;
    cod_loc_aux,cod_prov_aux,cant_votos_aux,tot_votos_prov,tot_votos_gen:integer;
begin
    reset(a);
    leer(a,m);
    tot_votos_gen:=0;
    while (m.cod_prov <> valor_alto) do begin
        writeln('Codigo de Provincia: ', m.cod_prov);
        cod_prov_aux := m.cod_prov;
        tot_votos_prov:=0;
        while (m.cod_prov = cod_prov_aux) do begin
            write('Codigo de localidad    ','       Total de votos',#10,'        ',m.cod_loc);
            //write(' --------------------------');
            cod_loc_aux:= m.cod_loc;
            cant_votos_aux:=0;
            while (m.cod_prov = cod_prov_aux) and (m.cod_loc = cod_loc_aux)do begin
                cant_votos_aux := cant_votos_aux + m.cant_votos;
                write('                          ',cant_votos_aux,#10);
                leer(a,m);
            end;
            tot_votos_prov:= tot_votos_prov + cant_votos_aux;
        end;
        writeln('Total de votos Provincia ',tot_votos_prov);
        writeln('---------------------------------------------------');
        tot_votos_gen:= tot_votos_gen + tot_votos_prov;
    end;
    write('Total general de votos:', tot_votos_gen);

    close(a);
end;



var
    a:maestro;
begin
    assign(a,'maestro');
    //crearMaestro(a);
    listadoVotantes(a);
end.