{Una federacion de competidores de running organiza distintas carreras al mes. Cada carrera cuenta con DNI de corredor, apellido, nombre kms q corrio y si gano o no la carrera (valor 1
si gano y valor 0 si no gano la carrera

Puede haber distintas cantidades de carreras en el mes. Para el mes de abril se organizaron  5 carreras

Escriba el programa principal con la declaracion de tipos necesaria y realice un proceso que reciba los 5 archivos y genere el archivo maestro con la siguiente informacion
 DNI, Apellido, nombre kms totales y carreras ganadas

 Todos los archivos estan ordenados por DNI del corredor. Cada persona puede haber corrido una o mas carreras.
}

program parcial4;

const
    valor_alto = 9999;
    cant_detalles = 5;
type

    regD = record
        dni:string[8];
        apellidp:string;
        nombre:string;
        kms_reco:double;
        gano:boolean;
    end;

    regM = record
        dni:string[8];
        apellido:string;
        nombre:string;
        kms_tot:real;
        tot_ganadas:integer;
    end;

    maestro = file of regM;

    detalle = file of regD;

    vecD = array [1..cant_detalles] of detalle;

    vecR = array [1..cant_detalles] of regD;
{
    procedure leer(var d:detalle; regD:regD);
    begin
        if not (eof(d)) then
            read(d,regD)
        else
            regD.dni:= valor_alto;
    end;

    procedure minimo(var vec_d:vecD; var leidos:vecR; var min:regD);
    var
        i,pos:integer;
    begin
        min.dni:- valor_alto;
        for i:= 1 to cant_detalles do
            if (leidos[i].dni < min.dni) then begin
                min:= leidos[i];
                pos:= i;
            end;
        leer(vec_d[pos],leidos[pos]);
    end;

procedure crearMaestro(var m:maestro; var vec:vecD);
var
    leidos:vecR;
    min:regD;
    regm:regM;
    i:integer;
begin
    rewrite(m);
    for i:= 1 to cant_detalles do begin
        Reset(vec[i]);
        leer(vec[i],leidos[i]);
    end;
    minimo(vec,leidos,min);

    while (min.dni <> valor alto) do begin
        regm.dni:=  min.dni;
        regm.apellido:= min.apellido;
        regm.nombre:= min.nombre;

        while (regm.dni = min.dni) do begin
            regm.kms_tot:= regm.kms_tot + min.kms_reco;
            if (min.gano) then 
                regm.tot_ganadas:= regm.tot_ganadas + 1;
            minimo(vec,leidos,min);
        end;

        write(m,regm);
    end;
    for i := 1 to cant_detalles do
        close(vec[i]);
    close(m);
end;
}
var
    m:maestro;
    vec:vecD;
    i:integer;
begin
    assign(m,'maestro');
    for i := 1 to 5 do 
        assign(vecD[i], 'detalle' + i.toString); // convierte la i en un string para asi poder usarlo en el assign
    crearMaestro(m,vecD);
end.

