import json
import sys
from datetime import datetime

# Recibimos datos desde bash
ruta = sys.argv[1]
nombre = sys.argv[2]
descripcion = sys.argv[3]
precio = sys.argv[4]
stock = sys.argv[5]
envase = sys.argv[6]

# Abrimos JSON
with open(ruta, "r") as f:
    producto = json.load(f)

# Actualizamos campos
producto["nombre"] = nombre
producto["descripcion"] = descripcion
producto["precio"] = precio
producto["stock"] = stock
producto["envase"] = envase

# Guardamos cambios
with open(ruta, "w") as f:
    json.dump(producto, f, indent=4)

# Guardar log
fecha_hora = datetime.now().strftime("%H:%M-%d/%m/%y")

with open("programa.log", "a") as log:
    log.write(f"{fecha_hora} | EDITAR_PRODUCTO | Producto editado: {ruta}\n")

print("Producto actualizado correctamente")