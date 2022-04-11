{10.
 Se tiene información en un archivo de las horas extras realizadas por los empleados de
una empresa en un mes. Para cada empleado se tiene la siguiente información:
departamento, división, número de empleado, categoría y cantidad de horas extras
realizadas por el empleado. Se sabe que el archivo se encuentra ordenado por
departamento, luego por división, y por último, por número de empleados. Presentar en
pantalla un listado con el siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.}
program ejer10;

const
 categoria =15;
 valor_alto= 9999;

type

    regM = record
        departamento:integer;
        division:integer;
        num_emp:integer;
        cat:integer;
        cant_horas:integer;
        end;

    archivo_maestro = file of regM;

    arreglo_horas = array [1..categoria] of integer;


    procedure leerDatosMaestro(var r:regM);
    begin
        writeln('Ingrese el numero de empleado');
        readln(r.num_emp);
        if (r.num_emp <> -1) then begin
            writeln('Ingrese un departamento');
            readln(r.departamento);
            writeln('Ingrese una division');
            readln(r.division);
            writeln('Ingrese una categoria de 1..15');
            readln(r.cat);
            writeln('Ingrese una cant de horas');
            readln(r.cant_horas);
        end;
    end;

    procedure crearMaestro(var a:archivo_maestro);
    var
    r:regM;
    begin
        rewrite(a);
        leerDatosMaestro(r);
        while (r.num_emp <> -1) do begin
            write(a,r);
            leerDatosMaestro(r);
        end;
    end;

    procedure llenarVec(var vec:arreglo_horas; var a_:Text);
    var
        num,pos:integer;
    begin
        num:= 0;
        num:= 0;
        reset(a_);
        while not eof(a_) do begin
            readln(a_,pos,num);
            vec[pos]:=num;
        end;
        close(a_);
    end;

    procedure leer(var arch: archivo_maestro; var rM:regM);
    begin
        if not eof(arch) then
            read(arch,rM)
        else
            rM.num_emp := valor_alto;
    end;

    procedure presentar ( var a:archivo_maestro; var vec:arreglo_horas; var a_:Text);
    var
        cat_aux,tot_aux,tot_horas,monto_tot,monto_tot_div,tot_horas_div,monto_aux:integer;
        cod_dept_aux,divisiones_aux,num_aux:integer;

        rM:regM;
    begin
        reset(a);
        leer(a,rM);
        llenarVec(vec,a_);
        while (rM.departamento <> valor_alto) do begin
            writeln('Departamento   ',rM.departamento);
            cod_dept_aux:= rM.departamento;
            tot_horas:=0;
            monto_tot:=0;
            while (cod_dept_aux = rM.departamento) do begin
                divisiones_aux:= rM.division;
                tot_horas_div:=0;
                monto_tot_div:=0;
                while (cod_dept_aux = rM.departamento) and (divisiones_aux = rM.division) do begin
                    num_aux:= rM.num_emp;
                    cat_aux:= rM.cat;
                    writeln('Numero de empleado      Total de hs       Importe a cobrar');
                    monto_aux:=0;
                    tot_aux:=0;
                    while (cod_dept_aux = rM.departamento) and ( divisiones_aux = rM.division) and (num_aux = rM.num_emp) do begin
                        writeln('      ',rm.num_emp, '        ',rM.cant_horas,'       ',vec[rM.cat]  );
                        tot_aux:= tot_aux + rM.cant_horas;
                        leer(a,rM);
                    end;
                    monto_aux:= monto_aux + (tot_aux * vec[cat_aux]);
                    monto_tot_div:= tot_horas_div + monto_aux;
                    tot_horas_div:= tot_horas_div + tot_aux;
                end;
                writeln('Division ',#10,rM.division);
                writeln('Total horas division: ',tot_horas_div);
                writeln('Monto total por division',tot_horas_div);
                tot_horas:= tot_horas + tot_horas_div;
                monto_tot:= monto_tot + monto_tot_div;
            end;
            writeln('total horas departamento',tot_horas);
            writeln('Monto total departamento', monto_tot);
        end;
        close(a);
    end;


var
    a_txt:Text;
    a:archivo_maestro;
    vec:arreglo_horas;

begin
    assign(a,'maestro');
    assign(a_txt,'horas_extra_vec.txt');
    //crearMaestro(a);
    presentar(a,vec,a_txt);
end.