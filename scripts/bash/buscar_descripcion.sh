#!/bin/bash

clear

read -p "Indica un filtro de búsqueda: " filtro

if [[ -z "$filtro" ]]; then
    read -n1 -p "No puedes dejar el filtro vacío"
    exit
fi

# Ejecutamos python
python3 /home/ciruelos/programa/scripts/python/busqueda.py "$filtro"

# Comprobamos si hay resultados
if [[ ! -s nombres_busqueda.txt ]]; then
    echo "No se han encontrado coincidencias"
    read -n1 -p "Pulsa una tecla para volver"
    exit
fi

# Mostramos resultados
echo ""
cat nombres_busqueda.txt

echo ""
read -p "Indica el numero de producto (s para salir): " numero

if [[ "$numero" == "s" ]]; then
    exit
fi

#obtener la ruta
contenido=$(sed -n "${numero}p" rutas_busqueda.txt)

if [[ -z "$contenido" ]]; then
    read -n1 -p "Seleccion no valida"
    exit
fi

clear

#mostrar contenido del json
nombre=$(jq -r '.nombre' "$contenido")
descripcion=$(jq -r '.descripcion' "$contenido")
precio=$(jq -r '.precio' "$contenido")
stock=$(jq -r '.stock' "$contenido")
envase=$(jq -r '.envase' "$contenido")

clear

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

read -p "Seleccione una opcion: " opcion
clear

if [[ "$opcion" == "e" ]]; then
    bash scripts/bash/acciones_producto.sh editar "$contenido"

elif [[ "$opcion" == "b" ]]; then
    bash scripts/bash/acciones_producto.sh borrar "$contenido"

elif [[ "$opcion" == "v" ]]; then
    exit
    clear

else
    read -n1 -p "Opcion no valida"
fi