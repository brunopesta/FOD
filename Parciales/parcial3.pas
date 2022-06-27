{
    4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
    fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
    máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
    archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
    cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
    cod_usuario, fecha, tiempo_sesion. 
    Debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
    tiempo_total_de_sesiones_abiertas.
    Notas:
    - Cada archivo detalle está ordenado por cod_usuario y fecha.
    - Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
    máquinas.
    - El archivo maestro debe crearse en la siguiente ubicación física: /var/log.
}
program parcial3;
const
    cant_detalles = 5;
    valor_alto = 9999;
type

    fechas = record
        day:integer;
        month:integer;
        year:integer;
    end;

    reg_detalle = record
        cod_user:integer;
        fecha: fechas; // La fecha se ingresa como Day/Month//Last 2 numbers of the year.
        tiempo_sesion:double;
    end;

    reg_maestro = record
        cod_user:integer;
        fecha:fechas;
        tiempo_total_de_sesiones_abiertas:double;
    end;

    archivo_detalle = file of reg_detalle; 
    archivo_maestro = file of reg_maestro;

    arreglo_archivo_detalle = array [1..cant_detalles] of archivo_detalle;
    
    arreglo_registro_detalle = array  [1..cant_detalles] of reg_detalle;

    procedure leer(var archivoD: reg_detalle; var reg_d: reg_detalle);
    begin
        if not eof(archivoD) then   
            read(archivoD,reg_d)
        else
            reg_d.cod_user := valor_alto;
    end;


    procedure minimun(var vecD:arreglo_archivo_detalle; var leidos:arreglo_registro_detalle; var min:reg_detalle);
    var
        pos,i:integer;
    begin
        min.cod_user:= valor_alto;
        min.fecha.day:= valor_alto;
        min.fecha,month:= valor_alto;
        min.fecha.year:= valor_alto;
        for i:= 1 to cant_detalles do begin
            if (leidos[i].cod_user < min.cod_user) then begin
                if(leidos[i].fecha.day < min.fecha.day) and (leidos[i].fecha.month < min.fecha.month) and (leidos[i].fecha.year < min.fecha.year) then begin //esto se nd  and  and 
                    min:= leidos[i];
                    pos:= i;
                end;
            end;
        end;
        
        leer(vecD[pos],leidos[pos]);
    end;
    
    procedure CrearMaestro(var archivoM: archivo_maestro; var archivoD: arreglo_archivo_detalle);
    var
        regM:reg_maestro;
        i:integer;
        leidos:arreglo_registro_detalle;
        min:reg_detalle;
    begin
        for i:= 1 to  cant_detalles do begin
            reset(archivoD[i]);
            leer(archivo[i],leidos[i]);
        end;
        rewrite(archivoM);
        minimun(archivoD,leidos,min)
        while (min.cod_user <> valor_alto) do begin 
        
            regM.cod_user := min.cod_user;
            regM.fecha.day := min.fecha.day;
            regM.fecha.month := min.fecha.month;
            regM.fecha.year := min.fecha.year;
            regM.tiempo_total_sesiones_abiertas := 0;
            
            while (reg_M.cod_user = min.cod_user) and (regM.fecha.day = min.fecha.day) and (regM.fecha.month = min.fecha.month) and (regM.fecha.year = min.fecha.year) do begin
                regM.tiempo_total_de_sesiones_abiertas := regM.tiempo_total_de_sesiones_abiertas + min.tiempo_sesion;
                minimun(archivoD,leidos,min);
            end;
            
            write(archivoM,regM);
        end;

        for i:= 1 to cant_detalles do begin
            close(archivoD[i]);
        end;

        close(archivoM)
    end;
var
    i_str: string;
    i:integer;
    archivoM: archivo_maestro;
    archivoD: archivo_detalle;
begin
    Assign(archivoM,'/var/log');
    for i:= 1 to cant_detalles do begin
        Str(i,i_str);
        Assign(archivoD[i],'Detalle: ' + i_str);
    end;
    crear_maestro(archivoM,archivoD);
end.