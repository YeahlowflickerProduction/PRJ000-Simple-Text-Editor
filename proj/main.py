
from PySide2 import QtCore as qtc, QtWidgets as qtw, QtGui as qtgui, QtQml as qtqml
import lib


class Main(qtc.QObject):

    engine = None

    #   Initialization
    def __init__(self, engine):
        super().__init__()
        self.engine = engine

        #   Add QML reference of self
        engine.rootContext().setContextProperty("manager", self)




    #   Handle QML signal and trigger save
    @qtc.Slot(str, str)
    def save(self, path, content):
        lib.saveText(path, content)


    #   Handle QML signal, load content from file, and return content to QML
    @qtc.Slot(str, result=str)
    def load(self, path):
        ctn = lib.loadText(path)
        return ctn
