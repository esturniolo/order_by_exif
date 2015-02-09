#!/bin/bash
echo "Ingrese el path absoluto de imágenes a ordenar"
read -e DIRORI
echo

echo "Ingrese donde desea guardar las imágenes (se ordenaran en la ubicación elegida dentro de carpetas 'mes-año')"
read -e DIRDEST
echo

echo "Las imagenes en ""$DIRORI"" seran ordenadas en el directorio ""$DIRDEST"""
echo

DATE=`date +%d-%m-%y_%H%M`
TOTALFILES=`ls -l $DIRORI | wc -l`

echo -n "Creando backup ..."; backup=`tar -cvzPf /tmp/Backup_Exif_$DATE.tgz $DIRORI` 2> ./error.log &
PID=$!

while kill -0 $PID 2> /dev/null; do
echo -n "."
sleep 2
done

echo -n " Backup finalizado."; 

RC=`echo $?`

if RC eq=0; then
	0; else
	echo "ERROR. Por favor revise el error en el archivo 'error.log'"
fi
	
echo $RC


echo "Cantidad total de imágenes a ordenar "$TOTALFILES""
echo



read -n1 -r -p "Presione Enter para continuar o CTRL - C para abortar operación"


echo "-- Empieza script --"
if [ -d $DIRDEST ]; then
        0; else
        mkdir $DIRDEST
fi;


cd $DIRORI

echo "-- Empieza For --"

for IMG in *;
        do identify -format %[EXIF:DateTimeOriginal] $IMG &&
        echo "-- Paso fecha --"
                ANIO=`echo ${IMG:0:4}` &&
                MES=`echo ${IMG:4:4}` &&
                TMP=`echo $MES""$ANIO` &&
                FECHA=`echo ${TMP:1:7}` &&
                echo $FECHA
        echo "-- Paso if --"
                if [ -d $DIRDEST/$FECHA ]; then
                        mv $IMG $DIRDEST/$FECHA; else
                        GARLOPA=garlopa
                fi;
        echo "-- Comienza Case --"
                case $GARLOPA in
                                *)
                                        echo "Primer case"
                                        mkdir $DIRDEST/$FECHA && mv $IMG $DIRDEST/$FECHA
                                        ;;
                esac
        echo "-- Termina case --"
done
