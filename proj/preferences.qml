import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14


//  Preference window
Window
{
    id: pref

    minimumWidth: 300
    minimumHeight: 400
    maximumWidth: 300
    maximumHeight: 400

    visible: true
    title: "Preferences"


    ColumnLayout
    {
        anchors.fill: parent


        ColumnLayout
        {

        }


        RowLayout
        {
            Layout.margins: 5

            Item { Layout.fillWidth: true }

            Button
            {
                implicitWidth: 100
                implicitHeight: 35
                text: "OK"

                onClicked: pref.close();
            }

            Button
            {
                implicitWidth: 100
                implicitHeight: 35

                text: "Cancel"

                onClicked: pref.close();
            }
        }
    }


    //  Clear root reference when closing
    onClosing: root.win = null;
}