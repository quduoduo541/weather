@Component
export default struct AirQualityStas {
  @Link typeNam:string
  @Prop endtim:string
  build() {
    Column(){
      Row(){
        // Image($r('app.media.100')).width(20)
        Text(`⚠ ${this.typeNam}`)
          .fontColor(Color.White)
          .fontWeight(500)
      }
      Row(){
        Text(`${this.typeNam}, ${this.endtim}结束`).fontSize(12).fontColor(Color.White)
      }
      Text('国家预警信息发布中心').fontSize(10).fontColor(Color.White).fontWeight(200)
    }.alignItems(HorizontalAlign.Start)
    .padding(12)
    .margin(4)
    .width('94%')
    .borderRadius(20)
    .backgroundColor($r('app.color.small_window_background'))
  }
}