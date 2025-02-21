import QtQuick 1.0

Item {
    width: 240
    height: 40 * kgScaling

    function openDialog() {
        messagePage.messagesModel.peer = peerBytes;
        messagePage.messageEdit.peer = peerBytes;
        topBar.peerTitle = title;
        topBar.peerThumbnailColor = thumbnailColor;
        topBar.peerThumbnailText = thumbnailText;
        topBar.peerAvatar = avatar;
        topBar.peerTooltip = tooltip;
        stack.currentIndex = 1;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            openDialog();
        }
    }

    property string avatarWatcher: avatar
    onAvatarWatcherChanged: {
        if (messagePage.messagesModel.peer == peerBytes) {
            topBar.peerAvatar = avatar;
        }
    }

    Rectangle {
        id: avatarRect
        visible: avatar.length == 0 || avatarImage.status != Image.Ready

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 5 * kgScaling

        width: 30 * kgScaling
        height: width
        smooth: true

        color: thumbnailColor

        Text {
            anchors.fill: parent
            text: thumbnailText
            color: "#FFFFFF"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Image {
        id: avatarImage
        visible: avatar.length != 0

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: avatarRect.anchors.leftMargin

        width: 30 * kgScaling
        height: width
        smooth: true

        asynchronous: true
        source: avatar
    }

    Column {
        anchors.left: avatarRect.right
        anchors.right: parent.right
        anchors.verticalCenter: avatarRect.verticalCenter
        anchors.leftMargin: avatarRect.anchors.leftMargin
        anchors.rightMargin: anchors.leftMargin

        Row {
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 4 * kgScaling

            Text {
                elide: Text.ElideRight
                text: title
            }

            Text {
                anchors.bottom: parent.bottom
                text: messageTime
                color: "#999999"
            }
        }

        Text {
            text: messageText
            color: "#8D8D8D"
            anchors.left: parent.left
            anchors.right: parent.right
            elide: Text.ElideRight
            clip: true

            onLinkActivated: {
                openDialog();
            }
        }
    }

    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#EEEEEE"
    }
}
