
import sys
from PySide2 import QtCore as qtc, QtWidgets as qtw, QtGui as qtgui, QtQml as qtqml
from main import Main



if __name__ == "__main__":

    #   Set attributes
    qtw.QApplication.setAttribute(qtc.Qt.AA_EnableHighDpiScaling)
    qtc.QCoreApplication.setAttribute(qtc.Qt.AA_UseHighDpiPixmaps)

    #   Define application
    app = qtw.QApplication(sys.argv)
    app.setOrganizationName("Yeahlowflicker Production")

    #   Define engine
    engine = qtqml.QQmlApplicationEngine()
    manager = Main(engine)
    engine.load(qtc.QUrl("/mnt/YFP/Projects/PRJ000-Simple-Text-Editor/proj/main.qml"))


    #   Exit handler
    sys.exit(app.exec_())
