import QtQuick 1.0
import Kutegram 1.0

Rectangle {
    property string globalState: "NO_SELECT"
    property alias messagesModel: messagesModel
    property alias messageEdit: messageEdit

    ListView {
        id: messagesView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: messageEdit.top

        //TODO remove this hack
        //I don't know why, but content overlaps MessageEdit at the bottom
        anchors.bottomMargin: 5

        spacing: 4

        onMovementEnded: {
            if (atYBeginning && messagesModel.canFetchMoreUpwards()) {
                messagesModel.fetchMoreUpwards();
            }
        }

        model: MessagesModel {
            id: messagesModel
            client: telegramClient
            avatarDownloader: globalAvatarDownloader

            onScrollTo: {
                messagesView.positionViewAtIndex(index, ListView.Beginning);
            }
        }

        delegate: MessageItem {
            state: globalState
        }
    }

    //TODO Hide MessageEdit when user is restricted
    MessageEdit {
        id: messageEdit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}
