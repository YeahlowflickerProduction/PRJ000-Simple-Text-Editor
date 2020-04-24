
from PySide2 import QtCore as qtc, QtWidgets as qtw, QtGui as qtgui, QtQml as qtqml
import lib


class Main(qtc.QObject):

    engine = None

    def __init__(self, engine):
        super().__init__()
        self.engine = engine
        engine.rootContext().setContextProperty("manager", self)


    @qtc.Slot(str, str)
    def save(self, path, content):
        lib.saveText(path, content)


    @qtc.Slot(str, result=str)
    def load(self, path):
        ctn = lib.loadText(path)
        return ctn
