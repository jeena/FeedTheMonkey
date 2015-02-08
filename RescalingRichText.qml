import QtQuick 2.0
import QtQuick.Controls 1.3

// from: https://github.com/pycage/tidings/blob/master/qml/pages/RescalingRichText.qml

/* Pretty fancy element for displaying rich text fitting the width.
 *
 * Images are scaled down to fit the width, or, technically speaking, the
 * rich text content is actually scaled down so the images fit, while the
 * font size is scaled up to keep the original font size.
 */
Item {
    id: root

    property string text
    property color color
    property real fontSize
    property bool showSource: false
    property real lineHeight: 1

    property real scaling: 1

    property string _style: "<style>" +
                            "a:link { color: gray }" +
                            "</style>"

    signal linkActivated(string link)

    height: contentLabel.sourceComponent !== null ? contentLabel.height * scaling
                                                  : 0
    clip: true

    onWidthChanged: {
        rescaleTimer.restart();
    }

    onTextChanged: {
        rescaleTimer.restart();
    }

    Label {
        id: layoutLabel

        visible: false
        width: parent.width
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        textFormat: Text.RichText

        // tiny font so that only images are relevant
        text: "<style>* { font-size: 1px }</style>" + parent.text

        onContentWidthChanged: {
            // console.log("contentWidth: " + contentWidth);
            rescaleTimer.restart();
        }
    }

    Loader {
        id: contentLabel
        sourceComponent: rescaleTimer.running ? null : labelComponent
    }

    Component {
        id: labelComponent

        Label {
            width: root.width / scaling
            scale: scaling

            transformOrigin: Item.TopLeft
            color: root.color
            font.pixelSize: root.fontSize / scaling
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            textFormat: root.showSource ? Text.PlainText : Text.RichText
            smooth: true
            lineHeight: root.lineHeight * scaling

            text: _style + root.text

            onLinkActivated: {
                root.linkActivated(link);
            }
        }
    }

    Timer {
        id: rescaleTimer
        interval: 100

        onTriggered: {
            var contentWidth = Math.floor(layoutLabel.contentWidth);
            scaling = Math.min(1, parent.width / (layoutLabel.contentWidth + 0.0));
            // console.log("scaling: " + scaling);
        }
    }
}
