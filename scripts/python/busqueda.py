import json
import sys
import os

def buscar():

    ruta = "/tiendas/ElVestidor"  # ajusta a tu tienda
    filtro = sys.argv[1].lower()

    rutas = open("rutas_busqueda.txt", "w", encoding="utf-8")
    nombres = open("nombres_busqueda.txt", "w", encoding="utf-8")

    i = 1

    for root, dirs, files in os.walk(ruta):
        for archivo in files:
            if archivo.endswith(".json"):
                path = os.path.join(root, archivo)
                with open(path, "r") as f:
                    datos = json.load(f)
                descripcion = datos.get("descripcion", "")
                if filtro in descripcion.lower():
                    rutas.write(path + "\n")
                    nombres.write(f"{i}. {datos.get('nombre')}\n")
                    i += 1

    rutas.close()
    nombres.close()


if __name__ == "__main__":
    buscar()