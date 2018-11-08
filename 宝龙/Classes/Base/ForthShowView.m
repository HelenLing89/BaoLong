//
//  ForthShowView.m
//  合生
//
//  Created by geek on 2018/6/4.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#import "ForthShowView.h"


@interface ForthShowView()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIButton *closeBtn;

@end


@implementation ForthShowView


- (UIImageView *)imageV {
    if (_imageV == nil) {
        _imageV = [UIImageView new];
        _imageV.backgroundColor = [UIColor clearColor];
       // _imageV.center = CGPointMake(self.k_centerX, self.k_centerY);
        _imageV.userInteractionEnabled = YES;
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageV];
    }
    return _imageV;
}

- (UIButton *)closeBtn {
    if (_closeBtn == nil) {
        _closeBtn = [UIButton new];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        self.userInteractionEnabled = YES;
    };
    
    return self;
}

- (void)setForthImageName:(NSString *)forthImageName {
    _forthImageName = forthImageName;
    self.imageV.image = [UIImage imageNamed:forthImageName];
    self.imageV.frame = self.imageVRect;
   // self.closeBtn.frame = CGRectMake(self.imageV.frame.size.width - 137 * 0.5 * kW, 80 * 0.5 * kH, 58 * 0.5 * kW, 58 * 0.5 * kW);
  //  [self.imageV addSubview: self.closeBtn];
   [self animationWithLayer:self.imageV.layer duration:0.3 values:@[@0.0, @1.2, @1.0]];
//    if (self.isTo720 == YES) {
//        UIButton *to720Btn = [[UIButton alloc] initWithFrame:CGRectMake(137 * 0.5 * kW, 80 * 0.5 * kH, 189 * 0.5 * kW, 79 * 0.5 * kH)];
//        [self.imageV addSubview:to720Btn];
//        [to720Btn setImage:[UIImage imageNamed:@"定点720"] forState:UIControlStateNormal];
//        [to720Btn addTarget:self action:@selector(to720) forControlEvents:UIControlEventTouchUpInside];
//    }
}


//- (void)to720 {
//    Pano *pan = [Pano new];
//    pan.imageName = @"innerHouse.jpg";
//     [ [self viewController] presentViewController:pan animated:NO completion:nil];
//
//}


- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



- (void)layoutSubviews {
    [super layoutSubviews];
  //   NSLog(@"%@,%@", NSStringFromCGRect(self.closeBtn.frame),NSStringFromCGRect(self.imageV.frame));
    
    
}
- (void)animationWithLayer:(CALayer *)layer duration:(CGFloat)duration values:(NSArray *)values
{
    CAKeyframeAnimation *KFAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    KFAnimation.duration = duration;
    KFAnimation.removedOnCompletion = NO;
    KFAnimation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:values.count];
    for (NSUInteger i = 0; i<values.count; i++) {
        CGFloat scaleValue = [values[i] floatValue];
        [valueArr addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleValue, scaleValue, scaleValue)]];
    }
    KFAnimation.values = valueArr;
    KFAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    layer.anchorPoint = CGPointMake(0.5, 0);
    [layer addAnimation:KFAnimation forKey:nil];
}


- (void)close {
    [self animationWithLayer:self.imageV.layer duration:0.3 values:@[@1.0, @0.66, @0.33, @0.01]];
    typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *view in weakSelf.subviews) {
            [view removeFromSuperview];
        }
        weakSelf.imageV = nil;
        [weakSelf removeFromSuperview];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self close];
//    CGPoint currentPoint = [[touches anyObject] locationInView:self.imageV];
//    if (CGRectContainsPoint(self.imageV.frame, currentPoint)) {
//        return;
//    }
//    [self animationWithLayer:self.imageV.layer duration:0.3 values:@[@1.0, @0.66, @0.33, @0.01]];
//     typeof(self) weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf removeFromSuperview];
//    });
}

@end
