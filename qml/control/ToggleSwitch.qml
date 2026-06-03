import QtQuick 1.0

Item {
    id: toggleRoot
    width: 36 * kgScaling
    height: 20 * kgScaling

    property bool checked: false
    signal toggled(bool newValue)

    Rectangle {
        id: bgRect
        anchors.fill: parent
        radius: height / 2
        color: checked ? globalAccent : "silver"

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }

    Rectangle {
        id: knob
        width: 16 * kgScaling
        height: 16 * kgScaling
        radius: width / 2
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        x: checked ? (parent.width - width - 2 * kgScaling) : 2 * kgScaling

        Behavior on x {
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            checked = !checked;
            toggleRoot.toggled(checked);
        }
    }
}
