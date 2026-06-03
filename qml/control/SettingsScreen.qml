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

            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 40 * kgScaling

                Column {
                    anchors.left: parent.left
                    anchors.right: proxyEnabledToggle.left
                    anchors.rightMargin: 8 * kgScaling
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2 * kgScaling

                    Text {
                        text: "Use Proxy"
                        font.bold: true
                        font.pixelSize: 13 * kgScaling
                    }

                    Text {
                        text: "Configure HTTP or SOCKS5 proxy server"
                        font.pixelSize: 11 * kgScaling
                        color: "gray"
                    }
                }

                ToggleSwitch {
                    id: proxyEnabledToggle
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    checked: platformUtils.proxyEnabled

                    onToggled: {
                        platformUtils.proxyEnabled = newValue;
                    }
                }
            }

            Column {
                id: proxyDetailsBox
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 12 * kgScaling
                visible: proxyEnabledToggle.checked

                Text {
                    text: "Proxy Type"
                    font.bold: true
                    font.pixelSize: 12 * kgScaling
                    color: "dimgray"
                }

                Row {
                    id: proxyTypeSelector
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 8 * kgScaling
                    height: 32 * kgScaling

                    property string selectedType: platformUtils.proxyType // "socks5" or "http"

                    Rectangle {
                        width: (parent.width - 8 * kgScaling) / 2
                        height: parent.height
                        radius: 4 * kgScaling
                        color: parent.selectedType == "socks5" ? globalAccent : "lightgrey"

                        Text {
                            anchors.centerIn: parent
                            text: "SOCKS5"
                            color: parent.parent.selectedType == "socks5" ? "white" : "black"
                            font.bold: true
                            font.pixelSize: 12 * kgScaling
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                proxyTypeSelector.selectedType = "socks5";
                                platformUtils.proxyType = "socks5";
                            }
                        }
                    }

                    Rectangle {
                        width: (parent.width - 8 * kgScaling) / 2
                        height: parent.height
                        radius: 4 * kgScaling
                        color: parent.selectedType == "http" ? globalAccent : "lightgrey"

                        Text {
                            anchors.centerIn: parent
                            text: "HTTP"
                            color: parent.parent.selectedType == "http" ? "white" : "black"
                            font.bold: true
                            font.pixelSize: 12 * kgScaling
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                proxyTypeSelector.selectedType = "http";
                                platformUtils.proxyType = "http";
                            }
                        }
                    }
                }

                Column {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 4 * kgScaling

                    Text {
                        text: "Host"
                        font.bold: true
                        font.pixelSize: 11 * kgScaling
                        color: "dimgray"
                    }

                    LineEdit {
                        id: proxyHostInput
                        anchors.left: parent.left
                        anchors.right: parent.right

                        onTextChanged: {
                            platformUtils.proxyHost = text;
                        }
                    }
                }

                Column {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 4 * kgScaling

                    Text {
                        text: "Port"
                        font.bold: true
                        font.pixelSize: 11 * kgScaling
                        color: "dimgray"
                    }

                    LineEdit {
                        id: proxyPortInput
                        anchors.left: parent.left
                        anchors.right: parent.right

                        onTextChanged: {
                            platformUtils.proxyPort = parseInt(text) || 1080;
                        }
                    }
                }

                Column {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 4 * kgScaling

                    Text {
                        text: "Username (optional)"
                        font.bold: true
                        font.pixelSize: 11 * kgScaling
                        color: "dimgray"
                    }

                    LineEdit {
                        id: proxyUserInput
                        anchors.left: parent.left
                        anchors.right: parent.right

                        onTextChanged: {
                            platformUtils.proxyUser = text;
                        }
                    }
                }

                Column {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 4 * kgScaling

                    Text {
                        text: "Password (optional)"
                        font.bold: true
                        font.pixelSize: 11 * kgScaling
                        color: "dimgray"
                    }

                    LineEdit {
                        id: proxyPasswordInput
                        anchors.left: parent.left
                        anchors.right: parent.right

                        onTextChanged: {
                            platformUtils.proxyPassword = text;
                        }
                    }
                }

                Button {
                    id: restartConnectionButton
                    anchors.left: parent.left
                    anchors.right: parent.right
                    text: "Restart Connection"

                    onClicked: {
                        telegramClient.stop();
                        telegramClient.start();
                        snackBar.text = "Connection restarted";
                    }
                }
            }

            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 4 * kgScaling

                Text {
                    text: "Cache Directory"
                    font.bold: true
                    font.pixelSize: 13 * kgScaling
                }

                Text {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    text: "Leave empty for default location. Takes effect after app restart."
                    font.pixelSize: 11 * kgScaling
                    color: "gray"
                    wrapMode: Text.Wrap
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 8 * kgScaling

                    LineEdit {
                        id: cacheDirInput
                        width: parent.width - browseButton.width - parent.spacing

                        onTextChanged: {
                            platformUtils.cacheDir = text;
                        }
                    }

                    Button {
                        id: browseButton
                        text: "Browse"

                        onClicked: {
                            var dir = platformUtils.selectFolder("Select Cache Directory", cacheDirInput.text);
                            if (dir !== "") {
                                cacheDirInput.text = dir;
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        proxyHostInput.text = platformUtils.proxyHost;
        proxyPortInput.text = platformUtils.proxyPort.toString();
        proxyUserInput.text = platformUtils.proxyUser;
        proxyPasswordInput.text = platformUtils.proxyPassword;
        cacheDirInput.text = platformUtils.cacheDir;
    }
}
