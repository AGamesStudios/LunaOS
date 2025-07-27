# LunaOS

This repository contains an experimental shell for Windows written in Python. It shows
how to create a fullscreen PyQt6 application that blocks some common system
shortcuts.

## Running

Install the dependencies and run `lunaos_shell.py`:

```bash
pip install PyQt6 keyboard
python lunaos_shell.py
```

Note that some shortcuts like `Ctrl+Alt+Del` cannot be blocked from user space.
