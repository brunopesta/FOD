{
    
    7- El encargado de ventas de un negocio de productos de limpieza desea administrar el
    stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos
    los productos que comercializa.

    De cada producto se maneja la siguiente información:
    código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
    Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
    realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.
    Se pide realizar un programa con opciones para:

    a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
    ● Ambos archivos están ordenados por código de producto.

    ● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
    archivo detalle.

    ● El archivo detalle sólo contiene registros que están en el archivo maestro.

    b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
    stock actual esté por debajo del stock mínimo permitido.

}

program parcial9;

const
    valor_alto = 9999;
type

    producto= record
        cod:integer;
        nombre:string;
        precio:real;
        stock_actual:integer;
        stock_minimo:integer;
    end;

    venta=record
        cod:integer;
        cantidad_vendidas:integer;
    end;

    maestro = file of producto;
    
    detalle = file of Venta;
    
    procedure leer(var d:detalle; v:venta);
    begin
        if not(eof(d))then
            read(d,v)
        else
            v.cod:= valor_alto;
    end;


    procedure actualizar(var archivoM: maestro; var archivoD: detalle);
    var
        regD: detalle;
        regM: maestro;
        cant_vendida: integer;
    begin
        reset(archivoM);
        reset(archivoD);
        leer(archivoD,regD);
        read(m,regM);
        while(regD.cod <> valor_alto) do begin
            cant_vendida:= 0;
            while (regM.cod <> regD.cod) do 
                read(m,regM);
            
            while (regM.cod = regD.cod) do begin
                cant_vendida:= cant_vendida +  regD.cant_vendida;
                leer(archivoD,regD);
            end;
            regM.stock_actual:= regM.stock_actual -  cant_vendida;
            seek(m,filepos(m) - 1);
            write(m,regM);
        end;
        close(archivoM);
        close(archivoD);
    end;
    

    
    procedure hacerTxt(var m: maestro; var text:Text);
    var
        regM: producto;
    begin
        reset(m);
        while not (eof(m)) do begin
            read(m,regM);
            if (regM.stock_actual < regM.stock_minimo) then 
                writeln(text,'Codigo:',regM.cod, #10,' Nombre: ',regM.nombre, #10, ' stock actual', regM.stock_actual, #10, 'Stock minimo', regM.stock_minimo, #10);
        end;
        close(m);
        close(txt);
    end.
    
var
    archivoM: maestro;
    archivoD: detalle;
    Txt: Text;
begin
    assign(arch_maestro, 'maestro');
    assign (arch_Txt,'stock_minimo.txt');
    actualizar(arch_maestro);
    hacerTxt (arc_maestro,arcTxt);
end.