@Component
export default struct HourWeather {
  @Prop categor:string
  @Prop totalaq:string
  build() {
    Column({space:5}){
      Text('※ 空气质量') .fontColor(Color.White).fontSize(16)
      Text(`${this.totalaq}-${this.categor}`) .fontColor(Color.White)
      Text(`当前AQI(CN)为${this.totalaq}。`) .fontColor(Color.White).margin({bottom:14})
      Progress({value:Number(this.totalaq),total:500})
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .margin(4)
    .width('94%')
    .borderRadius(20)
    .backgroundColor($r('app.color.small_window_background'))
  }
}