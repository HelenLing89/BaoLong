//
//  HaiController.h
//  宝龙
//
//  Created by 凌甜 on 2018/10/23.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HaiVcDelegate <NSObject>
@optional
- (void)haiVcScrollToIndex:(NSInteger)index;

@end

@interface HaiController : UIViewController
@property (nonatomic, weak) id <HaiVcDelegate>delegate;

- (void)haiViewWillShow;

- (void)haiViewWillHide;

@end

