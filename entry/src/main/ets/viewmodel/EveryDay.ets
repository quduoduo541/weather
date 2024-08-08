import Day from './Day'

export default class Every{
  updateTime: string
  fxLink: string
  daily:Day[]

  constructor(updateTime: string,fxLink: string,daily:Day[]) {
    this.updateTime=updateTime
    this.fxLink=fxLink
    this.daily=daily
  }
}