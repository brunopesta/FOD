{ 4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
    fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
    máquinas se conectan con un servidor central. 
    Semanalmente cada máquina genera un
    archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
    cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
    cod_usuario, fecha, tiempo_sesion. 
    Debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
    tiempo_total_de_sesiones_abiertas.
    Notas:
    - Cada archivo detalle está ordenado por cod_usuario y fecha.
    - Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
    máquinas.
    - El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}

program parcial3;

const
    valor_alto = 9999;
    cant_detalles = 5;
type
    fechas = record
        year:integer;
        mes:integer;
        day:integer;
    logs = record
        cod_usuario:integer;
        fecha:fechas;
        tiempo_sesion=real;
    end;

    rmaestro = record
        cod_usuario: integer;
        fecha:fechas;
        tiempo_total_de_sesiones_abiertas:real;
    end;

    maestro = file of rmaestro;
    detalle = file of logs;

    array_detalle = array [1..cant_detalles] of detalle;

    array_reg = array [1..cant_detalles] of logs;

    procedure leerD(var d:detalle; rD:logs);
    begin
        if (not eof(d)) then 
            read(d,rD)
        else
            rD.cod_usuario:= valor_alto
    end;


    procedure minimo(var vecD:array_detalle; var leidos:array_reg; min:logs);
    var
        pos,i:integer;
    begin
        min.cod_usuario:= valor_alto;
        for i:= 1 to cant_detalles do 
            if (min.cod_usuario <= leidos[i].cod_usuario)then 
                if (min.fecha.day < leidos[i.fecha.day]) and (min.fecha.mes < leidos[i].fecha.mes) and ( min.fecha.year < leidos[i].fecha.year)then begin
                    min:= leidos[i];
                    pos:=i;
                end;
        if (min.cod <> valor_alto) then 
            leer(vecD[pos],leidos[pos])
    end;

    procedure crear_maestro(var m:maestro; var vecD:array_detalle);
    var
        regM:rmaestro;
        leidos:array_reg;
        i:integer;
        min:logs;
    begin
        rewrite(m);
        for i:= 1 to cant_detalles do begin
            reset(vecD[i]);
            leerD(vecD[i],leidos[i]);
        end;
        minimo(vecD,leidos,min);
        while (min.cod <> valor_alto) do begin
            regM.cod_usuario:= min.cod_usuario;
            regM.fecha:= min.fecha;
            regM.tiempo_total_de_sesiones_abiertas:=0;
            while (min.cod_usuario = regM.cod_usuario)and (regM.fecha.day = min.fecha.day) and (regM.fecha.month = min.fecha.month) and (regM.fecha.year = min.fecha.year) do begin
                regM.tiempo_total_de_sesiones_abiertas:= tiempo_total_de_sesiones_abiertas + min.tiempo_sesion;
                minimo(vecD,leidos,min);
            end;
            write(m,regM);
        end;
        close(m);
        for i:= 1 to cant_detalles do 
            close(vecD[i])
    end;



begin  

end.