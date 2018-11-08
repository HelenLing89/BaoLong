//
//  BaseImageView.h
//  湖州世茂
//
//  Created by 凌甜 on 2018/9/26.
//  Copyright © 2018年 ATT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseImageView : UIImageView
//与y轴实时角度（逆时针方向），用于在拖动时候确定DragImageView的中心
@property(nonatomic) CGFloat current_radian;

//记录该位置初始的角度（与y轴）
@property(nonatomic) CGFloat radian;

//与x轴实时角度 用于DragImageView拖动停止后的旋转
@property(nonatomic) CGFloat current_animation_radian;

//记录该位置初始角度（与x轴）
@property(nonatomic) CGFloat animation_radian;

//DragImageView的中心
@property(nonatomic) CGPoint view_point;

@property (nonatomic,strong) NSString *imgName;

@property (nonatomic,strong) NSString *selectImgName;
@end

NS_ASSUME_NONNULL_END
