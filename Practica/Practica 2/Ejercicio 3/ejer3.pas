{ 3.Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.

Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.}

program ejer3;

const
    valor_alto = 9999;    
    cant_detalles = 30;

type

    venta=record
        cod:integer;
        nombre:string;
        descripcion:string;
        stock:integer;
        stock_min:integer;
        precio:real;
    end;
    
    venta_detalle = record
        cod:integer;
        c_v:integer;
    end;

    archivo_maestro = file of venta;
    archivo_detalle = file of venta_detalle;

    vector_archivos = array [1 .. cant_detalles]  of archivo_detalle;
    vector_venta = array [1 .. cant_detalles] of venta_detalle;

procedure leer_venta(var r:venta);

 begin
	with r do begin
		write('Ingrese codigo de producto: ');
		readln(cod);
		if( cod <> 0) then begin
			write('Ingrese nombre de producto: ');
			readln(nombre);
			write('Ingrese descripcion de producto: ');
			readln(descripcion);
			write('Ingrese stock actual del producto: ');
			readln(stock);
			write('Ingrese stock minimo del producto: ');
			readln(stock_min);
			write('Ingrese precio del producto: ');
			readln(precio);
		end;
	end;
end; 


procedure crear_maestro (var a:archivo_maestro);
var
    rv:venta;
begin
    Writeln('ingrese la informacion de maestro ordenada por cod');
    rewrite(a);
    leer_venta(rv);
    while (rv.cod <> 0 ) do begin
        write (a,rv);
        leer_venta(rv);
    end;
    close(a);
    
end;

procedure crearDetalle(var v:vector_archivos);
    procedure leerDetalle(var d:venta_detalle);
    begin
        write('Ingrese un codigo de venta');
        readln(d.cod);
        if (d.cod <> 0 ) then begin 
            write('Ingrese la cantidad vendida ');
            readln(d.c_v);
         end;
    end;
var
    v_d:venta_detalle;
    i:integer;
    i_Str:string; //necesaria para convertir int a string
begin
    for i := 1 to cant_detalles do begin     
        Str(i, i_Str); // convierte lo que esta en i, en una variable string en i_STR
        assign(v[i], 'detalle'+i.toString); 
        rewrite(v[i]);
        leerDetalle(v_d);      
        while (v_d.cod <> 0) do begin
            write(v[i], v_d);
            leerDetalle(v_d);
        end;
        close(v[i]);
    end;
end; 

procedure leer(var arch:archivo_detalle; var r:venta_detalle);
begin
    if(not eof(arch))then
        read(arch, r)
    else
        r.cod := valor_alto;
end; 

procedure minimo(var v_act: vector_venta; var vector_de_archivos: vector_archivos; var min:venta_detalle );
var
    i: integer;
    min_pos: integer;
begin
    min.cod:=valor_alto;
    for i:=1 to cant_detalles do begin
        if(v_act[i].cod < min.cod)then begin
            min:= v_act[i];
            min_pos:= i;
        end;
    end;
    leer(vector_de_archivos[min_pos], v_act[min_pos]);
end;

procedeure leerMaestro(var m:maestro; regM:venta);
begin
    if not(eof(m)) then 
        read(m,regM)
    else
        regM.cod:= valor_alto
end;

procedure actualizar_maestro(var m: archivo_maestro; var vector_de_archivos: vector_archivos);
var 
    v_ventas: vector_venta;
    min: venta_detalle;
    i: integer;
    reg_m:venta;
begin
    for i:= 1 to cant_detalles do begin
        reset(vector_de_archivos[i]);
        leer(vector_de_archivos[i], v_ventas[i]);
    end;
    reset(m);
    minimo(v_ventas, vector_de_archivos, min);
    leerMaestro(m,reg_m);
    while (min.cod <> valor_alto) do begin
        
        while (min.cod <> reg_m.cod) do
            leerMaestro(m,reg_m);
       
        while(min.cod = reg_m.cod) do begin
            reg_m.stock:= reg_m.stock - min.c_v;
            minimo(v_ventas, vector_de_archivos, min);
        end;
        seek(m,filepos(m)-1);
        write(m,reg_m);
    end;
    for i:= 1 to cant_detalles do 
        close(vector_de_archivos[i]);
    close(m);
    
end;

procedure exportar_txt (var arch:archivo_maestro; var txt:Text);
var
    reg_m:venta;
begin
    rewrite(txt);
    reset(arch);
    while (not eof(arch)) do begin
        read (arch, reg_m);
        if (reg_m.stock < reg_m.stock_min) then
            with reg_m do
                writeln(txt, 'nombre de producto: ', nombre,' descripcion: ',descripcion,' stock actual ',stock,' precio: ',precio:2:2,'.');
    end;
    close(arch);
    close(txt);
end;

var
    m: archivo_maestro;
    v: vector_archivos;
    txt: Text;
begin
    assign(m, 'maestro');
    crear_maestro(m);
    crearDetalle(v);
    actualizar_maestro(m,v);
    assign(txt, 'SinTitulo.txt');
    exportar_txt(m, txt);
end.

