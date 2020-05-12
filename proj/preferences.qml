import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14


//  Preference window
Window
{
    id: pref

    property variant isDarkTheme: false
    property variant displayFontSize: 12

    minimumWidth: 300
    minimumHeight: 250
    maximumWidth: 300
    maximumHeight: 250

    visible: true
    title: "Preferences"

    color: isDarkTheme ? "#242424" : "white"


    ColumnLayout
    {
        anchors.fill: parent


        ColumnLayout
        {
            Layout.topMargin: 20


            //  Theme selection
            RowLayout
            {
                Label
                {
                    Layout.leftMargin: 15
                    text: "Theme"
                    color: isDarkTheme ? "white" : "black"
                }

                Item { Layout.fillWidth: true }

                ComboBox
                {
                    id: themeSelector
                    Layout.rightMargin: 10

                    model: ListModel
                    {
                        ListElement { text: "Light"}
                        ListElement { text: "Dark"}
                    }


                    onActivated: isDarkTheme = !(index == 0);
                }
            }




            //  Display font size
            RowLayout
            {
                Label
                {
                    Layout.leftMargin: 15
                    text: "Display Font Size"
                    color: isDarkTheme ? "white" : "black"
                }

                Item { Layout.fillWidth: true }

                ComboBox
                {
                    id: displayFontSizeSelector
                    Layout.rightMargin: 10

                    model: ListModel
                    {
                        ListElement { text: "Small" }
                        ListElement { text: "Normal" }
                        ListElement { text: "Large" }
                        ListElement { text: "Huge" }
                    }


                    onActivated:
                    {
                        if(index == 0)
                            displayFontSize = 10;
                        else if (index == 1)
                            displayFontSize = 12;
                        else if (index == 2)
                            displayFontSize = 16;
                        else if (index == 3)
                            displayFontSize = 24;
                    }
                }
            }
        }





        //  Bottom buttons
        RowLayout
        {
            Layout.margins: 5

            Item { Layout.fillWidth: true }

            Button
            {
                implicitWidth: 100
                implicitHeight: 35

                contentItem: Text
                {
                    text: "OK";
                    color: isDarkTheme ? "white" : "black"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle { color: isDarkTheme ? "#303030" : "#EAEAEA" }

                onClicked:
                {
                    root.isDarkTheme = pref.isDarkTheme;
                    root.displayFontSize = pref.displayFontSize;
                    manager.savePreferences(root.isDarkTheme, root.displayFontSize)
                    pref.close();
                }
            }

            Button
            {
                implicitWidth: 100
                implicitHeight: 35

                contentItem: Text
                {
                    text: "Cancel";
                    color: isDarkTheme ? "white" : "black"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle { color: isDarkTheme ? "#303030" : "#EAEAEA" }

                onClicked: pref.close();
            }
        }
    }



    //  Initialization
    //  Set position and hide root window when self is ready
    Component.onCompleted:
    {
        x = root.x + root.width / 2 - pref.width / 2;
        y = root.y + root.height / 2 - pref.height / 2;
        root.hide();


        pref.isDarkTheme = root.isDarkTheme;
        pref.displayFontSize = root.displayFontSize;



        //  Set combo box values

        if (isDarkTheme) themeSelector.currentIndex = 1;
        else themeSelector.currentIndex = 0;

        if (displayFontSize == 10)
            displayFontSizeSelector.currentIndex = 0;
        else if (displayFontSize == 12)
            displayFontSizeSelector.currentIndex = 1;
        else if (displayFontSize == 16)
            displayFontSizeSelector.currentIndex = 2;
        else if (displayFontSize == 24)
            displayFontSizeSelector.currentIndex = 3;
    }




    //  Clear root reference when closing
    onClosing: { root.preferences_dialog = null; root.show(); }
}