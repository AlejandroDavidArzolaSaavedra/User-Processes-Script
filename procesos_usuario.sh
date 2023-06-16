#!/bin/bash
####################################
# @author: ADAS
# @date: 15-01-2023
# 1. Visualizar procesos del sistema
####################################

# Gestion de errores de la aplicaciones
imprimir_error_formato_entrada() {
    echo -e "\n \e[0;31mFormato erroneo\e[0m\n"
    echo -e "Uso: procesos_usuario umbral [lista_usuarios]\n"
    exit -1
}

# Informacion de las opciones adicionales de la aplicacion
imprimir_info_opciones_adicionales() {
    echo    "Las opciones adicionales son: "
    echo    "-m Para ver el consumo total de memoria virtual"
    echo    "-t Para ver procesos con tty"
    echo -e "-T Para ver los procesos sin tty \n"
}

# Dar formato de tabla
dar_formato_de_encabezado_tabla() {

    titulo_columnas="Nombre_usuario _UID_ Numero_procesos Hilos_totales Procesos_dormido $1 $2 $3"
    printf "\n%-14s %-5s %-15s %-13s %-16s %-16s %-15s %-16s\n" $titulo_columnas
    case "$memoria_flag$sin_tty_flag$con_tty_flag" in
      "111") echo -e "\e[1;33m-------------- ----- --------------- ------------- ---------------- ---------------- ---------------- ----------------\e[0m" ;;
      "110"|"101"|"011") echo -e "\e[1;33m-------------- ----- --------------- ------------- ---------------- ---------------- ---------------- \e[0m" ;;
    "100"|"010"|"001") echo -e "\e[1;33m-------------- ----- --------------- ------------- ---------------- ---------------- \e[0m"
    ;;
  *) echo -e "\e[1;33m-------------- ----- --------------- ------------- ----------------\e[0m" ;;
    esac
}

# El formato de los datos que se introduciran en la tabla
dar_formato_salida_tabla() {
        valores_a_imprimir="$nombre_usuario $uid_usuario $procesos_del_usuario $numero_de_hilos $procesos_dormidos $1 $2 $3"
        printf "%-14s %-5s %-15s %-13s %-16s %-16s %-16s %-16s\n" $valores_a_imprimir
}

# 1) Tratamos que el usuario introduzca un umbral correcto
[[ $# == 0 ]] && imprimir_error_formato_entrada
numero="^[0-9]+$"
umbral=$1;
[[ ! $umbral =~ $numero ]] 2>/dev/null && imprimir_error_formato_entrada # Tratamos umbrales erroneos
shift

# 2) Procesamos las opciones introducidas
memoria_flag=0;
sin_tty_flag=0;
con_tty_flag=0;
while getopts "mtT" opt
do
    if [[ " ${opcion_repetida[*]} " == *" $opt "* ]];
    then
        # Gestionamos el error de introducir mas de una vez una opcion valida
        echo -e "\n \e[0;31mSe ha introducido una opcion valida repetida\e[0m\n"
        exit -1
    fi
  
  case $opt in
    m)
        memoria_flag=1
        ;;
    t)
        con_tty_flag=1
        ;;
    T)
        sin_tty_flag=1
        ;;
    \?)
        shift $((OPTIND-1))
        echo -e "\n \e[0;31mOpcion adicional erronea\e[0m"
        imprimir_info_opciones_adicionales
        exit -1
        ;;
  esac
        opcion_repetida+=($opt)
done 2>/dev/null

shift $((OPTIND -1)) # Desplazamos las opciones introducidas

# 3) Gestionamos la presentacion de la interfaz

case "$memoria_flag$sin_tty_flag$con_tty_flag" in
  "111") dar_formato_de_encabezado_tabla "Consumo_mem_virt" "Procesos_sin_tty" "Procesos_con_tty";;
  "110") dar_formato_de_encabezado_tabla "Consumo_mem_virt" "Procesos_sin_tty" ;;
  "101") dar_formato_de_encabezado_tabla "Consumo_mem_virt" "Procesos_con_tty" ;;
  "011") dar_formato_de_encabezado_tabla "Procesos_con_tty" "Procesos_sin_tty" ;;
  "100") dar_formato_de_encabezado_tabla "Consumo_mem_virt" ;;
  "010") dar_formato_de_encabezado_tabla "Procesos_con_tty" ;;
  "001") dar_formato_de_encabezado_tabla "Procesos_sin_tty" ;;
  *) dar_formato_de_encabezado_tabla ;;
