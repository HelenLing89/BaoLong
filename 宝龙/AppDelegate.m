//
//  AppDelegate.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/16.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "BaseNavController.h"
#import "RootController.h"



@interface AppDelegate ()
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
    BaseNavController *base = [[BaseNavController alloc] initWithRootViewController:[RootController new]];
    self.window.rootViewController = base;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)playMusic {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"glow" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    player.volume = 0.4;
    self.player = player;
    [player play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playEnd {
    CGFloat progress = CMTimeGetSeconds(self.player.currentTime)/ CMTimeGetSeconds([self.player.currentItem duration]);
    if (progress > 0.9) {
        [self.player seekToTime:kCMTimeZero];
        [self.player play];
    }
    else {
        [self.player seekToTime:self.player.currentTime];
        [self.player play];
    }
}

- (void)continuPlayerMusic {
    [self.player seekToTime:self.player.currentTime];
    [self.player play];
}

- (void)pauseMusic {
    [self.player pause];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
