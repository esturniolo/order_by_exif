#!/bin/bash
clear

function BKP(){
cd $DIRORI
rm /tmp/Backup_Exif_*.tar.gz
tar -cvzf /tmp/Backup_Exif_$DATE.tar.gz ./
}

function CREA_DEST(){
if [ -d $DIRDEST ]; then
	echo; else
	echo -n "Creando carpeta "$DIRDEST""; mkdir $DIRDEST; mkdir $DIRDEST/Ordenadas 2> /dev/null; echo
fi;
}

function EXIF(){
for IMG in *;
        do $TOMAEXIF $IMG &&

                ANIO=`echo ${TOMAEXIF:0:4}` &&
                MES=`echo ${TOMAEXIF:4:4}` &&
                TMP=`echo $MES""$ANIO` &&
                FECHA=`echo ${TMP:1:7}` &&


                if [ -d $DIRDEST/Ordenadas/$FECHA ]; then
                        mv $IMG $DIRDEST/Ordenadas/$FECHA; else
                        mkdir $DIRDEST/Ordenadas/$FECHA; mv $IMG $DIRDEST/Ordenadas/$FECHA
                fi

done

}

function COMPARADOR(){
if [ "$TOTALFILES" -eq "$TOTALFILESPOST" ]; then
	rm -r /tmp/Backup_Exif_$DATE.tar.gz; echo "Proceso finalizado con éxito"; else
	rm -r $DIRDEST/Ordenadas/$FECHAS; RESTOREBKP; echo "Hubo diferencias en la cantidad de archivos procesados"

fi
}

function RESTOREBKP(){
cd $DIRORI
tar -xzvf /tmp/Backup_Exif_$DATE.tar.gz
rm /tmp/Backup_Exif_$DATE.tar.gz
}


function RETORNO(){
if [ $RC -eq 0 ];then
        echo "Backup exitoso."; else
        echo "ERROR. Por favor revise el error en el archivo 'salida.log'"
fi
}

DATE=`date +%d-%m-%y_%H%M`

echo "Ingrese el path absoluto de imágenes a ordenar"
read -e DIRORI
echo

echo "Ingrese donde desea guardar las imágenes (se ordenaran en la ubicación elegida dentro de carpetas 'mes-año')"
read -e DIRDEST
echo


echo "Las imagenes en ""$DIRORI"" seran ordenadas en el directorio ""$DIRDEST""/Ordenadas"
echo


#mkdir $DIRDEST/Ordenadas 2> /dev/null

cd $DIRORI
TOTALFILES=`find . -type f | wc -l`

echo
echo "Cantidad total de imágenes a ordenar: "$TOTALFILES""
echo



read -n1 -r -p "BREAK"

echo
echo -n "Creando backup ..."; BKP > /dev/null 2> /tmp/salida.log &
PIDBK=$!

while kill -0 $PIDBK 2> /dev/null; do
echo -n "."
sleep 2
done
echo

echo
echo -n "Backup finalizado."; 
echo

read -n1 -r -p "Presione Enter para continuar o CTRL - C para abortar operación"


#echo "-- Empieza script --"
CREA_DEST

cd $DIRORI

#echo "-- Empieza For --"
TOMAEXIF=`identify -format %[EXIF:DateTimeOriginal]`
EXIF

echo "Archivos antes del proceso: "$TOTALFILES""
cd $DIRDEST/Ordenadas
echo "Archivos después del proceso: "$TOTALFILESPOST""

COMPARADOR
