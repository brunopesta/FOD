{   
    Una editorial de diarios y revistas distribuye y vende sus productos (diarios y revistas) al interior del país. 
    La editorial cuenta con 5 distribuidoras. Cada distribuidora envía un listado con los productos vendidos 
    indicando: código de producto y cantidad vendida del mismo.
    
    La editorial posee un archivo maestro en donde almacena la información de todos los diarios y revistas 
    que distribuye, para ello el archivo maestro cuenta con el código de producto, nombre, descripción y el 
    stock actual de cada producto.

    Escriba el programa principal con la declaración de los tipos de datos necesarios y realice un proceso que 
    reciba los 5 detalles y actualice el archivo maestro con la información proveniente de los archivos de 
    detalle.

    Tanto el maestro como los detalles se encuentran ordenados por el código de producto. No se realizan 
    ventas de ejemplares sin stock.
    Nota: la solución planteada debe ser escalable en cuanto a la cantidad de detalles.
    
}

program parcial5;

const
    valor_alto = 9999;
    cant_detalles = 5;
type

    productos = record
        cod: integer;
        cant: integer;
    end;

    editorial = record 
        cod: integer;
        nombre: string[25];
        descripción: string[25];
        stock_actual: integer;
    end;
    
    maestro = file of editorial;
    archivo_detalle = file of productos;

    arreglo_archivo_detalle = array[1..cant_detalles] of archivo_detalle;
    arreglo_registro_detalle = array [1..cant_detalles] of productos;
    
    procedure leer(var d:detalle; p:productos);
    begin
        if (not (eof(d))) then 
            read(d,p);
        else
            p.cod:= valor_alto;
    end;

    procedure minimo (var vecD:arreglo_archivo_detalle; var leidos:arreglo_registro_detalle;  var min:productos);
    var
        pos,i:integer;
    begin
        pos:= 1;
        min.cod:= valor_alto;
        for i:= 1 to cant_detalles do begin
            if(leidos[i].cod < min.cod) then begin
                min:= leidos[i];
                pos:= i;
            end;
        end;
        leer(vecD[pos],leidos[pos]);
    end;

    procedure actualizar_maestro(var archivoM: maestro; var archivoD: arreglo_archivo_detalle);
    var
        leidos:arreglo_registro_detalle;
        i:integer;
        regM:editorial;
        min: productos;
        cant: integer;
    begin
        reset(m);
        for i:= 1 to cant_detalles do begin
            reset(archivoD[i]);
            leer(archivoD[i],leidos[i]);
        end;
        read(archivoM,regM);
        minimo(archivoD,leidos,min);
        while( min.cod <> valor_alto) do begin
            while(regM.cod <> min.cod) do 
                read(archivoM,regM);
 
            while(regM.cod = min.cod) do begin
                regM.stock_actual:= regM.stock_actual - min.cant;
                minimo(archivoD,leidos,min);
            end;
    
            seek(archivoM,filepos(archivoM)-1);
            write(archivoM,regM);
        end;

        for i:= 1 to cant_detalles do begin
            close(archivoD[i]);
        end;
        close(archivoM);
    end;
var
    i:integer;
    archivoM: maestro;
    arregloD: arreglo_archivo_detalle;
begin
    Assign(archivoM,'maestro');
    for i:= 1 to cant_detalles do 
        Assign(arregloD[i],'Detalle ' i.toString);
    end;
    actualizar(archivoM,arregloD);
end.