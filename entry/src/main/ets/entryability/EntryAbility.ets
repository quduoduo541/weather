import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { promptAction, window } from '@kit.ArkUI';
import abilityAccessCtrl from '@ohos.abilityAccessCtrl'
import preferencesUtil from '../utils/PreferenceUtil'
export default class EntryAbility extends UIAbility {
  // onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
  //   hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  // }
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void>  {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    let manager = abilityAccessCtrl.createAtManager()
    try {
      console.log('哪里')
     await manager.requestPermissionsFromUser(this.context,
        [
          'ohos.permission.LOCATION_IN_BACKGROUND',
          'ohos.permission.LOCATION',
          'ohos.permission.APPROXIMATELY_LOCATION',
        ]).then(result=>{
        hilog.info(0x0000, 'testTag', '%{public}s', result.authResults);
      })

      console.log('成功了?')
    } catch (err) {
      console.log("???")
      promptAction.showToast({ message: '获取位置信息失败！' })
    }
    await preferencesUtil.loadPreference(this.context,'MyPreference' )
  }
  // async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
  //   hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  //
  //   let atManager = abilityAccessCtrl.createAtManager();
  //   try {
  //     atManager.requestPermissionsFromUser(this.context,
  //       ['ohos.permission.INTERNET', 'ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'])
  //       .then((data) => {
  //         console.log('aaa');
  //       })
  //       .catch((err:Error)=>{
  //         console.log('bbb')
  //       })
  //   } catch {
  //     console.log('ccc')
  //   }
  // }
  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
