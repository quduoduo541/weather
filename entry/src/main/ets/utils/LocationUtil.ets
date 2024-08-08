import geoLocationManager from '@ohos.geoLocationManager';
class Location{
  latitude:number
  longitude:number
  constructor(latitude: number, longitude: number) {
    this.latitude = latitude;
    this.longitude = longitude;
  }
}

interface GeneratedObjectLiteralInterface_1 {
  'priority': number;
  'scenario': number;
  'timeInterval': number;
  'distanceInterval': number;
  'maxAccuracy': number;
}

class LocationUtil{
  getCurLocation(){
    let requestInfo: GeneratedObjectLiteralInterface_1= {'priority': 0x203, 'scenario': 0x300,'timeInterval': 0, 'distanceInterval': 0, 'maxAccuracy': 0};
    // 处理位置变化的函数，当位置发生变化时会被调用
    let locationChange = (location:Location) => {
      console.log('locationChanger: data: ' + JSON.stringify(location));
    };
    try {
      // 使用geoLocationManager对象的on方法监听位置变化事件
      geoLocationManager.on('locationChange', requestInfo, locationChange);
    } catch (err) {
      console.error("errCode:" + err.code + ",errMessage:" + err.message);
    }
  }
}
let locationutil=new LocationUtil()
export default locationutil as LocationUtil
