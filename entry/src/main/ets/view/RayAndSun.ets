@Component
export default struct RayAndSun {
  build() {
    Row(){
      //紫外线
      Column({space:5}){
        Text('☀ 紫外线指数')
        Text('0').fontColor(Color.White).fontSize(30)
        Text('低').fontColor(Color.White).fontSize(15)
        Progress({value:0,total:100}).width(130)
        Text('接下来持续较低。').fontColor(Color.White).fontSize(12)
      }.padding(12)
      .margin(4)
      .borderRadius(20)
      .backgroundColor($r('app.color.small_window_background'))
      .width(158)
      .height(158)
      .alignItems(HorizontalAlign.Start)
      //日出
      Column({space:5}){
        Text('🌅 日出')
        Text('05:57').fontColor(Color.White).fontSize(30)
        Image($r('app.media.100')).width(20)
        Text('日落 : 19:43').fontColor(Color.White).fontSize(12)
      }.padding(12)
      .margin(4)
      .borderRadius(20)
      .backgroundColor($r('app.color.small_window_background'))
      .backgroundColor($r('app.color.small_window_background'))
      .width(158)
      .height(158)
      .alignItems(HorizontalAlign.Start)
    }
    .width('94%')


  }
}