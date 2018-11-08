//
//  BaseImageView.m
//  湖州世茂
//
//  Created by 凌甜 on 2018/9/26.
//  Copyright © 2018年 ATT. All rights reserved.
//

#import "BaseImageView.h"

@implementation BaseImageView
@synthesize current_radian;
@synthesize current_animation_radian;
@synthesize animation_radian;
@synthesize radian;
@synthesize view_point;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
