import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import Qt.labs.platform 1.1


//  Main window
ApplicationWindow
{
    property string path: ""
    property bool saved: true
    property variant win

    id: root
    visible: true
    title: "PRO000  |   Simple Text Editor"

    minimumWidth: 768
    minimumHeight: 432





    ColumnLayout
    {
        anchors.fill: parent


        //  Toolbar
        RowLayout
        {
            Layout.topMargin: 10
            Layout.leftMargin: 5

            Repeater
            {
                id: btns
                model: ["New", "Open", "Save", "Save As"]


                Button
                {
                    implicitWidth: 80
                    implicitHeight: 35

                    text: btns.model[index]
                    onClicked: toolButtonClickHandler(btns.model[index])
                }
            }


            Item { Layout.fillWidth: true }


            //  Preferences button
            Button
            {
                implicitWidth: 100
                implicitHeight: 35
                Layout.rightMargin: 5

                text: "Preferences"

                onClicked: openPreferences()
            }
        }





        //  Main text area
        ScrollView
        {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 5

            ScrollBar.vertical.policy: Qt.ScrollBarAlwaysOn
            clip: true



            TextArea
            {
                id: textArea

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.margins: 5

                selectByMouse: true
                wrapMode: TextEdit.Wrap


                background: Rectangle
                { color: "#CACACA" }
            }

        }
    }







    //  File dialog that enables file opening and saving
    FileDialog
    {
        property int mode: 0

        id: fileDialog
        title: "Please choose a file"

        onAccepted:
        {
            path = fileDialog.file.toString().replace("file://", "");
            fileHandler(mode);
            this.close();
        }

        onRejected: this.close();
    }






    //  Handle button clicks
    function toolButtonClickHandler(option)
    {
        switch(option)
        {
            case "New":
                path = "";
                fileDialog.mode = 0;
                textArea.clear();
                break;



            case "Open":
                fileDialog.mode = 0;
                fileDialog.title = "Open"
                fileDialog.fileMode = FileDialog.OpenFile;
                fileDialog.open();
                break;



            //  If a file is loaded, directly save to that file
            //  Otherwise open file dialog and let user choose save path
            case "Save":
                if (path.Length > 0)
                    fileHandler(1);
                else
                {
                    fileDialog.mode = 1;
                    fileDialog.title = "Save";
                    fileDialog.fileMode = FileDialog.SaveFile;
                    fileDialog.open();
                }
                break;




            case "Save As":
                fileDialog.mode = 1;
                fileDialog.title = "Save As";
                fileDialog.fileMode = FileDialog.SaveFile;
                fileDialog.open();
                break;
        }
    }





    //  Emit signal to main.py
    function fileHandler(mode)
    {
        if (mode == 0)
            textArea.text = manager.load(path);
        else if (mode == 1)
            manager.save(path, textArea.text);
    }






    //  Trigger preference window
    function openPreferences()
    {
        //  Only open new window when there is no existing preference window
        //  New preference window object will be instantiated
        if (win == null)
        {
            var component = Qt.createComponent("/mnt/Data/Projects/PRJ000-Simple-Text-Editor/proj/preferences.qml");
            win = component.createObject(root);
            win.show();
        }
    }

}