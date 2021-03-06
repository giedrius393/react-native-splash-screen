/**
 * SplashScreen
 * 启动屏
 * from：http://www.devio.org
 * Author:CrazyCodeBoy
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */
#import <React/RCTBridgeModule.h>

@interface SplashScreen : NSObject<RCTBridgeModule>
+ (void)show;
+ (void)hide;
+ (void)showSplashScreen:UIWindow splashScreenImage:UIImage;
+ (void)hideSplashScreen:UIWindow;
@end
