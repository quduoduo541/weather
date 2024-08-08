import preference from '@ohos.data.preferences'
class City{
  name:string
  id?: string
  constructor(name:string,id?:string) {
    this.name = name
    this.id = id
  }
}
class PreferenceUtil{
  prefMap:Map<string,preference.Preferences>=new Map()
//定义一个方法加载Preference实例
  //应用内部有很多Preference实例,他们名字不一样
  async loadPreference(context,name:string) {
    try {
      let pref=await preference.getPreferences(context,name)//第二个参数是这个Preferences实例名称.这个方法拿到的是一个promise
      this.prefMap.set(name,pref)
      console.log('testTag,加载Preference成功')
    }
    catch(reason){
      // 获取失败
      console.log('testTag,加载Preference失败')
    }
  }
  async putPreferenceValue(name:string,key:string,value:preference.ValueType){
    if(!this.prefMap.has(name)){
      console.log('testTag,此Preference未初始化')
      return
    }
    try{
      await this.prefMap.get(name).put(key,value)
      await this.prefMap.get(name).flush()
      console.log('testTag,为此Preference保存值成功')
    }catch (e){
      console.log('testTag,为此Preference保存值失败')
    }
}
  async delPreferenceValue(name: string,key: string) {
    if (!this.prefMap.has(name)) {
      console.log('testTag', `Preferences[${name}]尚未初始化`)
      return
    }
    try {
        await this.prefMap.get(name).delete(key)
      console.log('testTag', `删除城市[${key}]成功`)
      } catch (e) {
      console.log('testTag', `删除城市[${key}]失败`, JSON.stringify(e))
    }
  }
// async getAllCities(name:string):Promise<City[]>{
//   if (!this.prefMap.has(name)) {
//     console.log('testTag', `Preferences[${name}]尚未初始化`)
//     return
//   }
//   await this.prefMap.get(name).getAll()
// }
}
const preferenceUtil = new PreferenceUtil()

export default preferenceUtil as PreferenceUtil