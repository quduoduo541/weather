export default class Relative{
  name: string
  id: string
  lat: string
  lon: string
  adm2:string
  adm1: string
  country: string
  tz:string

  constructor(name: string,
    id: string,
    lat: string,
    lon: string,
    adm2:string,
    adm1: string,
    country: string,
    tz:string) {
    this.name=name
    this.id=id
    this.lat=lat
    this.lon=lon
    this.adm2=adm2
    this.adm1=adm1
    this.country=country
    this.tz=tz
  }
}