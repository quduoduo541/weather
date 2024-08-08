@Component
export default struct AirQulityMap {
  build() {
    Column({space:10}){
      Text('※ 空气质量地图') .fontColor(Color.White)
      Image($r('app.media.app_icon')).width(300)
    }.alignItems(HorizontalAlign.Start)
    .padding(12)
    .margin(4)
    .width('94%')
    .borderRadius(20)
    .backgroundColor($r('app.color.small_window_background'))

  }
}