esac

# Tratamos que se introduzca o no la lista de usuarios
listado_usuarios=$@
[[ $# -eq 0 ]] && listado_usuarios=$USER

usuarios_no_existentes=""; # Lista de usuarios no existentes en el sistema
indice=$(( $# ))
ultimo_elemento=${!indice}

for i in $listado_usuarios
do
        procesos_del_usuario=$(find /proc -maxdepth 2 -name status -user $i | wc -l)
        if [[ $procesos_del_usuario -gt $umbral ]]
        then
                nombre_usuario=$i
                numero_de_hilos=0
                info_de_procesos=$(find /proc -maxdepth 2 -name status -user $nombre_usuario -exec grep -E "^(Uid:|Threads:|State:|VmSize)" {} \; | tr "\t" " " | tr -s " ")
                numero_total_de_hilos=$(printf "$info_de_procesos" | egrep "Threads: [0-9]+" | cut -d" " -f2)

				for i in $numero_total_de_hilos
                do
                        numero_de_hilos=$((numero_de_hilos + i))
                done
				
				uid_usuario=$(printf "$info_de_procesos" | egrep "Uid: [0-9]+" | cut -d" " -f2 | head -1)
                procesos_dormidos=$(printf "$info_de_procesos" | egrep "^State: "  | egrep -c "(sleeping)")

                # Comprobamos si solicitaron la memoria total virtual del usuario
                if [[ $memoria_flag -eq 1 ]]
                then
                        total_memoria_virtual=0
                        memoria_virtual=$(printf "$info_de_procesos" | egrep "^VmSize:" | cut -d" " -f2 )
                        for i in $memoria_virtual
                        do
                                total_memoria_virtual=$((total_memoria_virtual + i))
                        done
                fi

                # Comprobamos si solicitaron tty
                if [[ $sin_tty_flag -eq 1 || $con_tty_flag -eq 1 ]]
                then
                        procesos_sin_tty=0
                        procesos_con_tty=0

                        for i in $(find /proc -maxdepth 2 -path "/proc/[0-9]*" -name fd -user $nombre_usuario)
                        do
                                comprobacion_de_tty=$(ls -l $i | egrep -c "/dev/pts|/dev/tty")
                                if [[ $comprobacion_de_tty -gt 0 ]]
                                then
                                        procesos_con_tty=$((procesos_con_tty + 1))
                                else
                                        procesos_sin_tty=$((procesos_sin_tty + 1))
                                fi
                        done
                fi

				# Gestionamos la salida de la tabla
                case "$memoria_flag$sin_tty_flag$con_tty_flag" in
                  "111") dar_formato_salida_tabla $total_memoria_virtual $procesos_sin_tty $procesos_con_tty;;
                  "110") dar_formato_salida_tabla $total_memoria_virtual $procesos_sin_tty ;;
                  "101") dar_formato_salida_tabla $total_memoria_virtual $procesos_con_tty ;;
                  "011") dar_formato_salida_tabla $procesos_con_tty $procesos_sin_tty ;;
                  "100") dar_formato_salida_tabla $total_memoria_virtual ;;
                  "010") dar_formato_salida_tabla $procesos_con_tty ;;
                  "001") dar_formato_salida_tabla $procesos_sin_tty ;;
                      *) dar_formato_salida_tabla ;;
                esac
        else
                if [[ $i == $ultimo_elemento ]]
                then
                        usuarios_no_existentes+="$i "
                else
                        usuarios_no_existentes+="$i, "
                fi
        fi
done 2>/dev/null

# Comprobamos si hay usuarios introducidos que no existen y lo informamos
long_usuarios=${#usuarios_no_existentes}
[[ $long_usuarios -gt 0 ]] && echo -e "\nLos usuarios no encontrados en el sistema son: [ $usuarios_no_existentes]\n"

# Finaliza el programa
exit 0
