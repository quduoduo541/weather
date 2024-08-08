import NowTempp from './NowTempp'

export default class NowTemp{
  updateTime: string
  fxLink: string
  now:NowTempp

  constructor(updateTime: string,fxLink: string,now:NowTempp) {
    this.updateTime=updateTime
    this.fxLink=fxLink
    this.now=now
  }
}