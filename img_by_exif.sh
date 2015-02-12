#!/bin/bash

function BKP(){
backup=`tar -cvzPf /home/pi/ToshibaPi/Backup_Exif_$DATE.tgz $DIRORI`
}


function EXIF(){
for IMG in *;
        do identify -format %[EXIF:DateTimeOriginal] $IMG && 
		
                ANIO=`echo ${IMG:0:4}` &&
                MES=`echo ${IMG:4:4}` &&
                TMP=`echo $MES""$ANIO` &&
                FECHA=`echo ${TMP:1:7}` &&


                if [ -d $DIRDEST/$FECHA ]; then
			mv $IMG $DIRDEST/$FECHA; else
			mkdir $DIRDEST/$FECHA; mv $IMG $DIRDEST/$FECHA
                fi

done

}


function CREA_DEST(){
if [ -d $DIRDEST ]; then
	echo; else
	echo -n "Creando carpeta "$DIRDEST""; mkdir $DIRDEST
fi;
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

echo "Las imagenes en ""$DIRORI"" seran ordenadas en el directorio ""$DIRDEST"""
echo

TOTALFILES=`ls $DIRORI | wc -l`

echo
echo "Cantidad total de imágenes a ordenar: "$TOTALFILES""
echo

echo -n "Creando backup ..."; BKP > /dev/null 2> salida.log &
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
EXIF
