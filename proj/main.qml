import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import Qt.labs.platform 1.1


//  Main window
ApplicationWindow
{
    property string path: ""
    property bool saved: true
    property variant preferences_dialog
    property variant unsaved_warn
    property int originalCharCount: 0

    property variant isDarkTheme: false
    property variant displayFontSize: 12


    id: root
    visible: true
    title: "PRO000  |   Simple Text Editor"
    color: isDarkTheme ? "#242424" : "white"

    minimumWidth: 768
    minimumHeight: 432


    onClosing:
    {
        if(!saved)
        {
            close.accepted = false;
            triggerUnsavedWarning();
        }
    }


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

                    contentItem: Text
                    {
                        text: btns.model[index];
                        color: isDarkTheme ? "white" : "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle { color: isDarkTheme ? "#303030" : "#EAEAEA" }

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

                contentItem: Text
                {
                    text: "Preferences";
                    color: isDarkTheme ? "white" : "black"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle { color: isDarkTheme ? "#303030" : "#EAEAEA" }

                onClicked: triggerPreferences()
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
                font.pointSize: displayFontSize
                color: isDarkTheme ? "white" : "black"

                background: Rectangle
                { color: isDarkTheme ? "#333333" : "#CACACA" }

                Keys.onPressed: { saved = (textArea.length + 1 == originalCharCount) }
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
                saved = true;
                originalCharCount = 0;
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
                if (path.length > 0)
                {
                    fileHandler(1);
                    saved = true;
                }
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

        originalCharCount = textArea.length;
        saved = true;
    }






    //  Trigger preference window
    function triggerPreferences()
    {
        //  Only open new window when there is no existing preference window
        //  New preference window object will be instantiated
        //  Self will be hidden
        if (preferences_dialog == null)
        {
            var component = Qt.createComponent("/mnt/Data/Projects/PRJ000-Simple-Text-Editor/proj/preferences.qml");
            preferences_dialog = component.createObject(root);
            preferences_dialog.show();
            preferences_dialog.raise();
        }
    }



    //  Trigger unsaved warning
    //  Similar to openPreferences
    function triggerUnsavedWarning()
    {
        if (unsaved_warn == null)
        {
            var component = Qt.createComponent("/mnt/Data/Projects/PRJ000-Simple-Text-Editor/proj/unsavedWarning.qml");
            unsaved_warn = component.createObject(root);
            unsaved_warn.show();
            unsaved_warn.raise();
        }
    }




    //  Initialization
    //  Retrieve and apply stored preference values
    Component.onCompleted:
    {
        var data = manager.loadPreferences();
        isDarkTheme = data[0];
        displayFontSize = data[1];
    }
}