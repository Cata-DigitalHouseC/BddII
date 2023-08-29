use dhtube;
SELECT nombreArchivo,
REVERSE(nombreArchivo),
LOCATE('.',REVERSE(nombreArchivo))-1,
RIGHT(nombreArchivo,
LOCATE('.',
REVERSE(nombreArchivo))-1)
FROM video;