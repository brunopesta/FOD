{9. Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
  

  Código de Provincia
Código de Localidad                 Total de Votos
................................ ......................
Total de Votos Provincia: ___
....................................................................
Total General de Votos: __

    NOTA: La información se encuentra ordenada por código de provincia y código de localidad
}

program parcial11;
const
    valor_alto= 9999;

type

    reg = record
        cod_prov:integer;
        cod_loc:integer;
        num_mesa:integer;
        cant_vot:integer;
    end;

    maestro = file of reg;

    procedure leer(var m:maestro; regM:reg);
    begin
        if not(eof(m)) then 
            read(m,regM)
        else
            regM.cod_prov:= valor_alto;
    end;

    procedure informar(m:maestro);
    var
        regM:reg;
        cod_provaux,cod_locaux:integer;
        cant_votos,tot_gen,tot_votos_prov:integer;

    begin
        reset(m);
        leer(m,regM);
        tot_gen:=0;

        while (regM.cod_prov <> valor_alto) do begin
            cod_provaux:= regM.cod_prov;
            tot_votos_prov:= 0;
            writeln('Codigo de Provincia: ', cod_provaux);
            
            while (regM.cod_prov = cod_provaux)do begin
                cod_locaux:= regM.cod_loc;
                cant_votos:=0;
                writeln('Codigo de localidad', cod_locaux, ' Total de votos',);
                
                while (regM.cod_prov = cod_provaux) and (regM.cod_loc = cod_locaux) do begin
                    writeln('                             ',regM.cant_vot);
                    cant_votos:= cant_votos + regM.cant_vot;
                    leer(m,regM);
                end;

                tot_votos_prov:= tot_votos_prov + cant_votos;
            end;
            
            writeln('Total de votos Provincia', tot_votos_prov);
            tot_votos_gen:= tot_votos_gen + tot_votos_prov;
        end;
        write('Total general de votos: ',tot_votos_gen);
        close(m);
    end;


var

    m:maestro;
begin
    assign(m,'maestro');
    informar(m);
end;

