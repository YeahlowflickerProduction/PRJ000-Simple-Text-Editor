
import sys
from PySide2 import QtCore as qtc, QtWidgets as qtw, QtGui as qtgui, QtQml as qtqml
from main import Main



if __name__ == "__main__":

    #   Set attributes
    qtw.QApplication.setAttribute(qtc.Qt.AA_EnableHighDpiScaling)
    qtc.QCoreApplication.setAttribute(qtc.Qt.AA_UseHighDpiPixmaps)

    #   Define application
    app = qtw.QApplication(sys.argv)

    #   Define engine
    engine = qtqml.QQmlApplicationEngine()
    engine.load(qtc.QUrl("/mnt/Data/Projects/PRJ000-Simple-Text-Editor/proj/main.qml"))

    #   Define manager
    manager = Main(engine)

    #   Exit handler
    sys.exit(app.exec_())
