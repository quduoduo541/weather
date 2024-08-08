import Stationaqi from './Stationaqi'
import Totalaqi from './Totalaqi'

export default class Aqi {
  now: Totalaqi
  station: Stationaqi[]

  constructor(now: Totalaqi, station: Stationaqi[]) {
    this.now=now
    this.station = station
  }
}