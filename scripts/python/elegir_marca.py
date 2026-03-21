import curses
import os
import subprocess

# Función para listar subdirectorios
def listar_subdirectorios(ruta):
    return [d for d in os.listdir(ruta) if os.path.isdir(os.path.join(ruta, d))]

# Función principal con curses
def main(stdscr):
    ruta_padre = "/tiendas/ElVestidor"
    subdirs = listar_subdirectorios(ruta_padre)
    seleccion = 0

    while True:
        stdscr.clear()
        stdscr.addstr("Elige la categoria donde quieres crear una nueva marca: \n\n")
        for i, d in enumerate(subdirs):
            if i == seleccion:
                stdscr.addstr(f"> {d}\n", curses.A_REVERSE)
            else:
                stdscr.addstr(f"  {d}\n")
        stdscr.addstr("\nUsa ↑↓ para moverte y Enter para seleccionar.")

        key = stdscr.getch()
        if key == curses.KEY_UP and seleccion > 0:
            seleccion -= 1
        elif key == curses.KEY_DOWN and seleccion < len(subdirs) - 1:
            seleccion += 1
        elif key == 10:  # Enter
            categoria = subdirs[seleccion]  # ← SOLO el nombre
            curses.endwin()
            subprocess.run(["bash", "/home/ciruelos/programa/scripts/bash/crear_marca.sh", categoria])
            break

curses.wrapper(main)