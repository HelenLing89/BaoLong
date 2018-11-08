//
//  UIImage+SunExtension.m
//  pvm
//
//  Created by Sunallies on 2017/10/13.
//  Copyright © 2017年 Sunallies. All rights reserved.
//

#import "UIImage+SunExtension.h"

@implementation UIImage (SunExtension)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
