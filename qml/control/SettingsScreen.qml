import QtQuick 1.0

Item {
    id: settingsScreenRoot

    signal backRequested()

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    Item {
        id: settingsTopBar
        height: 40 * kgScaling
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        z: 10

        Rectangle {
            anchors.fill: parent
            color: globalAccent
        }

        Rectangle {
            height: 1 * kgScaling
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: Qt.darker(globalAccent)
        }

        Item {
            id: settingsBackButton
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width: height

            Image {
                anchors.centerIn: parent
                source: "../../img/arrow-left.png"
                width: 20 * kgScaling
                height: width
                smooth: true
                asynchronous: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    settingsScreenRoot.backRequested();
                }
            }
        }

        Text {
            anchors.left: settingsBackButton.right
            anchors.leftMargin: 8 * kgScaling
            anchors.verticalCenter: parent.verticalCenter
            text: "Settings"
            font.bold: true
            font.pixelSize: 14 * kgScaling
            color: "white"
        }
    }

    Flickable {
        id: settingsFlickable
        anchors.top: settingsTopBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        contentWidth: width
        contentHeight: settingsContent.height + 40 * kgScaling
        clip: true
        flickableDirection: Flickable.VerticalFlick

        Column {
            id: settingsContent
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 16 * kgScaling
            spacing: 16 * kgScaling

            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 40 * kgScaling

                Column {
                    anchors.left: parent.left
                    anchors.right: notificationToggle.left
                    anchors.rightMargin: 8 * kgScaling
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2 * kgScaling

                    Text {
                        text: "Notifications"
                        font.bold: true
                        font.pixelSize: 13 * kgScaling
                    }

                    Text {
                        text: "Show notifications for new messages"
                        font.pixelSize: 11 * kgScaling
                        color: "gray"
                    }
                }

                ToggleSwitch {
                    id: notificationToggle
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    checked: platformUtils.notificationsEnabled

                    onToggled: {
                        platformUtils.notificationsEnabled = newValue;
                    }
                }
            }
        }
    }
}
