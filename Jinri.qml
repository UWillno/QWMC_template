import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

// 优先使用QtQuick，Controls可能被Style覆盖
// Prefer to use QtQuick, Controls may be overridden by Style

// 软件里的模板为离线的，不会更新，如果有问题，可以去仓库看看有无更新，说不定哪一天我找到了更好的写法
// The templates in the software are offline and won't be updated, so if you have problems, check the repository for updates, and maybe one day I'll find a better way to write them!
// https://github.com/UWillno/QWMC_template
Item {
    id:root
    transformOrigin:Item.TopLeft
    // 需要自定义的属性放这里
    // 虽然也不是不能获取子控件的属性，但你写太多层改得时候麻烦，也费性能
    // Customized properties go here
    // It's not impossible to get the properties of a child control, but it's a pain in the ass to write too many layers and it's also performance intensive.
    property var dateTime: new Date()
    property bool timerEnabled: true
    property string formattedDate: dateTime.toLocaleDateString(Qt.locale(), "yyyy.MM.dd") // Qt.formatDateTime(date, "yyyy/MM/dd dddd")
    property string timeStr: dateTime.toLocaleTimeString(Qt.locale(), "HH:mm") // Qt.formatDateTime(date, "hh:mm")

    // 测试设备为Sony Xperia Ace 屏幕比较小，字体大小需要自行调整
    // 如果你需要换字体 可以使用 FontLoader
    // Tested on Sony Xperia Ace, small screen, font size needs to be adjusted.
    // If you need to change the font you can use the FontLoader.

    //　这是个虚拟自定义位置，我不在这里！
    //　This is a virtual custom location, I'm not here!
    property string workSpcae: "武汉市精神卫生中心(六角亭院区)"
    property string workContent: "吃饭睡觉"
    property string location: "武汉市精神卫生中心(六角亭院区)"
    property real pointSize: 14
    // 自带osm其实可以请求中国地址，但是容易被墙，你可能需要使用网络代理，而且我觉得应该不太需要这个功能？
    // 可以通过其它api来请求地址名称 直接使用xmlhttprequest
    // The included osm can actually request a Chinese address, but it's easily walled, you'll probably need to use a web proxy, and I don't think it's a feature that should be needed much?
    // You can request the address name through other api's by using xmlhttprequest directly.


    // 可以直接使用的参数
    // Parameters that can be used directly
    // orientation 方向 int
    // qtVersion qt版本 string
    // buildTime 编译时间 string
    // qtCopyright Qt版权 string
    // appName app名称 string
    // orgName 组织名称 string
    // orgDomain 组织域名 string
    // locationEnabled 是否启动位置 bool
    // coordinate 位置坐标 coordinate .toString() .latitude .longitude ……
    // osmEnabled 是否启用osm bool
    // osmAddress osm返回的地址 Address .text .city .street .country……
    // BRAND 品牌 string
    // DEVICE 设备 string
    // BOARD 主板 string



    // 不需要可以放子控件 避免属性被误改
    // You can put subcontrols if you don't need them, to avoid misplaced properties.

    // QOrientationReading::Undefined     0     The Orientation is unknown.
    // 未知 传感器未启动？ Sensor not activated?
    // QOrientationReading::TopUp   1     The Top edge of the device is pointing up.
    // 顶部在上
    // QOrientationReading::TopDown 2     The Top edge of the device is pointing down.
    // 顶部在下
    // QOrientationReading::LeftUp  3     The Left edge of the device is pointing up.
    // 左边缘在上
    // QOrientationReading::RightUp 4     The Right edge of the device is pointing up.
    // 右边缘在上
    // QOrientationReading::FaceUp  5     The Face of the device is pointing up.
    // 面向上
    // QOrientationReading::FaceDown      6     The Face of the device is pointing down.
    // 面向下

    // 个人认为只需要处理 1 3 4默认竖屏
    // Personally, I think it just needs to be handled 1 3 4 default vertical screen
    property int ori: orientation

    anchors.fill: parent
    anchors.margins: 5

    // It's not recommended to use the state when to bind orientations because a lot of orientations are easy to trigger, you switch back and it triggers again, and it's not convenient to adjust the position.
    // Unless you calculate the position without changing it (it is recommended not to use coordinates, just use anchors) you can also save the changed position ......
    // 不建议使用状态when绑定orientation 因为很多orientation触发容易，你切换回来又会触发一次，不方便调整位置
    // 除非你计算好位置不改动(建议不用坐标，直接用锚点) 你也可以存改动后的位置……
    function xyCal(){
        switch(ori){
        case 1:{
            leftItem.x=0
            leftItem.y=root.height - leftItem.height
            leftItem.rotation = 0
            rightItem.rotation = 0
            rightItem.x = root.width - rightItem.width
            rightItem.y = root.height - rightItem.height
            break
        }
        case 4:{
            leftItem.x=0
            leftItem.y=-leftItem.height
            leftItem.rotation = 90
            rightItem.x = - rightItem.width
            rightItem.y = root.height - rightItem.height
            rightItem.rotation = 90
            break
        }
        case 3:{
            leftItem.x= root.width
            leftItem.y= root.height - leftItem.height
            leftItem.rotation = -90
            rightItem.x = root.width - rightItem.width
            rightItem.y = -rightItem.height
            rightItem.rotation = -90
            break
        }
        }
    }
    // osmAddress.text sting  xxxx,xxxx,xxxx,xxx
    function firstAddress(str){
        var index = str.indexOf(",")
        return index >= 0 ? str.substring(0, index) : str
    }
    onOriChanged: { xyCal() }
    // 需要小窗/分屏使用就重新计算
    // Recalculate if you need small windows/split screens
    onHeightChanged:xyCal()
    onWidthChanged: xyCal()

    // 如果想省事不写qml 可以直接用Text 富文本或Markdown
    // If you want to save yourself the trouble of not writing qml, you can just use Text, Rich Text or Markdown.

    // left watermark location time and such ......
    // 左水印 位置时间之类的……

    Rectangle {
        color:"white"
        radius:10
        width: leftItem.width
        height: leftItem.height
        x:leftItem.x
        y:leftItem.y
        z:-1
        opacity: 0.5
        transformOrigin: Item.BottomLeft
        rotation:leftItem.rotation
    }

    ColumnLayout {
        // opacity: 0.9
        width: parent.width * 0.6
        id:leftItem
        transformOrigin: Item.BottomLeft
        x:0
        y:root.height - height
        spacing: 5

        Text {
            text: "日常工作巡查"
            Layout.fillWidth: true
            horizontalAlignment: Qt.AlignHCenter
            maximumLineCount: 1
            fontSizeMode: Text.Fit
            font.bold: true
            color:"white"
            font.pointSize: pointSize
            // minimumPointSize: 20
            padding: 5
            elide: Text.ElideRight
            Rectangle{
                z:-1
                color:"#0066ff"
                width: parent.width
                height: parent.height
                topLeftRadius: 10
                topRightRadius: 10
                opacity: 0.7
            }
            Rectangle{
                color:"#FFBF00"
                width: 10
                height: 10
                radius: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: 0
            Text {
                text:"工 作 区 域："
                color:"black"
                font.pointSize: pointSize
                padding: 2
                rightPadding: 0
                leftPadding: 5
                Layout.alignment: Qt.AlignTop
            }
            Text {
                text:workSpcae
                color:"black"
                Layout.fillWidth: true
                font.pointSize: pointSize
                padding: 2
                wrapMode: Text.WrapAnywhere
                maximumLineCount: 2
                leftPadding: 0
                Layout.alignment: Qt.AlignTop
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 0
            Text {
                Layout.alignment: Qt.AlignTop
                text:"工 作 内 容："
                color:"black"
                font.pointSize: pointSize
                padding: 2
                rightPadding: 0
                leftPadding: 5
            }
            Text {
                Layout.alignment: Qt.AlignTop
                text: workContent
                color:"black"
                Layout.fillWidth: true
                font.pointSize: pointSize
                padding: 2
                wrapMode: Text.WrapAnywhere
                maximumLineCount: 2
                leftPadding: 0
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 0
            Text {
                Layout.alignment: Qt.AlignTop
                text:"拍 摄 时 间："
                color:"black"
                font.pointSize: pointSize
                padding: 2
                rightPadding: 0
                leftPadding: 5
            }
            Text {
                Layout.alignment: Qt.AlignTop
                text:formattedDate +" "+ timeStr
                color:"black"
                Layout.fillWidth: true
                font.pointSize: pointSize
                padding: 2
                wrapMode: Text.WrapAnywhere
                maximumLineCount: 2
                leftPadding: 0
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 0
            Text {
                Layout.alignment: Qt.AlignTop
                text:"地          点："
                color:"black"
                font.pointSize: pointSize
                padding: 2
                rightPadding: 0
                leftPadding: 5
            }
            Text {
                Layout.alignment: Qt.AlignTop
                text:`${osmEnabled && osmAddress!==undefined  ? firstAddress(osmAddress.text) : location}`
                color:"black"
                Layout.fillWidth: true
                font.pointSize: pointSize
                padding: 2
                wrapMode: Text.WrapAnywhere
                maximumLineCount: 2
                leftPadding: 0
            }
        }
        Item {
            // id: name}
            height: 5
        }
        DragHandler {
            acceptedButtons: Qt.AllButtons
        }
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
    // 右水印 一般是logo然后什么真实拍照
    // The right watermark is usually a logo and then something real photographed.
    Column {
        id: rightItem
        x: root.width - width - 2
        y: root.height - height -2
        transformOrigin: Item.BottomRight
        spacing: 5

        width: Math.max(
                   logoLabel.implicitWidth,
                   name.implicitWidth + 4 + verify.implicitWidth
                   // security.implicitWidth
                   )

        Text {
            id: logoLabel
            width: parent.width
            text: "今日水印"
            color: "white"
            font.pointSize: pointSize + 2
            font.bold: true
            font.letterSpacing: 2
            horizontalAlignment: Text.AlignLeft
            style: Text.Outline
            styleColor: "#66000000"
        }

        Row {
            width: parent.width
            spacing: 4

            Text {
                id: name
                text: "相机"
                color: "white"
                font.pointSize: pointSize -4
                font.bold: true
                style: Text.Outline
                styleColor: "#66000000"
            }

            Text {
                id: verify
                text: "真实可验"
                color: "#1A1A1A"
                font.pointSize: pointSize -4
                font.bold: true
                font.letterSpacing: 2
                // style: Text.Outline
                // styleColor: "gray"
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -2
                    color: "white"
                    opacity: 0.5
                    radius: 2
                    z: -1
                }
            }
        }

        Text {
            id: security
            width: parent.width
            text: "防伪 " + Qt.md5(timeStr).substring(0, 14).toUpperCase()
            color: "white"
            font.pointSize: pointSize -4
            font.bold: true
            fontSizeMode: Text.Fit
            minimumPointSize: 1
            horizontalAlignment: Text.AlignRight
            style: Text.Outline
            styleColor: "#66000000"
        }

        DragHandler {
            acceptedButtons: Qt.AllButtons
        }
    }
}