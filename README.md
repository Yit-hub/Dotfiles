
Neovim plugins:
colorizer
lazygit


Que notes una demora entre la pantalla de ASUS y la aparición del GRUB no es raro, especialmente en portátiles con UEFI. Vamos a repasar las posibles causas y soluciones para optimizar ese arranque.

---

### 🔍 Posibles causas del retraso

1. **Firmware (UEFI) lento o en modo "fast boot" desactivado**
   Algunos firmwares hacen una comprobación completa del hardware antes de lanzar el gestor de arranque si no está activado el "Fast Boot".

2. **Timeout o configuración lenta en GRUB**
   GRUB puede estar esperando innecesariamente si su configuración no está optimizada.

3. **Orden de arranque incorrecta en la BIOS/UEFI**
   Si la UEFI está intentando arrancar primero otros dispositivos (USB, red, etc.), puede haber una demora.

4. **Problemas con `os-prober` o detección de otros sistemas**
   GRUB puede estar buscando todos los discos cada vez que arranca si no se ha desactivado `os-prober` correctamente.

5. **Controladores o firmware lentos en la detección del disco o NVMe**
   Si tu disco es NVMe, algunos kernels o firmwares pueden tener un pequeño retardo inicial.

---

### ✅ Soluciones posibles

#### 1. **Revisa el orden de arranque en la BIOS/UEFI**

* Entra en la BIOS (usualmente `F2`, `DEL` o `ESC` al encender el portátil).
* Asegúrate de que el disco con GRUB esté primero.
* Desactiva arranque por red, USB, PXE si no los usas.

#### 2. **Habilita Fast Boot (con precaución)**

* Si tienes dual boot, actívalo solo si no te impide usar Linux.
* A veces Fast Boot omite la detección de discos externos, así que pruébalo y verifica que Arch se sigue cargando bien.

#### 3. **Optimiza el GRUB**

Edita el archivo `/etc/default/grub` en Arch:

```bash
sudo nano /etc/default/grub
```

Ajusta estas líneas:

```ini
GRUB_TIMEOUT=2
GRUB_DISABLE_OS_PROBER=true
GRUB_HIDDEN_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT_QUIET=true
```

Luego ejecuta:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

> ⚠️ **Si necesitas que detecte Windows, mantén `os-prober` activado.** Pero si ya lo tienes en el menú y no necesitas re-detectarlo en cada reinicio, puedes desactivarlo.

#### 4. **Activa el modo verbose para depurar el arranque**

Edita GRUB para mostrar mensajes de arranque si quieres saber qué hace durante esa pausa:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
```

Puedes quitar `"quiet"` temporalmente y dejarlo como:

```bash
GRUB_CMDLINE_LINUX_DEFAULT=""
```

Eso te mostrará mensajes del kernel al arrancar, útiles para ver si el retraso es por el kernel o antes.

---

### 🧪 Test adicional

Si quieres confirmar si es GRUB o el firmware lo que está tardando:

1. Apaga completamente el portátil.
2. Enciende y entra rápido en la BIOS/UEFI.
3. Mide el tiempo entre el logo de ASUS y que puedas navegar en la BIOS.

> Si ya tarda bastante aquí, entonces el problema es del firmware, no de GRUB.

---

¿Quieres que te ayude a revisar el contenido de tu `grub.cfg` o los logs de arranque (`dmesg`, `journalctl`)? También podrías activar el "Bootchart" para analizar tiempos.

Puedo guiarte paso a paso según el nivel de detalle que quieras.
