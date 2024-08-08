import CityLocationInfo from '../viewmodel/CityLocationInfo'
import FirstStas from '../viewmodel/FirstStas'

@Component
export default struct MainTop {
  // @Link Citie:CityLocationInfo[]
  @Link Citie:string
  @Prop nowtem:string
  @Link tex:string
  @Link tempma:string
  @Link tempmi:string
  @Prop adm2:string
  build() {
    Column(){
      // Text(this.Cities[0].name).fontSize(28) .fontColor(Color.White)
      Text(`${this.adm2}市${this.Citie}区`).fontSize(28) .fontColor(Color.White)
      Text(`${this.nowtem}°`).fontSize(84).fontWeight(200) .fontColor(Color.White)
      Text(this.tex).fontSize(16) .fontColor(Color.White).margin({bottom:5})
      Text(`最高${this.tempma}° 最低${this.tempmi}°`).fontSize(16) .fontColor(Color.White)
    }.width('100%').margin({top:90,bottom:60})
  }
}