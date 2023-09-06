#!/bin/bash     

#En esta primera parte del codigo se establecen una ciertas reglas de uso al usuario. Si el usuario no digita dos argumentos <nombre del usuario><nombre del grupo> el programa procedera a cerrarse y mostrara un mensaje sobre su uso correcto al usuario.
                                 
if [ $# -ne 2 ]; then                             # Si el numero de argumentos no es igual a 2
    echo "Error: Debe ingresar el nombre de un usuario y el nombre de un grupo."   # Muestre un mensaje uso correcto del script
    echo "Vuelva a intentarlo"                                                 # Mestre un mensaje 
    sleep 3                                                                    # Delay de 3 segundos
    exit 1                                                                     # Cierre en script
fi

#Se declaran las variables.

usuario="$1"             # Se declara la variable del usuario la cual es el primer argumento introducido 
grupo="$2"               # Se declara la variable del grupo la cual es el segundo argumento introducido

#Se declaran variables de color para el texto.

rojo="\033[0;31m"           # Se declara la variable del color rojo
amarillo="\033[0;33m"       # Se declara la variable del color amarillo
reset="\033[0m"             # Se declara la variable del devuelve el texto al color original 


#En esta parte del codigo se verifica si el nombre del grupo y nombre del usuario introducidos por el usuario existen en el sistema.Si el nombre del usuario y el nombre del grupo existen en el sistema se mostrara un mensaje al usuario indicado de la existencia delusuario y grupo, de lo contrario mostrara un mensaje al usuario indicando de la no existencia del grupo y usuario, y el programa procedera a crearlos. 


if id "$usuario" &>/dev/null; then                                         # Si el usuario introducido se encuentra en el sistema
    echo -e "El usuario ${rojo}${usuario}${reset} existe."                 # Muestra mensaje de la existencia del usuario
    sleep 2                                                                # Delay de 2 segundos

else                                                                       # Sino
    echo -e "El usuario ${rojo}${usuario}${reset} no existe."              # Muestre mensaje de la no existencia del usuario
    sleep 2                                                                # Delay de 2 segundos
    echo -e "Creando usuario ${rojo}${usuario}${reset}....."               # Muestre mensaje
    sleep 2                                                                # Delay de 2 segundos
    sudo useradd "$usuario"                                                # Crea nuevo usuario 
    echo -e "Usuario ${rojo}${usuario}${reset} creado."                    # Muestre un mensaje de que se ha creado usuario
    sleep 2                                                                # Delay de 2 segundos
fi


if grep -q "^$grupo:" /etc/group; then                     # Si grupo introducido se encuentra en el archivo del grupos del sistema
    echo -e "El grupo ${amarillo}${grupo}${reset} existe."     # Muestra mensaje de la existencia del grupo
    sleep 2                                                    # Delay de 2 segundos

else                                                           # Sino
    echo -e "El grupo ${amarillo}${grupo}${reset} no existe."  # Muestre mensaje de la no existencia del grupo 
    sleep 2                                                    # Delay de 2 segundos
    echo -e "Creando grupo ${amarillo}${grupo}${reset}....."   # Muestre mensaje 
    sudo groupadd "$grupo"                                     # Crea nuevo grupo
    sleep 2                                                    # Delay de 2 segundos
    echo -e "Grupo ${amarillo}${grupo}${reset} creado."        # Muestre un mensaje de que se ha creado grupo 
    sleep 2                                                    # Delay de 2 segundos
fi

exit 0                  # Cierre el script al terminar de ejecutar el codigo correctamente
