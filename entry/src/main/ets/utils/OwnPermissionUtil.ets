import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl'
import bundleManager from '@ohos.bundle.bundleManager';
import locationutil from './LocationUtil';
import requestutil from './RequestPermissionUtil';

//checkAccessToken用来获取abilityAccessCtrl.GrantStatus类型对象。
export default class OwnPermissionUtil {
  async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager = abilityAccessCtrl.createAtManager();
    //用于存储权限检查的结果
    let grantStatus: abilityAccessCtrl.GrantStatus = -1;
    // 获取应用程序的accessTokenID
    let tokenId: number = 0;
    try {
      let bundleInfo: bundleManager.BundleInfo =
        await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      //从获取到的bundleInfo中提取出应用信息，并存储在变量appInfo中
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      // 从应用信息中获取accessTokenId
      tokenId = appInfo.accessTokenId;
    } catch (err) {
      console.error(`getBundleInfoForSelf failed, code is ${err.code}, message is ${err.message}`);
    }
    // 校验应用是否被授予权限
    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (err) {
      console.error(`checkAccessToken failed, code is ${err.code}, message is ${err.message}`);
    }
    return grantStatus;
  }
  //checkPermissions函数调用checkAccessToken获取abilityAccessCtrl.GrantStatus类型对象后，通过该类型对象进行判定设备是否拥有权限
  async checkPermissions(): Promise<void> {
    const permissions: Array<Permissions> = ['ohos.permission.LOCATION','ohos.permission.LOCATION_IN_BACKGROUND',
      'ohos.permission.APPROXIMATELY_LOCATION'];
    let grantStatus1: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permissions[0]);
    let grantStatus2: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permissions[1]);
    let grantStatus3: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permissions[2]);
    if ((grantStatus1&&grantStatus2&&grantStatus3) === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 已经授权，可以继续访问目标操作
      // AlertDialog.show(
      //   {
      //     title: '消息',
      //     message: '权限已经授权',
      //     autoCancel: true,
      //     alignment: DialogAlignment.Bottom,
      //   }
      // )
      locationutil.getCurLocation()
    } else {
      // 没有被授权
      // AlertDialog.show(
      //   {
      //     title: '消息',
      //     message: '权限没有被授予',
      //     autoCancel: true,
      //     alignment: DialogAlignment.Bottom,
      //   }
      // )
      requestutil.reqPermissionsFromUser(permissions)
    }
  }

}