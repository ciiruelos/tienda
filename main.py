import curses
import subprocess
import datetime

LOG = "programa.log"

# Función para escribir solo inicio y fin de sesión
def escribir_log(tipo, descripcion):
    ahora = datetime.datetime.now()
    fecha_hora = ahora.strftime("%H:%M-%d/%m/%y")
    with open(LOG, "a", encoding="utf-8") as f:
        f.write(f"{fecha_hora} | {tipo.upper()} | {descripcion}\n")

# Funciones del menú Crear
def crear(terminal):
    opciones = ["Categoria", "Marca", "Producto", "Volver"]
    seleccion = 0

    while True:
        terminal.clear()
        terminal.addstr("¿Qué quieres crear?\n", curses.A_BOLD | curses.A_UNDERLINE)

        for i, opcion in enumerate(opciones):
            if i == seleccion:
                terminal.addstr(f"> {opcion}\n", curses.A_REVERSE)
            else:
                terminal.addstr(f"  {opcion}\n")

        terminal.refresh()
        key = terminal.getch()

        if key == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif key == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif key in [curses.KEY_ENTER, ord("\n")]:
            if seleccion == 0:
                curses.endwin()
                subprocess.run(["bash", "scripts/bash/crear_categoria.sh"])
                return
            elif seleccion == 1:
                curses.endwin()
                subprocess.run(["python3", "scripts/python/elegir_marca.py"])
                return
            elif seleccion == 2:
                curses.endwin()
                subprocess.run(["python3", "scripts/python/crear_producto.py"])
                return
            elif seleccion == 3:
                return

# Funciones del menú Buscar
def buscar(terminal):
    opciones = ["Busqueda por descripcion", "Busqueda por codigo", "Volver"]
    seleccion = 0

    while True:
        terminal.clear()
        terminal.addstr("¿Cómo quieres buscar?\n", curses.A_BOLD | curses.A_UNDERLINE)

        for i, opcion in enumerate(opciones):
            if i == seleccion:
                terminal.addstr(f"> {opcion}\n", curses.A_REVERSE)
            else:
                terminal.addstr(f"  {opcion}\n")

        terminal.refresh()
        key = terminal.getch()

        if key == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif key == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif key in [curses.KEY_ENTER, ord("\n")]:
            if seleccion == 0:
                curses.endwin()
                subprocess.run(["bash", "scripts/bash/buscar_descripcion.sh"])
                return
            elif seleccion == 1:
                curses.endwin()
                subprocess.run(["bash", "scripts/bash/buscar_codigo.sh"])
                return
            elif seleccion == 2:
                return

# Función para confirmar salida
def confirmar_salida(terminal):
    opciones = ["No", "Sí"]
    seleccion = 0

    while True:
        terminal.clear()
        terminal.addstr("¿Deseas salir?\n", curses.A_BOLD | curses.A_UNDERLINE)

        for i, opcion in enumerate(opciones):
            if i == seleccion:
                terminal.addstr(f"> {opcion}\n", curses.A_REVERSE)
            else:
                terminal.addstr(f"  {opcion}\n")

        terminal.refresh()
        key = terminal.getch()

        if key == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif key == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif key in [curses.KEY_ENTER, ord("\n")]:
            return seleccion == 1  # True si "Sí"

# Menú principal
def menu(terminal):
    opciones = ["Crear", "Buscar", "Salir"]
    seleccion = 0

    while True:
        terminal.clear()
        terminal.addstr("Menu de Opciones\n", curses.A_BOLD | curses.A_UNDERLINE)

        for i, opcion in enumerate(opciones):
            if i == seleccion:
                terminal.addstr(f"> {opcion}\n", curses.A_REVERSE)
            else:
                terminal.addstr(f"  {opcion}\n")

        terminal.refresh()
        key = terminal.getch()

        if key == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif key == curses.KEY_DOWN and seleccion < len(opciones) - 1:
            seleccion += 1
        elif key in [curses.KEY_ENTER, ord("\n")]:
            if seleccion == 0:
                crear(terminal)
            elif seleccion == 1:
                buscar(terminal)
            elif seleccion == 2:
                if confirmar_salida(terminal):
                    escribir_log("SESION", "Fin del programa")
                    break

# Inicio del programa
if __name__ == "__main__":
    escribir_log("SESION", "Inicio del programa")

    terminal = curses.initscr()
    terminal.keypad(True)
    curses.noecho()
    curses.cbreak()
    curses.curs_set(0)

    try:
        menu(terminal)
    finally:
        curses.nocbreak()
        terminal.keypad(False)
        curses.echo()
        curses.endwin()