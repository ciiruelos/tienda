#!/bin/bash

clear

# Pedimos el codigo
read -p "Indica el codigo del producto: " codigo

# Comprobamos que no este vacio
if [[ -z "$codigo" ]]; then
    read -n1 -p "No puedes dejar el codigo vacio"
    exit
fi

# Buscamos coincidencias
mapfile -t resultados < <(find /tiendas/ElVestidor -name "$codigo.json")

# Comprobamos si hay resultados
if [[ ${#resultados[@]} -eq 0 ]]; then
    echo "No se ha encontrado ninguna coincidencia"
    read -n1 -p "Pulsa una tecla para volver"
    exit
fi

# Si hay varias coincidencias las mostramos
if [[ ${#resultados[@]} -gt 1 ]]; then

    echo ""
    echo "Se han encontrado varios productos:"

    for i in "${!resultados[@]}"; do
        echo "$((i+1))) ${resultados[$i]}"
    done

    echo ""
    read -p "Seleccione un producto: " opcion

    clear

    # Validamos opcion
    if [[ $opcion -lt 1 || $opcion -gt ${#resultados[@]} ]]; then
        read -n1 -p "Opcion no valida"
        exit
    fi

    ruta=${resultados[$((opcion-1))]}

else

    ruta=${resultados[0]}

fi

# Obtenemos datos del JSON
nombre=$(jq -r '.nombre' "$ruta")
descripcion=$(jq -r '.descripcion' "$ruta")
precio=$(jq -r '.precio' "$ruta")
stock=$(jq -r '.stock' "$ruta")
envase=$(jq -r '.envase' "$ruta")

# Mostramos producto
echo ""
echo "Producto encontrado"
echo "-------------------"
echo "Nombre: $nombre"
echo "Descripcion: $descripcion"
echo "Precio: $precio"
echo "Stock: $stock"
echo "Envase: $envase"
echo ""
read -n1 -p "Pulsa una tecla para volver"