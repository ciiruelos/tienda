#!/bin/bash

MARCA="$1"
TIENDA="/tiendas/ElVestidor"
LOG="programa.log"

clear

#pedir un nombre que sea valido.
while true; do
    echo -n "Indica el código del producto: "
    read CODIGO

    if [ -z "$CODIGO" ]; then
        echo "Código vacío, inténtalo de nuevo."
        continue
    fi

        # validar que sea numérico
    if [[ ! "$CODIGO" =~ ^[0-9]+$ ]]; then
        echo "Error: el código debe ser numérico."
        continue
    fi

    #comprobar que el producto no exista en toda la tienda.
    EXISTE=$(find "$TIENDA" -name "$CODIGO.json" 2>/dev/null)
    if [ "$EXISTE" != "" ]; then
        echo "Error: el código ya existe en otra categoría o marca. Elige otro."
        continue
    fi
    break
done

clear

#pedir los datos del producto.
echo "Datos del producto:"
echo -n "Nombre del producto: "
read NOMBRE
echo -n "Descripción: "
read DESCRIPCION

#validacion del precio.
while true; do
    echo -n "Precio: "
    read PRECIO
    if [ -z "$PRECIO" ] || [[ "$PRECIO" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        break
    else
        echo "Error: valor incorrecto introducido."
    fi
done

#valiidación del stock.
while true; do
    echo -n "Stock: "
    read STOCK
    if [ -z "$STOCK" ] || [[ "$STOCK" =~ ^[0-9]+$ ]]; then
        break
    else
        echo "Error: valor incorrecto introducido."
    fi
done

echo -n "Tipo de envase: "
read ENVASE

#donde se va a crear el producto.
RUTA="$MARCA/$CODIGO.json"

#crear el json.
echo "{" > "$RUTA"
echo "  \"nombre\": \"$NOMBRE\"," >> "$RUTA"
echo "  \"descripcion\": \"$DESCRIPCION\"," >> "$RUTA"
echo "  \"precio\": \"$PRECIO\"," >> "$RUTA"
echo "  \"stock\": \"$STOCK\"," >> "$RUTA"
echo "  \"envase\": \"$ENVASE\"" >> "$RUTA"
echo "}" >> "$RUTA"

clear
echo "Producto $CODIGO creado correctamente en $MARCA."
read -n 1 -s -r -p "Pulsa cualquier tecla para continuar..."
clear

FECHA_HORA=$(date +"%H:%M-%d/%m/%y")
echo "$FECHA_HORA | PRODUCTO | Producto '$CODIGO' creado en $MARCA" >> "$LOG"

exit 0