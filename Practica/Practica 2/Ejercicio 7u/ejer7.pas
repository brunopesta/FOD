{7- El encargado de ventas de un negocio de productos de limpieza desea administrar el
stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos
los productos que comercializa. De cada producto se maneja la siguiente información:
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

program ejer7;

const 
    valorAlto= 9999;
type

    regM = record
        cod:integer;
        nombre:string;
        precio:real;
        stockAct:integer;
        stockMin:integer;
    end;

    regD = record
        cod:integer;
        cant_vendida:integer;
    end;

    maestro = file of regM;
    detalle = file of regD;

procedure leermaestro(var m:regM);
begin
    writeln('Ingrese el codigo del producto');
    readln(m.cod);
    if (m.cod <> -1) then begin
        writeln('Ingrese el nombre del producto');
        readln(m.nombre);
        writeln('Ingrese el precio del producto');
        readln(m.precio);
        writeln('Ingrese el stock actual de producto');
        readln(m.stockAct);
        writeln('Ingrese el stock Mininmo del producto');
        readln(m.stockMin);
    end;
end;

procedure leerDetalle(var d:regD);
begin
    writeln('Ingrese el codigo del producto');
    readln(d.cod);
    if (d.cod <> -1) then begin
        writeln('Inrgese la cantidad vendida de ese producto ');
        readln(d.cant_vendida);
    end;
end;

procedure crearMaestro(var  a:maestro);
var
    reg:regM;
begin
    rewrite(a);
    leermaestro(reg);
        while (reg.cod <> -1 ) do  begin
            write(a,reg);
            leermaestro(reg);
        end;
    close(a);
end;

procedure crearDetalle(var d:detalle);
var
reg:regD;
begin
    rewrite(d);
    leerDetalle(reg);
    while (reg.cod <> -1) do begin
        write(d,reg);
        leerDetalle(reg);
    end;
    close(d);
end;

 procedure leerAlumno(var mae:detalle; var e:regD);
    begin
        if(not eof(arch))then
            read(arch, e)
        else
            e.cod := valoralto;
    end;

procedure actualizarMaestro(var  a:maestro; var aD:detalle);
var
    rM:regM;
    rD:regD;
begin
    reset(a);
    reset(aD);
    leer(aD,rD);
    while (rD.cod <> valorAlto) do begin
        read(a,rM);
        while (rD.cod <> rM.cod ) do begin
            read(a,rM);
        end;
        while (rD.cod = rM.cod) do begin
            rM.stockAct:= rM.stockAct - rD.cant_vendida;
            leer(aD,rD);
        end;
        Seek(a,FilePos(a)-1);
        write(a,rM);
    end;
    close(a);
    close(aD);
end;

procedure listar_en_txt( var a:maestro; var a_txt: Text);
var
    rM:regM;
begin
    reset(a);
    rewrite(a_txt);
    while not eof(a) do begin
        read(a,rM);
        if (rM.stockAct < rM.stockMin) then 
            write(a_txt,'Codigo de producto:',rM.cod, 'Precio de venta : $', rM.precio:2:2, 'Stock actual: ',rM.stockAct, 'Stock minimo ',rM.stockMin, 'Nombre comercial: ',rM.nombre, ' " '+ #10);
    end;
    close(a);
    close(a_txt);
end;

var
m:maestro;
d:detalle;
a_txt:Text
begin
    Assign(m,'maestro');
    Assign(d,'detalle');
    //crearMaestro(m);
    //crearDetalle(d);
    actualizarMaestro(a,d);
    listar_en_txt(m.a_txt);
end.



