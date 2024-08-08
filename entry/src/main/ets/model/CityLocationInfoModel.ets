import  http  from '@ohos.net.http';
import Aqi from '../viewmodel/Aqi';
import EveryDay from '../viewmodel/EveryDay';
import FirstStas from '../viewmodel/FirstStas';
import NowTemp from '../viewmodel/NowTemp';
import RelativeLocation from '../viewmodel/RelativeLocation';
import TfInfo from '../viewmodel/TfInfo';
import WarnTemp from '../viewmodel/WarnTemp';

//这是工具类,需要导出让别人使用.由于是个类,要使用需要new对象.直接在下面帮使用者new好
class LocationInfo {
  key = 'aee44f0892eb4c76ab8c4f8d798019ef'
  getLocationInfo(location: string = '') {
    return new Promise<FirstStas>((resolve, reject) => {
      //https://geoapi.qweather.com/v2/city/lookup?location=beij&key=aee44f0892eb4c76ab8c4f8d798019ef
      //创建http请求对象
      let httpRequest = http.createHttp()
      //发送请求
      httpRequest.request(
        `https://geoapi.qweather.com/v2/city/lookup?location=${location}&key=${this.key}&gzip=n`,
        {
          method: http.RequestMethod.GET
        }
      )
        .then(res => {
          if (res.responseCode === 200) {
            console.log('testTag1', res.result)
            resolve(JSON.parse(res.result.toString()))
          } else {
            console.log('查询失败1,', JSON.stringify(res.result))
            reject('失败1')
          }
        })
        .catch((err: Error) => {
          console.log('查询失败2,', JSON.stringify(err))
          reject('失败2')
        })
    })
  }

  getNowTemp(location: number = 101010100) {
    return new Promise<NowTemp>((resolve, reject) => {
      let httpRequest = http.createHttp()
      httpRequest.request(
        `https://devapi.qweather.com/v7/weather/now?location=${location}&key=${this.key}`,
        {
          method: http.RequestMethod.GET
        }
      )
        .then(res => {
          if (res.responseCode === 200) {
            console.log(`${location}eee`)
            console.log((JSON.parse(res.result.toString()))+'testTag2res')
            resolve(JSON.parse(res.result.toString()))
          }
        })
        .catch((err: Error) => {
          console.log('testTag2获取当前温度失败', JSON.stringify(err))
        })
    })
  }

  getSevenDay(location: number = 0) {
    return new Promise<EveryDay>((resolve, reject) => {
      let httpRequest = http.createHttp()
      httpRequest.request(
        `https://devapi.qweather.com/v7/weather/7d?location=${location}&key=${this.key}`,
        {
          method: http.RequestMethod.GET
        }
      )
        .then(res => {
          if (res.responseCode === 200) {
            resolve(JSON.parse(res.result.toString()))
            console.log('testTag3获取七天信息成功')
          }
        })
        .catch((err: Error) => {
          console.log('testTag3获取七天信息失败')
        })
    })
  }

  getWarning(location: number = 0) {
    return new Promise<WarnTemp>((resolve, reject) => {
      let httpRequest = http.createHttp()
      httpRequest.request(
        `https://devapi.qweather.com/v7/warning/now?location=${location}&key=${this.key}`,
        {
          method: http.RequestMethod.GET
        }
      )
        .then(res => {
          if (res.responseCode === 200) {
            console.log('testTag4获取预警成功', res.result.toString())
            resolve(JSON.parse(res.result.toString()))
          }
        })
        .catch((err: Error) => {
          console.log('testTag4获取预警失败')
        })
    })
  }

  getAirQuality(location: number = 0) {
    return new Promise<Aqi>((resolve, reject) => {
      let httpRequest = http.createHttp()
      httpRequest.request(
        `https://devapi.qweather.com/v7/air/now?location=${location}&key=${this.key}`,
        {
          method: http.RequestMethod.GET
        }
      )
        .then(res => {
          if (res.responseCode === 200) {
            console.log('testTag5获取空气质量成功', res.result.toString())
            resolve(JSON.parse(res.result.toString()))
          }
        })
        .catch((err: Error) => {
          console.log('testTag4获取空气质量失败')
        })
    })
  }

  get24weather(location: number = 0) {
    return new Promise<TfInfo>((resolve, reject) => {
      {
        let httpRequest = http.createHttp()
        httpRequest.request(
          `https://devapi.qweather.com/v7/weather/24h?location=${location}&key=${this.key}`,
          {
            method: http.RequestMethod.GET
          }
        )
          .then(res => {
            if (res.responseCode === 200) {
              console.log('testTag', res.result)
              resolve(JSON.parse(res.result.toString()))
            } else {
              console.log('查询失败,', JSON.stringify(res))
              reject('失败')
            }
          })
          .catch((err: Error) => {
            console.log('失败!!!')
          })
      }
    })
  }
  getRelative(location: string=''){
    return new Promise<RelativeLocation>((resolve, reject) => {
      {
        //https://geoapi.qweather.com/v2/poi/lookup?type=scenic&location=beij&key=aee44f0892eb4c76ab8c4f8d798019ef
        let httpRequest = http.createHttp()
        httpRequest.request(
          `https://geoapi.qweather.com/v2/poi/lookup?type=scenic&location=${location}&key=${this.key}`,
          {
            method: http.RequestMethod.GET
          }
        )
          .then(res => {
            if (res.responseCode === 200) {
              console.log('testTag', res.result)
              resolve(JSON.parse(res.result.toString()))
            } else {
              console.log('查询失败,', JSON.stringify(res))
              reject('失败')
            }
          })
          .catch((err: Error) => {
            console.log('失败!!!')
          })
      }
    })
  }
}
const location=new LocationInfo()
export default location as LocationInfo