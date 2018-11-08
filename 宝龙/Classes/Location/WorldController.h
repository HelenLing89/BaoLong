//
//  WorldController.h
//  宝龙
//
//  Created by 凌甜 on 2018/10/23.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WorldVcDelegate <NSObject>
@optional
- (void)worldVcScrollToIndex:(NSInteger)index;

@end

@interface WorldController : UIViewController
@property (nonatomic, weak) id <WorldVcDelegate>delegate;

- (void)worldViewWillShow;

- (void)worldViewWillHide;

@end


