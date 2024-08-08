import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import { common } from '@kit.AbilityKit';

class RequestPermissionUtil{
  reqPermissionsFromUser(permissions: Array<Permissions>): void {
    let context = getContext(this) as common.UIAbilityContext;
    let atManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作
          AlertDialog.show(
            {
              title: '消息',
              message: '用户手动授权成功',
              autoCancel: true,
              alignment: DialogAlignment.Bottom,
            }
          )
        } else {
          // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
          AlertDialog.show(
            {
              title: '消息',
              message: '用户拒绝授权',
              autoCancel: true,
              alignment: DialogAlignment.Bottom,
            }
          )
          return;
        }
      }
      // 授权成功
    }).catch((err:Error) => {
      console.error(`requestPermissionsFromUser failed, name is ${err.name}, message is ${err.message}`);
    })
  }
}
const requestutil=new RequestPermissionUtil()
export default requestutil as RequestPermissionUtil