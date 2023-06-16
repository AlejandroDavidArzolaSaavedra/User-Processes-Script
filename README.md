# procesos-de-usuario

PS Personalizado

Este programa es una versión personalizada del comando "ps" en Bash. Proporciona una lista de los procesos en ejecución del usuario actual.


# Cómo ejecutar el programa

Clona este repositorio en tu máquina local:

git clone https://github.com/tu_usuario/ps-personalizado.git

Navega hasta el directorio del proyecto:

cd ps-personalizado

Otorga permisos de ejecución al archivo del programa:

chmod +x ps_personalizado.sh

# Ejecuta el programa:

# Para que salga los elementos basicos
./procesos_usuario.sh <numero entero>

Ej:

./procesos_usuario.sh 1

Y te saldra si supera el umbral, los datos del usuario que ejecuto el programa


# Para ejecutarlo con elementos basicos y con lista de usuarios

./procesos_usuario.sh <numero entero> [Lista de usuarios]

Ej:

./procesos_usuario.sh 1 root pepe juan Suarez

Y de la lista de usuarios te saldran los que son del sistema y superan el umbral
Y los que no forman parte del sistema por error del usuario tambien se muestran en una lista aparte


# Para ejecutarlo con elementos basicos adicionales

./procesos_usuario.sh <numero entero> <opcion> [Lista de usuarios]

Las opciones son:

-m Total de la memoria virtual
-t Los procesos con tty
-T Los procesos sin tty

Ej:

./procesos_usuario.sh 1 -Tmt root pepe juan Suarez

o

./procesos_usuario.sh 1 -mt

# Funcionalidades

Muestra una lista de los procesos en ejecución del usuario actual. Proporciona información como el nombre de usuario, el uid, los numeros de procesos totales de ese usuario, el numero de hilos totales que tiene ese usuario en ese momento, el numero de procesos que estan dormidos de manera predeterminada, y de manera opcional el consumo total de memoria virtual, el numero de total de procesos con tty y el numero total de procesos sin tty. 


# Contribuciones

Las contribuciones son bienvenidas. Si deseas mejorar este programa, sigue estos pasos:

- Haz un fork de este repositorio.
- Crea una rama para tu nueva funcionalidad: git checkout -b nueva-funcionalidad
- Realiza los cambios necesarios y realiza los commits: git commit -am 'Agregar nueva funcionalidad'
- Envía tus cambios a tu repositorio fork: git push origin nueva-funcionalidad
- Abre un pull request en este repositorio.


# Contacto

Si tienes alguna pregunta o sugerencia, no dudes en contactarme a través de mi correo electrónico: tu_correo@example.com


# ¡Disfruta usando el PS personalizado!


