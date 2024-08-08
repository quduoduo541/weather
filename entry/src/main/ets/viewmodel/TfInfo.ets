import tf from './tf'

export default class TfInfo{
  code:string
  updateTime:string
  fxLink:string
  hourly:tf[]

  constructor(code:string,updateTime:string,fxLink:string,hourly:tf[]) {
    this.code=code
    this.updateTime=updateTime
    this.fxLink=fxLink
    this.hourly=hourly
  }
}