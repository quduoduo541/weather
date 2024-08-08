import Warn from './Warn'

export default class WarnTemp{
  updateTime: string
  fxLink: string
  warning: Warn[]

  constructor(updateTime: string,
  fxLink: string,
  warning: Warn[]) {
    this.updateTime=updateTime
    this.fxLink=fxLink
    this.warning=warning
  }
}