#!/bin/bash

TIENDA="/tiendas/ElVestidor"
LOG="programa.log"

#se recibe la categoría como argumento
CATEGORIA="$1"

if [ -z "$CATEGORIA" ]; then
    echo "Error: no se recibió la categoría."
    exit 1
fi

#validaciones
while true; do
    echo -n "Indica el nombre de la nueva marca (s para salir): "
    read NOMBRE

    #para salir
    if [ "$NOMBRE" = "s" ]; then
    clear
        exit 0

    fi

    #ncomprobar que el nombre no esté vacío
    if [ -z "$NOMBRE" ]; then
        echo "Error: nombre vacío."
        continue
    fi

    #comprobar que no tenga espacios
    if [[ "$NOMBRE" =~ [[:space:]] ]]; then
        echo "Error: el nombre no puede contener espacios."
        continue
    fi

    #comprobar que no comienza con punto
    if [[ "$NOMBRE" == .* ]]; then
        echo "Error: el nombre no puede empezar con punto."
        continue
    fi

    #comprobar que no contenga /.
    if [[ "$NOMBRE" == */* ]]; then
        echo "Error: el nombre no puede contener /."
        continue
    fi

    #comprobar que tenga solo letras, números, guión o guión bajo
    if ! [[ "$NOMBRE" =~ ^[A-Za-z0-9_-]+$ ]]; then
        echo "Error: nombre solo puede contener letras, números, guión (-) o guión bajo (_)."
        continue
    fi

    #comprobar que no exista ya
    RUTA="$TIENDA/$CATEGORIA/$NOMBRE"
    if [ -d "$RUTA" ]; then
        echo "Error: la marca ya existe."
        continue
    fi

    
    mkdir -p "$RUTA"
    chmod 777 "$RUTA"
    clear
    echo "Marca creada correctamente en la categoría '$CATEGORIA'."


    FECHA_HORA=$(date +"%H:%M-%d/%m/%y")
    echo "$FECHA_HORA | MARCA | Marca '$NOMBRE' creada en categoría '$CATEGORIA'" >> "$LOG"

    read -n 1 -s -r -p "Pulsa una tecla para continuar..."
    clear
    break
done