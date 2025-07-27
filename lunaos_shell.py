import sys
import keyboard
from PyQt6 import QtWidgets, QtCore


class ShellWindow(QtWidgets.QMainWindow):
    """Simple full-screen shell window."""

    def __init__(self):
        super().__init__()
        self.init_ui()

    def init_ui(self):
        self.setWindowFlags(
            QtCore.Qt.WindowType.FramelessWindowHint
            | QtCore.Qt.WindowType.WindowStaysOnTopHint
        )
        self.showFullScreen()
        label = QtWidgets.QLabel("LunaOS Shell", self)
        label.setAlignment(QtCore.Qt.AlignmentFlag.AlignCenter)
        self.setCentralWidget(label)


def block_shortcuts():
    """Block common system shortcuts to keep the shell in focus."""
    # Block Windows keys
    for key in ("left windows", "right windows"):
        try:
            keyboard.block_key(key)
        except Exception as err:  # pragma: no cover - best effort
            print(f"Cannot block {key}: {err}")

    # Block other combinations
    combos = ["alt+tab", "alt+f4", "ctrl+esc"]
    for combo in combos:
        try:
            keyboard.add_hotkey(combo, lambda: None, suppress=True)
        except Exception as err:  # pragma: no cover - best effort
            print(f"Cannot block {combo}: {err}")

    # Ctrl+Alt+Del cannot be blocked from user space on Windows


def main():
    app = QtWidgets.QApplication(sys.argv)
    block_shortcuts()
    window = ShellWindow()
    window.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
