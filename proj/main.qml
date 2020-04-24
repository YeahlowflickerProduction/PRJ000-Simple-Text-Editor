import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick.Dialogs 1.3


ApplicationWindow
{
    property var path: "/home/yeahlowflicker/Desktop/text.yf"

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
        }



        TextArea
        {
            id: textArea

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 5

            selectByMouse: true
            wrapMode: TextEdit.Wrap


            background: Rectangle
            {
                color: "#CACACA"
            }
        }
    }




    function toolButtonClickHandler(option)
    {
        switch(option)
        {
            case "New":
                textArea.clear();
                break;

            case "Open":
                textArea.text = manager.load(path);
                break;

            case "Save":
                openDialog();
                //manager.save(path, textArea.text);
                break;
        }
    }





    FileDialog
    {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted:
        {
            console.log("You chose: " + fileDialog.fileUrls);
            this.close();
        }

        onRejected:
        {
            console.log("Canceled")
            this.close();
        }
        Component.onCompleted: visible = true
    }


    function openDialog()
    { fileDialog.open(); }
}