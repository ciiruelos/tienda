#!/bin/bash

echo -n "Deseas cargar la estructura de la tienda? [S/N]: "
read respuesta

if [[ "$respuesta" == "S" || "$respuesta" == "s" ]]; then
    mkdir -p /tiendas/ElVestidor/Mujer
    cd /tiendas/ElVestidor/Mujer
    mkdir -p Zara Stradivarius Bershka

    mkdir -p /tiendas/ElVestidor/Hombre
    cd /tiendas/ElVestidor/Hombre
    mkdir -p Nike Adidas Levis

    mkdir -p /tiendas/ElVestidor/Ninio
    cd /tiendas/ElVestidor/Ninio
    mkdir -p GapKids HMKids ZaraKids

    cat <<EOF > /tiendas/ElVestidor/Mujer/Zara/001.json
{
  "nombre": "Camiseta",
  "descripcion": "Camiseta de manga corta",
  "precio": "12",
  "stock": "200"
}
EOF

    cat <<EOF > /tiendas/ElVestidor/Hombre/Levis/002.json
{
  "nombre": "Pantalón",
  "descripcion": "Pantalón negro",
  "precio": "35",
  "stock": "150"
}
EOF

    cat <<EOF > /tiendas/ElVestidor/Ninio/GapKids/003.json
{
  "nombre": "Chándal",
  "descripcion": "Chándal rojo",
  "precio": "23",
  "stock": "20"
}
EOF

    echo "Descarga Completada."

elif [[ "$respuesta" == "N" || "$respuesta" == "n" ]]; then
    echo "Descarga Cancelada."
    exit
else
    echo "Opción no válida."
fi
