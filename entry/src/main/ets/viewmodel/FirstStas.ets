import CityLocationInfo from './CityLocationInfo'
import Refer from './Refer'

export default class FirstStas{
  code:string
  location:CityLocationInfo[]
  refer:Refer

  constructor(code:string,location:CityLocationInfo[],refer:Refer) {
    this.code=code
    this.location=location
    this.refer=refer
  }
}
