
from PySide2 import QtCore as qtc, QtWidgets as qtw, QtGui as qtgui, QtQml as qtqml
import lib


class Main(qtc.QObject):

    prefPath = "/mnt/YFP/Projects/PRJ000-Simple-Text-Editor/proj/preferences.yf"

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



    #   Load and return application preferences
    @qtc.Slot(result="QVariantList")
    def loadPreferences(self):
        from os import path
        if path.exists(self.prefPath):
            return list(lib.loadObject(self.prefPath))
        else:
            self.savePreferences(False, 12)
            return False, 12



    #   Save application preferences to file
    @qtc.Slot(bool, int)
    def savePreferences(self, isDarkTheme, displayFontSize):
        lib.saveObject(self.prefPath, isDarkTheme, displayFontSize)
