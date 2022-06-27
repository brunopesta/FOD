{
    5. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
    toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
    información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
    en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
    reuniendo dicha información.

    Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
    nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
    del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
    padre.

    En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
    apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
    lugar.

    Realizar un programa que cree el archivo maestro a partir de toda la información de los
    archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
    apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
    apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
    además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar.
    Se deberá, además, listar en un archivo de texto la información recolectada de cada persona.
    
    Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
    Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
    además puede no haber fallecido.
}
program parcial1;

const
    valor_alto = 9999;
    cant_detalle = 50;
type

    fechas = record
        hour:double;
        day:integer;
        mes:integer;
        year:integer;
    end;

    direcciones = record
        calle:string;
        nro:integer;
        piso:integer;
        depto:integer;
        ciudad:string;
    end;
    
    r_nacimientos= record
        nro_partida_nacimiento:integer;
        nombre:String;
        apellido:string;
        direccion:direcciones;
        matricula_medico:integer;
        nomyapeMadre:string;
        dni_madre:string[8];
        nomyapePadre:string;
        dni_padre:string[8];
    end;
        
    r_fallecimientos= record    
        nro_partida_nacimiento:integer;
        dni:string[8];
        nombre:String;
        apellido:string;
        matricula_medico:integer;
        fecha:fechas;
    end;

    regM = record
        nro_partida_nacimiento:integer;
        nombre:String;
        apellido:string;
        direccion:direcciones;
        matricula_medico:integer;
        nomyapeMadre:string;
        dni_madre:string[8];
        nomyapePadre:string;
        dni_padre:string[8];
        fallecio:boolean;
        matricula_medico_firma:integer;
        fecha:fechas;
        lugar:string;
    end;

    archivo_detalle_fallecidos = file of r_fallecimientos;
    archivo_detalle_nacidos = file of r_nacimientos;
    archivo_maestro = file of regM;

    arreglo_archivo_detalle_fallecidos = array[1..cant_detalle] of archivo_detalle_fallecidos;
    arreglo_archivo_detalle_nacimientos = array [1..cant_detalle] of archivo_detalle_nacidos;

    arreglo_registro_detalle_fallecidos = array[1..cant_detalle] of r_fallecimientos;
    arreglo_registro_detalle_nacimientos = array[1..cant_detalle] of r_nacimientos;

    procedure leerNacimiento(var archivo_detalle_nacidos; regN:r_nacimientos);
    begin
        if not(eof(archivo_detalle_nacidos)) then
            read(archivo_detalle_fallecidos,regN)
        else
            regN.nro_partida_nacimiento:= valor_alto;
    end;

    procedure leerFallecmiento(var archivoF: arreglo_archivo_detalle_fallecidos; var reg_f:arreglo_registro_detalle_fallecidos);
    begin
        if not eof(archivoF) then
            read(archivoF,reg_f)
        else
            reg_f.nro_partida_nacimiento:= valor_alto;
    end;
    
    procedure minimo_fall (var vecD:arreglo_archivo_detalle_fallecidos; var leidos:arreglo_registro_detalle_fallecidos; min:r_fallecimientos);
    var
        pos,i:integer;
    begin
        min.nro_partida_nacimiento:= valor_alto;
        for i:= 1 to cant_detalle do
            if(min.nro_partida_nacimiento > leidos[i].nro_partida_nacimiento) then begin
                min:= leidos[i];
                pos:= i;
            end;
        leer(vecD[pos],leidos[pos]);
    end;

    procedure minimo_nac(var vecF: arreglo_archivo_detalle_nacimientos; var vecRegF: arreglo_registro_detalle_nacimientos; var  min: r_nacimientos);
    var
        pos,i:integer;
    begin
        pos:= 1;
        for i:= 1 to cant_detalle do begin
            if( vecRegF[i].nro_partida_nacimiento = min.nro_partida_nacimiento) then begin
                pos:= i;
                min:= vecRegF[i];
            end;
        end;
        leerNacimientos(vecF[pos],vecRegF[pos]);
    end;


    procedure CrearMaestro(var archivoM: archivo_maestro; var archivoN:arreglo_archivo_detalle_nacimientos; var archivoF: arreglo_archivo_detalle_fallecidos);
    var
        min_n: r_nacimientos;
        min_f: r_fallecimientos;
        leidosF: arreglo_registro_detalle_fallecidos;
        leidosN: arreglo_registro_detalle_nacimientos;
        i:integer;
        reg_m:regM;
    begin
        rewrite(archivoM);
        for i:= 1 to cant_detalle do begin
            Reset(archivoN[i]);
            leerNacimiento(archivoN[i],leidosN[i]);
            reset(archivoF[i]);
            leerFallecmiento(archivoF[i],leidosF[i]);
        end;
        minimo_nac(archivoN,leidosN,min_n);
        minimo_fall(archivoF,leidosF,min_f);
        while(min_n.nro_partida_nacimiento <> valor_alto) do begin
            reg_m.nro_partida_nacimiento := min_n.nro_partida_nacimiento;
            reg_m.nombre := min_n.nombre;
            reg_m.apellido := min_n.apellido;
            reg_m.direccion:= min_n.direccion;
            if(min_n.nro_partida_nacimiento = min_f.nro_partida_nacimiento) then begin
                reg_m.fallecio:= true;
                reg_m.fecha:= min_f.fecha;
                reg_m.fecha:=
            else
                writeln('La persona no fallecio aun');
                reg_m.fallecio:= false;
            end;

        end;

            

         terminara....
        
        for i:= 1 to cant_detalle do begin
            close(archivoN[i]);
            close(archivoF[i]);
        end;
        close(archivoM);
    end;


        MUY LARGO Y NI APALO NOS TOMAN ESTO PAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA./
    dfg


//voy a hablar con mi vieja, si terminan y no estoy pasen el cod
var
    arc_maestro: maestro;
    detaVIVO: arreglo_archivo_detalle_nacimientos;
    detaMUERTO: arreglo_archivo_detalle_fallecidos;
    regVIVO: arreglo_registro_detalle_nacimientos;
    regMUERTO: arreglo_registro_detalle_fallecidos;

begin
    Assign (arc_maestro,'maestro');
	crearMaestro (arc_maestro,detaVIVO,detaMUERTO,regVIVO,regMUERTO);
	mostrarMaestro (arc_maestro);
end.