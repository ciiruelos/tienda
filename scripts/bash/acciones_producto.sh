#!/bin/bash

accion=$1
ruta=$2

#leer los datos actuales del producto
nombre=$(jq -r '.nombre' "$ruta")
descripcion=$(jq -r '.descripcion' "$ruta")
precio=$(jq -r '.precio' "$ruta")
stock=$(jq -r '.stock' "$ruta")
envase=$(jq -r '.envase' "$ruta")

if [[ $accion == "editar" ]]; then

    echo "Editar producto"
    echo "--------------"

    read -e -p "Nombre: " -i "$nombre" nuevo_nombre
    read -e -p "Descripcion: " -i "$descripcion" nueva_descripcion
    read -e -p "Precio: " -i "$precio" nuevo_precio
    read -e -p "Stock: " -i "$stock" nuevo_stock
    read -e -p "Envase: " -i "$envase" nuevo_envase

    read -p "¿Confirmar cambios? [S/N] " confirmar

    if [[ $confirmar == "S" || $confirmar == "s" ]]; then
        python3 scripts/python/editar_producto.py \
        "$ruta" "$nuevo_nombre" "$nueva_descripcion" "$nuevo_precio" "$nuevo_stock" "$nuevo_envase"

        echo "Producto actualizado correctamente"
    else
        echo "Operacion cancelada"
    fi


elif [[ $accion == "borrar" ]]; then

    read -p "¿Realmente deseas eliminar este producto? [S/N] " confirmar

    if [[ $confirmar == "S" || $confirmar == "s" ]]; then
        rm "$ruta"
        echo "Producto eliminado con exito"
    else
        echo "Operacion cancelada"
    fi

fi