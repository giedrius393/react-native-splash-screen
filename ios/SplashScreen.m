/**
 * SplashScreen
 * 启动屏
 * from：http://www.devio.org
 * Author:CrazyCodeBoy
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */

#import "SplashScreen.h"
#import <React/RCTBridge.h>

static bool waiting = true;
static bool addedJsLoadErrorObserver = false;
static bool splashScreenEnabled = true;
static int imgTag = 1111;

@implementation SplashScreen
- (dispatch_queue_t)methodQueue{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

+ (void)show {
    if (!addedJsLoadErrorObserver) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jsLoadError:) name:RCTJavaScriptDidFailToLoadNotification object:nil];
        addedJsLoadErrorObserver = true;
    }

    while (waiting) {
        NSDate* later = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop mainRunLoop] runUntilDate:later];
    }
}

+ (void)hide {
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       waiting = false;
                   });
}

+ (void) showSplashScreen:(UIWindow*)window splashScreenImage:(UIImage*)image{
    if (!splashScreenEnabled) { return; }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame: [UIScreen mainScreen].bounds];
    imageView.image = image;
    imageView.tag = imgTag;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [window addSubview:imageView];
 }

+ (void) hideSplashScreen:(UIWindow*)window {
    if (!splashScreenEnabled) { return; }
    UIView *imageView = [window viewWithTag:imgTag];
    [imageView removeFromSuperview];
}

+ (void) jsLoadError:(NSNotification*)notification
{
    // If there was an error loading javascript, hide the splash screen so it can be shown.  Otherwise the splash screen will remain forever, which is a hassle to debug.
    [SplashScreen hide];
}

RCT_EXPORT_METHOD(hide) {
    [SplashScreen hide];
}

RCT_EXPORT_METHOD(enableSplashScreen) {
    splashScreenEnabled = true;
}

RCT_EXPORT_METHOD(disableSplashScreen) {
    splashScreenEnabled = false;
}

@end
