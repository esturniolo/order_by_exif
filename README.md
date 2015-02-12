# order_by_exif
Ordena imágenes según la fecha original de disparo de la fotografía.
#ISSUES
- Si la ejecución del programa se cancela durante la creación del backup, el backup no muere. Continúa en el background.
- Problemas a la hora de contabilizar las imágenes tratadas. La cantidad no es la correcta.

#TODO
- Crear directorio personalizado para contabilizar la cantidad de imágenes tratadas al finalizar el script.
- Poner código de retorno en paso backup, para detectar errores en ese comando (ej. falta de espacio)

#DONE
- Comparar cantidad de imágenes antes y después del script. Si difiere, volver atrás con el backup.
