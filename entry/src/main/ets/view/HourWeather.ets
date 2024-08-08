import tf from '../viewmodel/tf'

@Component
export default struct AirQualityMap {
  @Prop ico:string
  @Prop nowtem:string
  @Prop hourl:tf[]
  build() {
    Column(){
      Text('🕘︎ 每小时天气预报').fontColor(Color.White).fontSize(14)
        List(){
          ForEach(this.hourl,(item:string,index)=>{
            ListItem(){
              if(index===0){
                Column(){
                  Text('现在').fontColor(Color.White)
                  Image($r(`app.media.${this.ico}`)).width(20).margin({top:5,bottom:5})
                  Text(`${this.nowtem}°`).fontColor(Color.White)
                }
              }else
              Column(){
                if(this.hourl[index-1].fxTime[11]==='0'){
                  Text(`${this.hourl[index-1].fxTime.slice(12,13)}时`).fontColor(Color.White)
                  Image($r(`app.media.${this.hourl[index-1].icon}`)).width(20).margin({top:5,bottom:5})
                  Text(`${this.hourl[index-1].temp}°`).fontColor(Color.White)
                }else{
                  Text(`${this.hourl[index-1].fxTime.slice(11,13)}时`).fontColor(Color.White)
                  Image($r(`app.media.${this.hourl[index-1].icon}`)).width(20).margin({top:5,bottom:5})
                  Text(`${this.hourl[index-1].temp}°`).fontColor(Color.White)
                }
              }
            }.margin({right:10})
          })
        }.listDirection(Axis.Horizontal)
        .scrollBarWidth(0)
    }.alignItems(HorizontalAlign.Start)
    .padding(12)
    .margin(4)
    .width('94%')
    .borderRadius(20)
    .backgroundColor($r('app.color.small_window_background'))
    .height(100)
  }
}