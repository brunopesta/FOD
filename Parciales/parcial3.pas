{
    La gerencia de una empresa de ventas de articulos para el hogar con dos sucursales
    en la ciudad recibe mensualmente de cada sucursal un archivo ordenado por codigos de categoria, de marca  y 
    de modelo de productos vendidos en el mes, con la cantidad de unidades vendidas de cada uno. 
    Codificar un procedimineto que reciba como parametros a los dos archivos de ventas y a un arrchivo de texto
    todos asigandos y sin abrir y reporte en el archivo de texto el total de unidades vendidas por categoria, por categoria y marca, y por categoria marca y modelo
    Una misma marca puede tener producto de distintas categorias y distintas marcas pueden tener productos con el mismo codigo de modelo

}
program parcial3;

const 
    valor_alto= '9999';
    cant_detalles = 2;
type

    sucursal = record
        cod_cat:string;
        marca:string;
        modelo:string;
        ventas:integer;
    end;

    detalle = file of sucursal;
   
    
    procedure leer(d:detalle; s:sucursal);
    begin
        if not (eof(d)) then
            read(d,s)
        else
            s.cod_cat:= valor_alto;
    end;


    procedure minimo(var reg_d1:sucursal; var reg_d2:sucursal; var min:sucursal);
    
    begin
        if reg_d1 > reg_d2 then begin
            min := reg_d1;
            leer(d, reg_d1);
            end
        else begin
            min:= reg_d2;
            leer(d2,reg_d2);
        end;
    end;

    procedure Merge(var d:detalle; var d2:detalle; var maestro:Text );
    var
        r1:sucursal;
        r2:sucursal;
        min:sucursal;
    begin
        Reset(d);
        Reset(d2);
        Rewrite(maestro);
        leer(d,r1);
        leer(d2,r2);
        min(d,d2,min);
        while (min.cod_cat <> valor_alto) do 
            writeln(min.cod);
            
            min();


    end;


