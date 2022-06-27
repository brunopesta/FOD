
{Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.

Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro.
 La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.

Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto}

program pracial6;

const
    valor_alto = 9999;
    cant_detalle = 30;
type
    productos = record
        cod:integer;
        nombre:string;
        desc:string;
        stock_Act:integer;
        stock_min:integer;
        precio:double;
    end;


    det=  record
        cod:integer;
        cant_vendida:integer;

    maestro = file of productos;

    detalle = file of det;

    vec_Detalle = array [1..cant_detalle] of detalle;

    vec_Registros = array [1..cant_detalle] of det;

    procedure leer(var d:detalle; regD:det);
    begin
        if (not eof(d)) then 
            read(d,regD)
        else
            regD.cod:= valor_alto
    end;

    procedure minimo(var vecd:vec_Detalle; var leidos:vec_Registros; var min:det);
    var
        pos,i:integer;
    begin
        min.cod:= valor_alto;
        for i:= 1 to cant_detalle do 
            if(leidos[i].cod < min.cod) then begin
                min:= leidos[i];
                pos:= i;
            end;
        leer(vecD[pos],leidos[pos]);
    end;

    procedure ActualizarMaestro(var m:maestro; vecD:vec_Detalle);
    var
        regM:productos;
        i:integer;
        min:det;
        leidos:vec_Registros;
    begin
        reset(m);
        for i:= 1 to cant_detalle do begin
            reset(vecD[i]);
            leer(vecD[i],leidos[i]);
        read(m,regM);
        minimo(vecD.leidos,min);
        while (min.cod <> valor_alto) do begin

            while(min.cod <> regM.cod) do
                read(m.regM)

            while (min.cod = regM.cod) do begin
                regM.stock_Act:= regM.stock_Act - min.cant_vendida;
                minimo(vecD,leidos,min);
            end;

            seek(m,filepos(m) - 1);
            write(m,regM);
        end;
        close(m);
        for i:= 1 to cant_detalle do
            close(vecD[i])
    end;

    procedure crear_txt(var m:maestro; var txt:Text);
    var
        regM:producto;
    begin
        Reset(m);
        Rewrite(txt);
        while (not(eof(m))) do begin
            read(m,regM);
            writeln(text,'nombre : ', regM.nombre, #10, 'Descripcion: ', regM.desc, #10,'Stock disponible', regM.stock_Act, #10);
            if (regM.stock_Act < regM.stock_min) then 
                writeln(text,'Precio: ',regM.precio);
        end;
        close(m);
        close(txt);
    end;
var
    m:maestro;
    vecD:vec_Detalle;
    txt:Text;
    i:integer;
begin
    Assign(m,'maestro');
    for i:= 1 to cant_detalle do
        Assign(vecD[i],'detalle' + i.toString)
    Assign(txt,'Archivo TXT');
    ActualizarMaestro(m,vecD);a2/
end.