import QtQuick


Column{
    property var dateTime: new Date()
    property bool timerEnabled: true
    property string formattedDate: dateTime.toLocaleDateString(Qt.locale(), "yyyy/MM/dd dddd") // Qt.formatDateTime(date, "yyyy/MM/dd dddd")
    property string timeStr: dateTime.toLocaleTimeString(Qt.locale(), "HH:mm") // Qt.formatDateTime(date, "hh:mm")
    property string location: "武汉市精神卫生中心六角亭院区·精神科监护病区"
    id:col
    rotation: isLandscape ? 90 : 0
    transformOrigin: Item.BottomLeft
    x: 0
    y: isLandscape ? -height : parent.height - height
    // Component.onCompleted: Qt.quit()
    Text {
        id:timeText
        text:timeStr
        font.bold: true
        color:"white"
        font.pointSize: 30
    }
    Row {
        spacing: 5
        Rectangle {
            color:"#20B7FC"
            width: 2
            height: label.contentHeight -5
            anchors.verticalCenter: label.verticalCenter
        }
        Text {
            id:label
            wrapMode: "WrapAnywhere"
            text:formattedDate+"\n" + location
            color:"white"
            font.pointSize: 10
        }
        Timer {
            running: timerEnabled
            repeat: true
            interval: 60000
            triggeredOnStart: true
            onTriggered: {
                dateTime = new Date()
            }
        }
    }
    Row {
        spacing: 5
        Image {
            // width: label1.height
            fillMode: "PreserveAspectFit"
            height: label1.height
            source:"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC0AAAA4CAMAAABe34GAAAAApVBMVEUAAAD///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+4/eNVAAAANnRSTlMArQTm+QjI4poZu27zzrKvoH1nUCAV6NzW06aRhHpiXUU8Lg63dEA6KSbsw4xYVDIRiU02tqilkRH7AAACJklEQVRIx52V6ZKqMBBGIyCIiIqyCgKCiPuMOrff/9GuCQpmQZk5fyzbUxTp7nyiv/IdjldccTU5fgvto+ybElOTTN89Cu1eMNYsprb0xsFEaKeBOZCnVOn+3QxSJMQuUQrR65PhKq1s1E4CzUlvMEMfGJ6afvxDn7nFy0t4tGYb6aPaN3x44k437+VMA4rFO9lWgGHcLs9HwHHY8iuiO3ppqCCkl2S649S7EAUjRVHgDfeftcUOy7kP3VDKu61CV5QcpdCdAg2AR1aHB010XjTmWjbLyMh3yQ/f/B5QqK/D/lozz2bsCNEY7+xZPYN6vO32slrDeOJr3tqoxndus4cIc5LhgVHdzRabBEf07KIJMCX6SGiT32ZQEfbxrl9wqRDaeDV1qPDJvQT4wudQBLb3+pILclwAFX+uBfYAN+75jho5LwDoJFZ4e4mH1/Qnc874Da4kY3jbYGah1POat9hXYIlbbAvvHWfjyIxpu2mDy9o5GRhvu9i2GJkkoSqwocQtZhJFJxMT2Wt0Z0PJCS6FQhsydkPJEjogtj2E2T4HrZZVoFM2n6i3YjHsWY8LGrXftAFisYCyJ3QG6HT202kzYWwYFXntSrEMjH0Bhv3gtOtLfXseasAQ4iXl2Wt7EJDiDnXFxPm97yiPSAdstZMcbFFF/OPJFezGuo+6N6T+xCUCbsW0CZiz3X/UUSu7A3HVLeqGShrQlVwBcFBnEijQL7DE5f/9Lxk0N/j/gQAAAABJRU5ErkJggg=="
        }
        Text {
            id:label1
            font.pointSize: 9
            color:"white"
            text:"工作蜂认证时间地点真实"
        }
    }
    DragHandler {
        acceptedButtons: Qt.AllButtons
    }
}

