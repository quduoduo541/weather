import location from '../model/CityLocationInfoModel'
import { text } from '@kit.ArkGraphics2D'
import Relative from '../viewmodel/Relative'
import CityLocationInfo from '../viewmodel/CityLocationInfo'

@CustomDialog
struct CustomDialogExample {
  @Prop clicknam:string=''
  controller: CustomDialogController
  cance?:()=>void
  build() {
    Column(){
      Row(){
        Text('取消').fontSize(18).fontColor(Color.White).onClick(()=>{
          if(this.cance){
            this.cance()
          }
        })
        Text('添加').fontSize(18).fontColor(Color.White)

      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding({top:8,left:8,right:8})

    }.width('100%')
    .height('100%')
    .backgroundColor(Color.Pink)
  }
}
@Entry
@Component
struct CitySearchPage {
  @State clickname:string=''
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({cance:this.cancel.bind(this),clicknam:this.clickname}),
    cancel:(()=>{this.dialogController.close()}),
    alignment: DialogAlignment.Bottom,
    cornerRadius:{topLeft: 14, topRight:14, bottomLeft:0, bottomRight: 0}
  })
  cancel() {
    this.dialogController.close()
  }
  @State widt:string='100%'
  @State clicksearch:boolean=false
  @State relativearr:CityLocationInfo[]=[]
  @State title:boolean=true
  @State val:string=''
  build() {
    Column(){
      if(this.title){
        Text('天气').textAlign(TextAlign.Start)
          .width('100%')
          .fontSize(25).fontWeight(600)
          .fontColor(Color.White)
          .margin({top:40})
      }
      Column(){
        Row(){
          Search({placeholder:'搜索城市'})
            .caretStyle({color:Color.White})
            .placeholderFont({size:14})
            .searchIcon({color:$r('app.color.search_background'),size:'20'})
            .backgroundColor($r('app.color.searchbox_window_background'))
            .placeholderColor($r('app.color.search_background'))
            .textFont({size:14})
            .fontColor(Color.White)
            .cancelButton({ icon: { src: $r('app.media.cancel') } })
            .height(27)
            .width(this.widt)
            .onClick(()=>{
              this.title=false
              this.widt='90%'
              this.clicksearch=true
            })

            .onChange(value=>{
              if(value){
                this.val=value
                location.getLocationInfo(value)
                  .then(res=>{
                    this.relativearr=res.location
                  })
              }
            })
          if(this.clicksearch){
            Text('取消').fontColor(Color.White).onClick(()=>{
              this.clicksearch=false
              this.widt='100%'
              this.title=true
            })
          }
        }
        List(){
          ForEach(this.relativearr,(item:Relative,idx)=>{
            ListItem(){
              Text(item.name).padding({left:20,top:5,bottom:5}).fontColor($r('app.color.search_background')).width('100%')
                .onClick(()=>{
                  this.clickname=item.name
                  this.dialogController.open()
                })
            }
          })
        }.width('100%')
      }
      if(!this.val){
        List({space:8}){
          ForEach([1,2,3],()=>{
            ListItem(){
              Row(){
                Column(){
                  Text('我的位置').fontColor(Color.White).fontSize(16)
                  Text('西安市长安区').fontColor(Color.White).fontSize(10)
                  Text('⚠').fontColor(Color.White).fontSize(10).margin({top:5})
                  Text('恶劣天气及其他1则').fontColor(Color.White).fontSize(10)
                }.alignItems(HorizontalAlign.Start)
                Column({space:10}){
                  Text('30°').fontSize(35).fontColor(Color.White)
                  Text('最高31° 最低26°').fontColor(Color.White).fontSize(10)
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .padding({top:8,bottom:8,left:14,right:14})
              .borderRadius(14)
              .backgroundColor($r('app.color.small_window_background'))
            }
          })
        }
      }
    }.padding(15)
      .backgroundColor(Color.Black)
    .height('100%')
  }
}


