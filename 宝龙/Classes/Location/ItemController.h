//
//  ItemController.h
//  宝龙
//
//  Created by 凌甜 on 2018/10/23.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ItemVcDelegate <NSObject>
@optional
- (void)itemVcScrollToIndex:(NSInteger)index;

@end
@interface ItemController : UIViewController
@property (nonatomic, weak) id <ItemVcDelegate>delegate;

- (void)itemViewWillShow;

- (void)itemViewWillHide;

@end

NS_ASSUME_NONNULL_END
