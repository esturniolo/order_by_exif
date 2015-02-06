#!/bin/bash
echo "Ingrese el path absoluto de imágenes a ordenar"
read -e DirOri
echo "Ingrese donde desea guardar las imágenes (se ordenaran en la ubicación elegida dentro de carpetas 'mes-año')"
read -e DirDest
echo "Las imagenes en ""$DirOri"" seran ordenadas en el directorio ""$DirDest""i"

read -n1 -r -p "Presione Enter para continuar o CTRL - C para abortar operación"


echo "-- Empieza script --"
if [ -d $DirDest ]; then
        0; else
        mkdir $DirDest
fi;


cd $DirOri

echo "-- Empieza For --"

for img in *;
        do identify -format %[EXIF:DateTimeOriginal] $img &&
        echo "-- Paso fecha --"
                anio=`echo ${img:0:4}` &&
                mes=`echo ${img:4:4}` &&
                tmp=`echo $mes""$anio` &&
                fecha=`echo ${tmp:1:7}` &&
                echo $fecha
        echo "-- Paso if --"
                if [ -d $DirDest/$fecha ]; then
                        mv $img $DirDest/$fecha; else
                        garlopa=garlopa
                fi;
        echo "-- Comienza Case --"
                case $garlopa in
                                *)
                                        echo "Primer case"
                                        mkdir $DirDest/$fecha && mv $img $DirDest/$fecha
                                        ;;
                esac
        echo "-- Termina case --"
done
