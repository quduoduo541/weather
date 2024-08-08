import location from '../model/CityLocationInfoModel'
import AirQualityMap from '../view/AirQualityMap'
import AirQualityStas from '../view/AirQualityStas'
import HourWeather from '../view/HourWeather'
import MainTop from '../view/MainTop'
import RayAndSun from '../view/RayAndSun'
import SevenDaysWeather from '../view/SevenDaysWeather'
import WarnItem from '../view/WarnItem'
import Day from '../viewmodel/Day'
import FirstStas from '../viewmodel/FirstStas'
import tf from '../viewmodel/tf'
import TfInfo from '../viewmodel/TfInfo'
import { geoLocationManager } from '@kit.LocationKit'
import requestutil from '../utils/RequestPermissionUtil'
import { abilityAccessCtrl, Permissions } from '@kit.AbilityKit'
import BottomNavBar from '../view/BottomNavBar'

@Extend(Column) function colCommon(){
  .alignItems(HorizontalAlign.Center)
  .padding(12)
  .margin(4)
  .width('90%')
  .borderRadius(20)
  .backgroundColor($r('app.color.small_window_background'))
}
@Entry
@Component
struct Index {
  //存放拿到的城市位置信息
  @State city:string=''
  @State cityid:number=0
  @State adm2:string=''
  @State nowtemp:string=''
  @State text:string=''
  @State tempmax:string=''
  @State tempmin:string=''
  @State typeName:string=''
  @State isWarn:boolean=false
  @State endTime:string=''
  @State totalaqi:string=''
  @State category: string=''
  @State icon:string=''
  @State hourly:tf[]=[]
  @State seven:Day[]=[]
  //加载城市信息
  async aboutToAppear() {
    // this.loadCityInfo()
    await this.getLocation()
  }
  async getLocation () {
    try {
      console.log('进来了吗')
      const result = await geoLocationManager.getCurrentLocation()
      console.log(JSON.stringify(result))
      // location.getLocationInfo(`${result.longitude},${result.latitude}`)
      //   .then(res=>{
      //     this.city=res.location[0].name
      //     this.adm2=res.location[0].adm2
      //   })
      this.loadCityInfo(`${result.longitude},${result.latitude}`)
    }catch (error) {
      // AlertDialog.show({
      //   message: JSON.stringify(`${error.message}这里吗`)
      // })
    }
  }

  build() {
    Stack(){
      Swiper() {
        List() {
          //顶部
          MainTop({
            Citie: $city,
            nowtem: this.nowtemp,
            tex: $text,
            tempma: $tempmax,
            tempmi: $tempmin,
            adm2:this.adm2
          })
          //天气警告
          if (this.isWarn) {
            WarnItem({ typeNam: $typeName,endtim:this.endTime })
          }
          //空气质量数据
          AirQualityStas({ totalaq: this.totalaqi, categor: this.category })
          //每小时天气
          HourWeather({ ico: this.icon, nowtem: this.nowtemp, hourl: this.hourly })
          //空气质量地图
          AirQualityMap()
          //7日天气
          SevenDaysWeather({ seve: this.seven })
          //紫外线和日出
          RayAndSun()
        }
        .backgroundColor($r('app.color.main_window_background'))
        // .background()
        .padding({ left: 10 })
        .scrollBarWidth(0)

        List() {
          //顶部
          MainTop({
            Citie: $city,
            nowtem: this.nowtemp,
            tex: $text,
            tempma: $tempmax,
            tempmi: $tempmin
          })
          //天气警告
          if (this.isWarn) {
            WarnItem({typeNam: $typeName,endtim:this.endTime})
          }
          //空气质量数据
          AirQualityStas({ totalaq: this.totalaqi, categor: this.category })
          //每小时天气
          HourWeather({ ico: this.icon, nowtem: this.nowtemp, hourl: this.hourly })
          //空气质量地图
          AirQualityMap()
          //7日天气
          SevenDaysWeather({ seve: this.seven })
          //紫外线和日出
          RayAndSun()

        }.backgroundColor($r('app.color.main_window_background'))
        .padding({ left: 10 })
        .scrollBarWidth(0)
      }.indicator(
        new DotIndicator()
           .itemWidth(10)
           .itemHeight(10)
           .selectedItemWidth(10)
           .selectedItemHeight(10)
           .color($r('app.color.bottom_dot'))
           .selectedColor(Color.White))
        BottomNavBar().position({x:0,y:730}).backgroundColor($r('app.color.bottom_back'))
    }


  }
//参数是经纬度
 async loadCityInfo(str:string){
    await location.getLocationInfo(str)
      .then(res=>{
        this.city=res.location[0].name
        this.adm2=res.location[0].adm2
        this.cityid=Number(res.location[0].id)
        console.log(`${this.cityid}城市id`)
      })
      .catch((err:Error)=>{
        console.log('失败')
      })
   location.getNowTemp(this.cityid)
    .then(res=>{
      this.nowtemp=res.now.temp
      this.text=res.now.text
      this.icon=res.now.icon
      console.log('TTT成功',res.now.temp.toString());
    })
    .catch((err:Error)=>{
      console.log('TTT失败')
    })
  location.getSevenDay(this.cityid)
    .then(res=>{
      this.tempmax=res.daily[0].tempMax
      this.tempmin=res.daily[0].tempMin
      this.seven=res.daily
    }
    )
  location.getWarning(this.cityid)
    .then(res=>{
      if(res.warning[0].id){
        this.isWarn=true
          this.typeName=res.warning[0].typeName
          this.endTime=res.warning[0].endTime.slice(5,16)
          console.log(`${this.endTime}endl`)
      }
    })
  location.getAirQuality(this.cityid)
    .then(res=>{
      this.totalaqi=res.now.aqi
      this.category=res.now.category
    }
    )
  location.get24weather(this.cityid)
    .then(res=>{
        this.hourly=res.hourly
    })
  }

}