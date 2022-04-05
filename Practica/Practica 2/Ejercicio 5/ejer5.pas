program ejer5;

const

    valor_alto = 9999;
    cant_detalles= 50;
type

    reg_nacimientos = record
        num_partida:integer;
        nombre:string;
        apellido:string;
        direccion_detallada:string;
        matricula_medico:real;
        dni_madre:string[8];
        nombre_apellido_madre:string;
        nombre_apellido_padre:string;
        dni_padre:string[8];
    
    end;

    reg_falle = record
        num_partida:integer;
        dni:string[8];
        nombre:string;
        apellido:string;
        matricula_medico:real;
        fecha_muerte:string;
        lugar_muerte:string;
    end;

    reg_maestro = record
        num_partida:integer;
        nombre:string;
        apellido:string;
        direccion_detallada:string;
        matricula_medico:real;
        dni_madre:string[8];
        nombre_apellido_madre:string;
        nombre_apellido_padre:string;
        dni_padre:string[8];
        fallecio : boolean;
    end;

    arch_det_nacimiento = file of reg_nacimientos;
    arch_det_fallecimineto = file of reg_falle;
    arch_maestro = file of reg_maestro;

    vec_fallecimiento = array [1..cant_detalles] of reg_falle;
    vec_nacimiento = array [1..cant_detalles] of reg_nacimientos;
    vec_arch_nacimiento = array [1..cant_detalles] of arch_det_nacimiento;
    vec_arch_fallecidos = array [1..cant_detalles] of arch_det_fallecimineto;


//////////////////////////////////////////////////////////////////// chunai acaca
procedure crear_detalle_fallecidos(var v: vec_arch_fallecidos );
    procedure cargar_detalle(var d:reg_falle);
    begin
        write('Ingrese nro de partida ');
        readln(d.num_partida);
        if (d.num_partida <> 0 ) then begin 
            write('Ingrese dni ');
            readln(d.dni);
            write('ingrese nombre: ');
            readln(d.nombre);
            write('Ingrese apellido ');
            readln(d.apellido);
            write('matricula_medico: ');
            readln(d.matricula_medico);
            write('Ingrese fecha de muerte');
            readln(d.fecha_muerte);
            write('Ingrese lugar de muerte: ');
            readln(d.lugar_muerte);
            
         end;
    end; 
var
    reg_d:reg_falle;
    i:integer;
    i_Str:string; //necesaria para convertir int a string
begin
    for i := 1 to cant_detalles do begin     
        Str(i, i_Str); // convierte lo que esta en i, en una variable string en i_STR
        assign(v[i], 'detalle'+i_Str); 
        rewrite(v[i]);
        cargar_detalle(reg_d);      
        while (reg_d.num_partida <> -1) do begin
            write(v[i], reg_d);
            cargar_detalle(reg_d);
        end;
        close(v[i]);
    end;
end; 
////////////////////////////////////////////////////////////

procedure leer_fallecimientos(var arch: arch_det_fallecimineto; var r:reg_falle);
begin
    if(not eof(arch))then
        read(arch, r)
    else
        r.num_partida := valor_alto;
end;
procedure minimo_fallecimientos(var vector_de_archivos: vec_arch_fallecidos; var v_act: vec_fallecimiento;  var min:reg_falle);
var
    i: integer;
    min_pos: integer;
begin
    min_pos:=1;
    min.num_partida:=valor_alto;
    for i:=1 to cant_detalles do begin
        if(v_act[i].num_partida < min.num_partida)then begin
            min:= v_act[i];
            min_pos:= i;
        end;
    end;
    if(min.num_partida <> valor_alto)then
        leer_fallecimientos(vector_de_archivos[min_pos], v_act[min_pos]);
end;    


//////////////////////////////////////////////////////////////////////////// Bruno
procedure crear_detalle_nacimiento(var v: vec_arch_nacimiento );
    procedure cargar_detalle(var d:reg_nacimientos);
    begin
        write('Ingrese un Numero de partida ');
        readln(d.num_partida);
        if (d.num_partida <> 0 ) then begin 
            write(' Ingrese el nombre del recien nacido');
            readln(d.nombre);
            write('Ingrese el apellido del recien nacido');
            readln(d.apellido);
            write('Ingrese la direccion detallada por (calle,nro, piso, depto, ciudad) es ese orden');
            readln(d.direccion_detallada);
            write('Ingrese el precio de la matricula del medico');
            readln(d.matricula_medico);
            write('Ingrese el nombre y apellido de la madre');
            readln(d.nombre_apellido_madre);
            write('Ingrese dni de la madre');
            readln(d.dni_madre);
            write('Ingrese nombre y apellido del padre');
            readln(d.nombre_apellido_padre);
            write('Ingrese el dni del padre');
            readln(d.dni_padre);
         end;
    end;
var
    reg_d:reg_nacimientos;
    i:integer;
    i_Str:string; //necesaria para convertir int a string
begin
    for i := 1 to cant_detalles do begin     
        Str(i, i_Str); // convierte lo que esta en i, en una variable string en i_STR
        assign(v[i], 'detalle'+i_Str); 
        rewrite(v[i]);
        cargar_detalle(reg_d);      
        while (reg_d.num_partida <> -1 ) do begin
            write(v[i], reg_d);
            cargar_detalle(reg_d);
        end;
        close(v[i]);
    end;
