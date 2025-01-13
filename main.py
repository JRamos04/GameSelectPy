# This Python file uses the following encoding: utf-8
import sys
from App.DBConnection import *
from App.GeminiQueries import *

from PySide6.QtQml import QQmlApplicationEngine
from PySide6 import QtCore
from PySide6.QtCore import QObject, Signal, Property, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuickControls2 import QQuickStyle

class Backend(QObject):
    textChanged = Signal()

    def __init__(self, parent=None):
        QObject.__init__(self, parent)
        self._texto = ""

    @QtCore.Slot(str)    
    def runQuery(self, query):
        result = runQuery(query)
        if (result.__len__() == 58):
            resultFormatted = result
        else:
            resultFormatted = formatGameInfo(result)
        self._texto = resultFormatted
        self.textChanged.emit()
        
    @QtCore.Slot(str) 
    def runQueryAI(self, request):
        query = makeQueryAI(request)
        result = runQuery(query)
        resultFormatted = formatGameInfo(result)
        self._texto = resultFormatted
        self.textChanged.emit()


    @Property(str, notify=textChanged)    
    def texto(self):
        return self._texto
    
    
if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    backend = Backend()
    QQuickStyle.setStyle('Basic')

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("backend", backend)
    engine.load(QUrl.fromLocalFile('./App/Main.qml'))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
