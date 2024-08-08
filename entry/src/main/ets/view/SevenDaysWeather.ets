import Day from '../viewmodel/Day'

@Component
export default struct SevenDaysWeather {
  @Prop seve:Day[]
  build() {
      Column({space:10}){
         Text('📅7日天气').fontColor(Color.White)
          ForEach(this.seve,(item:Day,index)=>{
            this.sevenPre(index)
          })
      }
      .alignItems(HorizontalAlign.Start)
      .padding(12)
      .margin(4)
      .width('94%')
      .borderRadius(20)
      .backgroundColor($r('app.color.small_window_background'))
  }
  @Builder sevenPre(inde:number){
    Divider().color($r('app.color.divider_window_background'))
    Row({space:6}){
      Text(`${this.seve[inde].fxDate}`).fontColor(Color.White)
      Image($r(`app.media.${this.seve[inde].iconDay}`)).width(20).margin({left:20,right:20})
      Text(`${this.seve[inde].tempMin}°`).fontColor($r('app.color.divider_window_background'))
      Progress({value:26,total:40}).width(140).color($r('app.color.highdowntemp'))
      Text(`${this.seve[inde].tempMax}°`).fontColor(Color.White)
    }
  }
}
