import { router } from '@kit.ArkUI'

@Component
export default struct BottomNavBar {
  build() {
      Row(){
        Image($r('app.media.pingxing')).width(26)
        Image($r('app.media.addmore')).width(33).onClick(()=>{
          router.pushUrl(
            {
              url: 'pages/CitySearchPage',			// - url: 目标页面路径
              params: {id: 1}				   // - params:传递的参数(可选)
            },
            router.RouterMode.Single,			// 页面模式:RouterMode枚举
            err => {
              if(err){
                console.log('路由失败.')
              }
            }
          )
        })
      }.width('100%')
      .height(75)
      .padding({left:20,right:20,bottom:30})
    .justifyContent(FlexAlign.SpaceBetween)
  }
}