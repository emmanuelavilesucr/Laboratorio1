#!/bin/bash                                 

#En esta primera parte del codigo se establen ciertas reglas al usuario para ejecutar el codigo. Si no ingresa correctamente el archivo el programa se cerrara.  

if [ $# -ne 1 ]; then                                               # Si el numero de argumentos no es igual a 1
    echo "Error: Debe proporcionar el nombre de un archivo."        # Muestre un mensaje indicando el uso correcto del script 
    exit 1                                                          # Cierre el script
fi                                                                  


archivo="$1"                                    # Se declara la variable de archivo la cual es el primer argumento 

#Las siguientes varibles son colores para el texto.

rojo="\033[0;31m"                               # Se declara la variable del color rojo
amarillo="\033[0;33m"                           # Se declara la variable del color amarillo
reset="\033[0m"                                 # Se declara la variable del devuelve el texto al color original 


# En esta parte si el usuario ingresa el nombre de un archivo no existente se le mostrara un mensaje al usuario indicando que el archivo no exite y el posteriormente el programa se cerrara.

if [ ! -e "$archivo" ]; then                                        # Si el nombre del archivo introducido no exite
    echo -e "El archivo ${rojo}${archivo}${reset} no existe."       # Muestre un mensaje de la no existencia del archivo
    sleep 2                                                         # Delay de 2 segundos
    echo "Vuelva a intentarlo con un archivo existente en el sistema."   # Muestre  un mensaje indicando un error  
    sleep 2                                                         # Delay de 2 segundos
    echo "Cerrando programa...."                                    # Muestre un mensaje indicando que el script se va a cerrar
    sleep 2                                                         # Delay de 2 segundos

    exit 2                                                          # Cierre el script
fi

permisos=$(stat -c "%A" "$archivo")                # Se declara una variable la cual almacena datos sobre los permisos del archivo  



#Se declara la funcion get_permissions_verbose().En esta funcion se invoca a la funcion interpretacion(), para obtener la interpretacion de los permisos en forma de palabra y usar estas palabras para mostrarle al usuario un mensaje con los permisos que poseen el usuario, grupo y otros usuarios sobre el archivo.

get_permissions_verbose() {                       # Se declara una funcion 

 
    permisos="$1"                              # Se declara una variable al primer argumento
    usuario="${permisos:1:3}"                  # Se declara una variable indicando los caracteres a extraer de la cadena de permisos
    grupo="${permisos:4:3}"                    # Se declara una variable indicando los caracteres a extraer de la cadena de permisos
    otros="${permisos:7:3}"                    # Se declara una variable indicando los caracteres a extraer de la cadena de permisos


    echo -e "${amarillo}Permisos del usuario:${reset}"     # Muestre un mensaje con los permisos del usario
    interpretacion "$usuario"          # Llame a la funcion interpretacion() que esta encargada de traducir los permisos en palabras
    sleep 2                              # Delay de 2 segundos
    echo -e "${amarillo}Permisos del grupo:${reset}"             # Muestre un mensaje con los permisos del grupo
    interpretacion "$grupo"            # Llame a la funcion interpretacion() que esta encargada de traducir los permisos en palabras
    sleep 2                              # Delay de 2 segundos
    echo -e "${amarillo}Permisos de otros usuarios:${reset}"     # Muestre un mensaje con los permisos de los otros usuarios
    interpretacion "$otros"            # Llame a la funcion interpretacion() que esta encargada de traducir los permisos en palabras
                    
    
}


#Se declara una funcion en la se toman los permisos del archivo y se interpretan en forma de las palabras Lectura, Escritura y Ejecuacion, para posteriormente ser invocada en la funcion get_permissions_verbose().

interpretacion() {                        # Se declara una funcion 

    permisos="$1"                         # Se declara una variable al primer argumento
    espacio=""                            # Se declara una variable para mostrar renglon en blanco

    for (( i=0; i<${#permisos}; i++ )); do  # Inicie bucle que cuente la cantidad de caracteres de la variable permisos
        permiso="${permisos:$i:1}"          # Se declara la variable para acceder a la cadena de caracteres del bucle   
        case "$permiso" in                  # Compare los valores de la variable e imprima mensajes
	       	"r") echo "Lectura";;           # Muestre la palabra Lectura cuando el archivo tenga permisos de lectura(r)
	       	"w") echo "Escritura";;         # Muestre la palabra Escritura cuando el archivo tenga permisos de escritura(w)
		"x") echo "Ejecución";;         # Muestre la palabra Ejecuacion cuandoel archivo tenga permisos de ejecuacion(x)
		*) echo "---------";;           # Muestre ------- en los espacios en los que no tengan pemisos
        esac
    done
    echo "$espacio"                     # Imprima la variable
}

get_permissions_verbose "$permisos"                 # Llame a la funcion get_permissions_verbose()

exit 0                                              # Cierre el script cuando se termine de ejecutar correctamente 
