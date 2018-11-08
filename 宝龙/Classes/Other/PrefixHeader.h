//
//  PrefixHeader.h
//  合生
//
//  Created by 凌甜 on 2018/5/31.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

#import "UIView+SunExtension.h"
#import "UIViewController+Extension.h"

//#import <Masonry.h>
#import "Const.h"


#ifdef DEBUG
#define ZHYLog(...) NSLog(__VA_ARGS__)
#define ZHYLogFunc ZHYLog(@"%s",__func__)
#else
#define ZHYLog(...)
#define ZHYLogFunc
#endif

// block弱引用
#define kWeakSelf __weak typeof(self) weakSelf = self;
// 取得当前主窗口
#define kKeyWindow [UIApplication sharedApplication].keyWindow
// 当前屏幕尺寸相关
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenW kScreenBounds.size.width
#define kScreenH kScreenBounds.size.height

// 颜色相关
#define kARGBColor(a, r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kRGBColor(r, g, b) kARGBColor(255, (r), (g), (b))
#define kGrayColor(v) kRGBColor((v), (v), (v))
#define kCommonBgColor kGrayColor(215)
#define kRandomColor kARGBColor(0.6, arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

// 将数据写到桌面的plist 注意: (其他人使用请修改 "sunallies" 为自己电脑的 UserName )
#define kWriteToPlist(data, filename) [data writeToFile:[NSString stringWithFormat:@"/Users/sunallies/Desktop/%@.plist", filename] atomically:YES];

// 缓存路径
#define kCacheFile [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"default"]

#define kW kScreenW / 1366
#define kH kScreenH / 1024

#endif /* PrefixHeader_h */
