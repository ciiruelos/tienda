#!/bin/bash

clear

read -p "Indica el codigo del producto: " codigo

#comprobamos que se escriba un codigo y que no este vacio
if [[ -z "$codigo" ]]; then
    read -n1 -p "No puedes dejar el codigo vacio"
    exit
fi

#buscar coincidencias
mapfile -t resultados < <(find /tiendas/ElVestidor -name "$codigo.json")

#comprobar si se han encontrado resultados
if [[ ${#resultados[@]} -eq 0 ]]; then
    echo "No se ha encontrado ninguna coincidencia"
    read -n1 -p "Pulsa una tecla para volver"
    exit
fi

#mostrar si hay varias coincidencias
if [[ ${#resultados[@]} -gt 1 ]]; then

    echo ""
    echo "Se han encontrado varios productos:"

    for i in "${!resultados[@]}"; do
        echo "$((i+1))) ${resultados[$i]}"
    done

    echo ""
    read -p "Seleccione un producto: " opcion

    clear

    #validar opcion
    if [[ $opcion -lt 1 || $opcion -gt ${#resultados[@]} ]]; then
        read -n1 -p "Opcion no valida"
        exit
    fi

    ruta=${resultados[$((opcion-1))]}

else

    ruta=${resultados[0]}

fi

#obtener datos del json
nombre=$(jq -r '.nombre' "$ruta")
descripcion=$(jq -r '.descripcion' "$ruta")
precio=$(jq -r '.precio' "$ruta")
stock=$(jq -r '.stock' "$ruta")
envase=$(jq -r '.envase' "$ruta")


echo ""
echo "Producto encontrado"
echo "-------------------"
echo "Nombre: $nombre"
echo "Descripcion: $descripcion"
echo "Precio: $precio"
echo "Stock: $stock"
echo "Envase: $envase"

echo ""
echo "¿Qué desea hacer?"
echo "Editar (e), Borrar (b) o Volver (v)"
echo ""
read -p "Seleccione una opción: " opcion

clear

if [[ $opcion == "e" || $opcion == "E" ]]; then
    bash scripts/bash/acciones_producto.sh editar "$ruta"
elif [[ $opcion == "b" || $opcion == "B" ]]; then
    bash scripts/bash/acciones_producto.sh borrar "$ruta"
elif [[ $opcion == "v" || $opcion == "V" ]]; then
    exit
else
    echo "Opción no válida"
    read -n1 -p "Pulsa una tecla para volver"
    exit
    clear
fi