end; 

procedure leer_nacimiento(var arch: arch_det_nacimiento; var r:reg_nacimientos );
begin
    if(not eof(arch))then
        read(arch, r)
    else
        r.num_partida := valor_alto;
end;


procedure minimo_nacimineto( var vector_de_archivos: vec_arch_nacimiento;var v_act: vec_nacimiento; var min:reg_nacimientos );
var
    i: integer;
    min_pos: integer;
begin
    min_pos:=1;
    min.num_partida:=valor_alto;
    for i:=1 to cant_detalles do begin
        if(v_act[i].num_partida < min.num_partida)then begin
            min:= v_act[i];
            min_pos:= i;
        end;
    end;
    if(min.num_partida <> valor_alto)then
        leer_Nacimiento(vector_de_archivos[min_pos], v_act[min_pos]);
end;

procedure crearMaestro( var archM:arch_maestro; var arrayF :vec_arch_fallecidos; var arrayN:vec_arch_nacimiento);
var
i:integer;
i_str:string;
arrayFaux:vec_fallecimiento;
arrayNaux:vec_nacimiento;
reg_fall:reg_falle;
reg_nac:reg_nacimientos;
reg_m: reg_maestro;
begin
rewrite(archM);
for i:= 1 to cant_detalles do begin
    Str(i,i_str);
    assign(arrayF[i],'falle +i_str');
    reset(arrayF[i]);
    leer_fallecimientos(arrayF[i],arrayFaux[i]);
    assign(arrayN[i],'Naci'+i_str);
    reset(arrayN[i]);
    leer_nacimiento(arrayN[i],arrayNaux[i]);
end;

minimo_fallecimientos(arrayF,arrayFaux,reg_fall);
minimo_nacimineto(arrayN,arrayNaux,reg_nac);
while(reg_nac.num_partida<>valor_alto) do begin
        reg_m.num_partida:= reg_nac.num_partida;
        reg_m.nombre:= reg_nac.nombre;
        reg_m.apellido:= reg_nac.apellido;
        reg_m.direccion_detallada:= reg_nac.direccion_detallada;
        reg_m.matricula_medico:= reg_nac.matricula_medico;
        reg_m.dni_madre:= reg_nac.dni_madre;
        reg_m.nombre_apellido_madre:= reg_nac.nombre_apellido_madre;
        reg_m.nombre_apellido_padre:= reg_nac.nombre_apellido_padre;
        reg_m.dni_padre:= reg_nac.dni_padre;
        if (reg_m.num_partida = reg_fall.num_partida) then begin
            reg_m.matricula_medico:= reg_fall.matricula_medico;
           //reg_m.fallecio := true;
            minimo_fallecimientos(arrayF,arrayFaux,reg_fall);
        end;
        write(archM,reg_m);
        minimo_nacimineto(arrayN,arrayNaux,reg_nac);
    end;
    for i:= 1 to cant_detalles do begin
        close(arrayF[i]);
        close(arrayN[i]);
    end;
    close(archM);
end;

procedure crearArchivoTxt(var archM: archivo_maestro);
var
    rM:archivoM;
    archivo_txt: Text;
begin
    Assign(archivo_txt,'informacion-de-pacientes');
    rewrite(archivo_txt);
    reset(archM);
    while (not eof(archM)) do begin
        read(archM,rM);
        write(archivo_txt,'Numero de partida de nacimiento: ', rM.nroP, ', Nombre: ', rM.nombre, ', Apellido: ', rM.apellido, ', Direccion: ', rM.direccion, ', Matricula del medico: ', rM.matricula, ', Nombre de la madre: ', rM.nombreM, ', Apellido de la madre: ', rM.apellidoM, ', Dni de la madre: ', rM.dniM, ', Nombre del padre: ', rM.nombreP, ', Apellido del padre: ', rM.apellidoP, ', Dni del padre: ', rM.dniP, #10);
        if(rM.matriculaMedico <> '') then 
            write(archivo_txt, ', Matricula del medico que firma el deceso: ',rM.matriculaMedico, ', Fecha: ',rM.fecha, ', Hora: ',rM.hora, ', Lugar: ', rM.lugar);
        writeln(archivo_txt, ' ');
    end;
    close(archM);
    close(archivo_txt);
end;

//PROGRAMA PRINCIPAL BY xxxCHUNAIxxx

var
    archivos_de_nacimientos: arch_nacimientos;
    archivos_de_fallecimientos: arch_falle;
    archivo_maestro: arch_maestro;
 
begin 

    assign(maestro,'maestro');
    assign(archivo_maestro_texto,'maestro.txt');
    
    writeln('Detalle fallecimientos: ');
    crear_detalle_fallecidos(archivos_de_fallecimientos);

    writeln('Detalles nacimientos: ');
    crear_detalle_nacimiento(archivos_de_nacimientos);

    writeln('-----------------Maestro----------------------------');
    crearMaestro(archivo_maestro, archivos_de_nacimientos, archivos_de_fallecimientos);
    crearArchivoTxt(archivo_maestro);
end.