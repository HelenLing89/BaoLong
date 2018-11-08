//
//  Circle3DView.m
//  circleMenu
//
//  Created by geek on 2018/8/7.
//  Copyright © 2018年 danzel. All rights reserved.
//

#import "Circle3DView.h"
#import "DragImageView.h"
#import "ThirdImageView.h"
#import "BaseImageView.h"

#define Circle_Radius 250.0
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define kScale [UIScreen mainScreen].bounds.size.width/1366.0

@interface Circle3DView()<UIGestureRecognizerDelegate,CAAnimationDelegate>
@property (nonatomic, strong) UIImageView *bgImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat bgRotate;
@property (nonatomic, assign) CGFloat backRotate;
@property (nonatomic, strong) DragImageView *ImgView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture1;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *baseImageVArr;
@property (nonatomic, strong) NSMutableArray *tcImageArr;
@property (nonatomic, strong) NSMutableArray *tFImageArr;
@property (nonatomic, strong) NSArray *tlImageArr;
@property (nonatomic, strong) NSArray *tFllImageArr;
@property (nonatomic, strong) BaseImageView *lastSelectBaseImageV;
@property (nonatomic,strong) NSMutableArray * radiusArr;
@property (nonatomic,strong) UIButton *menuBtn;
@property (nonatomic,assign) NSInteger thirdSelectedTag;

@end
@implementation Circle3DView

@synthesize arrImages;
@synthesize baseImages;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        center1 = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
//        [self.bgImageV addSubview:_centerImgView];
//        _centerImgView.frame = self.bounds;
//        [self showImage];
       
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.bgImageV addSubview:_centerImgView];
        _centerImgView.frame = self.bounds;
     //   [self showImage];
    }
    return self;
}

- (void)loadView{
    if (arrImages.count > 0) {
     //   [self addGesture];
      //  [self.bgImageV addSubview:_centerImgView];
      //  _centerImgView.frame = self.bounds;
        //self.backgroundColor = [UIColor blueColor];
        [self addImage];
        [self addCenterBtn];
        [self addGesture];
        for (int index= 0; index < arrImages.count; index++) {
            [self showThirdImageVWithTag:index WithStatus:1];
        }
    }else{
        return;
    }
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"Menu";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:22];
        [_titleLabel sizeToFit];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)bgImageV {
    if (_bgImageV == nil) {
        _bgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 527 * 0.5 * kW, 527 * 0.5 * kW)];
        _bgImageV.center = center1;
        _bgImageV.transform = CGAffineTransformMakeRotation(1.0/6 *M_PI);
        _bgImageV.image = [UIImage imageNamed:@"底圆"];
        _bgImageV.userInteractionEnabled = YES;
       
      //  [self insertSubview:_bgImageV atIndex:0];
        
    }
    return _bgImageV;
}

+ (instancetype)initWithframe:(CGRect)frame values:(NSArray *)values {
    Circle3DView *view = [[self alloc] initWithFrame:frame];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureForCircle)];
    [view addGestureRecognizer:pan];
   // view.backgroundColor = [UIColor colorWithRed:45/255 green:62/255 blue:79/255 alpha:1];
  //  view.layer.cornerRadius = Circle_Radius/2;
//    view.layer.shadowOpacity = 0.7;
 //   view.layer.shadowOffset = CGSizeMake(0, -2);
    view.menuTitleValues = values;
    return view;
}

- (void)addCenterBtn {
    self.menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 186 * 0.5 * kW, 186 * 0.5 * kW)];
    [self  addSubview:self.menuBtn];
    self.menuBtn.center = center1;
   // CGRect frame = menuBtn.frame;
    //frame.origin.y = self.bgImageV.bounds.size.height - frame.size.height - 5;
    //frame.origin.x = self.bgImageV.bounds.size.width - frame.size.width/2;
   // menuBtn.frame = frame;
    [self.menuBtn setImage:[UIImage imageNamed:@"上圆"] forState:UIControlStateNormal];
    [self.menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.menuBtn.selected = YES;
    UIPanGestureRecognizer *longPress = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.menuBtn addGestureRecognizer:longPress];

}

- (void)longPress:(UIPanGestureRecognizer *)longPressGes {
    CGPoint gesPoint = [longPressGes locationInView:self.window];
    if (longPressGes.state == UIGestureRecognizerStateBegan) {
       
    }else if (longPressGes.state == UIGestureRecognizerStateChanged) {
        if (gesPoint.x > 0 && gesPoint.y > 0) {
             self.center = gesPoint;
        }
    }else if (longPressGes.state == UIGestureRecognizerStateEnded) {
        if (gesPoint.x > SCREEN_WIDTH * 0.9 && gesPoint.y > SCREEN_HEIGHT * 0.9){
            typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.1 animations:^{
                weakSelf.center = CGPointMake(SCREEN_WIDTH- 186 * 0.5 * 0.22 * kW, SCREEN_HEIGHT-186 * 0.5 * 0.22 * kW);
            }];
            CGFloat fRadina = [self.radiusArr[self.currentSelectedTag] floatValue];
            if ( fRadina != 2 * M_PI/5 * 3 && self.center.x == SCREEN_WIDTH- 186 * 0.5 * 0.22 * kW && self.center.y == SCREEN_HEIGHT-186 * 0.5 * 0.22 * kW) {
                CGFloat changeRadiu = 2 * M_PI/5 * 3 - fRadina;
                [UIView animateWithDuration:0.05 animations:^{
                    [weakSelf dragWithDifferentRadian:changeRadiu withisContains:YES];
                }];
            }
        }else {
            [self hideThirdImageView];
            [UIView animateWithDuration:0.5 animations:^{
                [self showThirdImagView];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void)menuBtnClick:(UIButton *)menuBtn {
    if (menuBtn.selected == YES) {
        menuBtn.selected = NO;
        [self dissmissImage];
    }else {
        menuBtn.selected = YES;
         [self showImage];
    }
}

- (void)addImage {
    [self insertSubview:self.bgImageV atIndex:0];
    self.bgImageV.alpha = 1.0;
    CGFloat fRadina;//与y轴的夹角
    average_radina = 2*M_PI/arrImages.count ;
    DragImageView *dragImageView = [arrImages objectAtIndex:0];
    CGFloat width = dragImageView.frame.size.width;
    CGFloat heigh = dragImageView.frame.size.height;
    //计算半径
    radius = MIN(self.bounds.size.width-250 * 0.5 * kW-width, self.bounds.size.height-heigh * kW- 250 * 0.5 * kW)/2.0 - 280 * 0.5 * kW ;
    self.imageArr = [NSMutableArray array];
    self.baseImageVArr = [NSMutableArray array];
   self.radiusArr = [NSMutableArray array];
    for (int i = 0; i < self.baseImages.count; i ++) {
        fRadina = [self getRadinaByRadian:i*average_radina];
        CGPoint point = [self getPointByRadian:fRadina centreOfCircle:center1 radiusOfCircle:radius];
        BaseImageView *baseImageV = [baseImages objectAtIndex:i];
        baseImageV.layer.anchorPoint = CGPointMake(0, 1);
        baseImageV.alpha = 0.0;
        baseImageV.center = center1;
        baseImageV.layer.transform = CATransform3DMakeRotation((M_PI - average_radina/2 - fRadina), 0, 0, 1);
       // CGAffineTransformMakeRotation(M_PI - average_radina/2 - fRadina);
        baseImageV.current_radian = fRadina;
        baseImageV.radian = fRadina;
        baseImageV.view_point = point;
        baseImageV.current_animation_radian = [self getAnimationRadianByRadian:fRadina];
        baseImageV.animation_radian = [self getAnimationRadianByRadian:fRadina];
        [self.baseImageVArr addObject:baseImageV];
        [self addSubview:baseImageV];
    }
    
    for (int i=0; i<arrImages.count; i++) {
        fRadina = [self getRadinaByRadian:i*average_radina];
        NSNumber *num = [NSNumber numberWithFloat:fRadina];
        [self.radiusArr addObject:num];
        CGPoint point = [self getPointByRadian:fRadina centreOfCircle:center1 radiusOfCircle:radius];
        DragImageView *imageview = [arrImages objectAtIndex:i];
        imageview.alpha = 1.0;
       // baseImageV.alpha = imageview.alpha;
        imageview.center = point;
        imageview.current_radian = fRadina;
        imageview.radian = fRadina;
        imageview.view_point = point;
        imageview.current_animation_radian = [self getAnimationRadianByRadian:fRadina];
        imageview.animation_radian = [self getAnimationRadianByRadian:fRadina];
        [self.imageArr addObject:imageview];
        [self addSubview:imageview];
    }
}

- (void)showImage {
    self.frame = CGRectMake(self.center.x - 625 * 0.5 * kW, self.center.y - 625 * 0.5 * kW, 1250 * 0.5 * kW, 1250 * 0.5 * kW);
    self.menuBtn.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    for (UIImageView *imageV in self.imageArr) {
        imageV.alpha = 1.0;
    }
    if (self.lastSelectBaseImageV != nil) {
        self.lastSelectBaseImageV.alpha = 1.0;
    }
//    if (self.tlImageArr.count != 0) {
//        for (UIImageView *imageV in self.tlImageArr) {
//            imageV.alpha = 1.0;
//        }
//    }
    [self showThirdImagView];
    self.bgImageV.alpha = 1.0;
    
  //  self.bgImageV.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseIn animations:^{
      //  self.bgImageV.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
//    typeof(self) weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        weakSelf.frame = CGRectMake(self.center.x - 600 * 0.5 * kScale, self.center.y - 600 * 0.5 * kScale, 1200 * 0.5 * kScale, 1200 * 0.5 * kScale);
//        weakSelf.menuBtn.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
//    });
    
}

- (void)dissmissImage {
   // _bgRotate = 0;
   // _backRotate = 0;
    [UIView animateWithDuration:0.3 animations:^{
        for (UIImageView *imageV in self.imageArr) {
            imageV.alpha = 0.0;
        }
        [self hideThirdImageView];
        self.lastSelectBaseImageV.alpha = 0.0;
        self.bgImageV.alpha = 0.0;
        
//        CGRect rect = self.frame;
//        rect.size = CGSizeMake(186 *0.5 * kScale, 186 * 0.5 * kScale);
//        self.frame = rect;
      //  self.transform = CGAffineTransformMakeScale(186/1200.0, 186/1200.0);
        
      //  self.bounds = CGRectMake(0, 0, 186 * 0.5 * kScale , 186 * 0.5 * kScale);
    } completion:^(BOOL finished) {
    }];
    typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.frame = CGRectMake(self.center.x - 93 * 0.5 * kW, self.center.y - 93 * 0.5 * kW, 186 * 0.5 * kW, 186 * 0.5 * kW);
        weakSelf.menuBtn.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    });
    
}

- (void)showThirdImagView{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        for (NSArray *array in self.thirdImages) {
            for (ThirdImageView *imageV in array) {
                imageV.transform = CGAffineTransformScale(imageV.transform, 100, 100);
            }
        }
        for (NSArray *array in self.forthImages) {
            for (ThirdImageView *imageV in array) {
                imageV.transform = CGAffineTransformScale(imageV.transform, 100, 100);
            }
        }
    } completion:nil];
}

- (void)hideThirdImageView {
    for (NSArray *array in self.thirdImages) {
        for (ThirdImageView *imageV in array) {
            imageV.transform = CGAffineTransformScale(imageV.transform, 0.01, 0.01);
        }
    }
    for (NSArray *array in self.forthImages) {
        for (ThirdImageView *imageV in array) {
            imageV.transform = CGAffineTransformScale(imageV.transform, 0.01, 0.01);
        }
    }
}


- (void)showThirdImageVWithTag:(NSInteger) selectedTag WithStatus:(NSInteger) status {
    NSArray *thirdImageVArr = self.thirdImages[selectedTag];
    NSArray *thirdSelectedRadius = self.thirdRadius[selectedTag];
    NSArray *forthSelectedRadius = self.forthRadius[selectedTag];
    NSArray *forthImageVArr = self.forthImages[selectedTag];

    //与y轴的夹角
    self.tcImageArr = [NSMutableArray array];
    self.tFImageArr = [NSMutableArray array];
    if (thirdImageVArr.count != 0) {
        CGFloat fRadina = [self.radiusArr[selectedTag] floatValue];
       // 0 : 大屏展示 1: 在右下角
        //当在右下角时, 选中的板块显示在屏幕上
        if (status == 1) {
            if ( fRadina != 2 * M_PI/6 * 4 && self.center.x == SCREEN_WIDTH- 179 * 0.5 * 0.22 * kW && self.center.y == SCREEN_WIDTH-179 * 0.5 * 0.22 * kW) {
                    CGFloat changeRadiu = 2 * M_PI/6 * 4 - fRadina;
                    [UIView animateWithDuration:0.05 animations:^{
                        [self dragWithDifferentRadian:changeRadiu withisContains:YES];
                    }];
                    fRadina = 2 * M_PI/5 * 4;
                   }
        }
        NSLog(@"%f",fRadina);
        CGFloat tRadina = fRadina - 1.0/6 * M_PI;
        for (int index = 0; index < thirdImageVArr.count; index++) {
            //三角形位置布局
            ThirdImageView *baseImageV = [thirdImageVArr objectAtIndex:index];
            baseImageV.layer.anchorPoint = CGPointMake(0, 1);
            baseImageV.alpha = 0.65;
            baseImageV.layer.transform = CATransform3DMakeRotation(-(([thirdSelectedRadius[index] floatValue]/180.0 * M_PI) + tRadina+ M_PI), 0, 0, 1);
            baseImageV.center = center1;
            baseImageV.current_radian = -(([thirdSelectedRadius[index] floatValue]/180.0 * M_PI) + tRadina+ M_PI);
            baseImageV.radian = -(([thirdSelectedRadius[index] floatValue]/180.0 * M_PI) + tRadina+ M_PI);
            baseImageV.current_animation_radian = [self getAnimationRadianByRadian:-(([thirdSelectedRadius[index] floatValue]/180.0 * M_PI) + tRadina+ M_PI)];
            baseImageV.animation_radian = [self getAnimationRadianByRadian:-(([thirdSelectedRadius[index] floatValue]/180.0 * M_PI) + tRadina+ M_PI)];
            [self.baseImageVArr addObject:baseImageV];
            //圆形位置布局
            ThirdImageView *forthImageV = [forthImageVArr objectAtIndex:index];
            forthImageV.alpha = 0.65;
            CGFloat radius = baseImageV.bounds.size.height * 0.85;
            CGPoint point = [self getPointByRadian:([forthSelectedRadius[index] floatValue]/180.0 * M_PI + tRadina) centreOfCircle:center1 radiusOfCircle:radius];
            forthImageV.center = point;
      
            forthImageV.current_radian = [forthSelectedRadius[index] floatValue]/180.0 * M_PI + tRadina;
            forthImageV.radian = [forthSelectedRadius[index] floatValue]/180.0 * M_PI + tRadina;
            forthImageV.current_animation_radian = [self getAnimationRadianByRadian:[forthSelectedRadius[index] floatValue]/180.0 * M_PI + tRadina];
            forthImageV.animation_radian = [self getAnimationRadianByRadian:[forthSelectedRadius[index] floatValue]/180.0 * M_PI + tRadina];
            forthImageV.view_point = point;
            forthImageV.current_animation_radian = [self getAnimationRadianByRadian:[forthSelectedRadius[index] floatValue]/180.0 * M_PI + tRadina];
            forthImageV.animation_radian = [self getAnimationRadianByRadian:[forthSelectedRadius[index] floatValue]/180.0 * M_PI + tRadina];
            if (index >= 3) {
                baseImageV.alpha = 0.0;
                forthImageV.alpha = 0.0;
            }
            [self insertSubview:baseImageV atIndex:0];
      //      [self.tcImageArr addObject:baseImageV];
      //      [self.tFImageArr addObject:forthImageV];
             [self addSubview:forthImageV];
        }
        
        //0 : 大屏展示 //1: 在右下角
//        if (status == 1) {
//           if ( fRadina != 2 * M_PI/5 * 3 && self.center.x == SCREEN_WIDTH- 179 * 0.5 * 0.22 * kScale && self.center.y == SCREEN_WIDTH-179 * 0.5 * 0.22 * kScale) {
//            CGFloat changeRadiu = 2 * M_PI/5 * 3 - fRadina;
//            [UIView animateWithDuration:0.05 animations:^{
//                [self dragWithDifferentRadian:changeRadiu withisContains:YES];
//            }];
//            fRadina = 2 * M_PI/5 * 3;
//           }
//           // NSNumber *num = [NSNumber numberWithFloat:fRadina];
//         //   [self.radiusArr replaceObjectAtIndex:3 withObject:num];
//        }
//        NSLog(@"%f",fRadina);
//
    for (ThirdImageView *imageV in self.tcImageArr) {
        imageV.transform = CGAffineTransformScale(imageV.transform, 0.1, 0.1);
    }
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseIn animations:^{
        for (ThirdImageView *imageV in self.tcImageArr) {
            imageV.transform = CGAffineTransformScale(imageV.transform, 10, 10);
        }

    } completion:^(BOOL finished) {
    }];
    }
//    if (self.tlImageArr.count != 0) {
//        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            for (UIImageView *imageV in weakSelf.tlImageArr) {
//                imageV.center = weakSelf.center;
//                [imageV removeFromSuperview];
//            }
//            for (UIImageView *imageV in weakSelf.tFllImageArr) {
//                imageV.center = weakSelf.center;
//                [imageV removeFromSuperview];
//            }
//        } completion:nil];
//    }
   //  self.tlImageArr = self.tcImageArr;
   //  self.tFllImageArr = self.tFImageArr;
}


- (void)showSubImagesWithSelectedTag:(NSInteger) selectedTag WithStatus:(NSInteger)status {
    BaseImageView *baseImageV = self.baseImageVArr[selectedTag];
    baseImageV.alpha = 1.0;
   self.thirdSelectedTag = 0;
    typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseIn animations:^{
        baseImageV.transform =  CGAffineTransformScale(baseImageV.transform, 1.0, 1.0);
        if (weakSelf.lastSelectBaseImageV != nil) {
            weakSelf.lastSelectBaseImageV.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        //  self.lastSelectBaseImageV.alpha = 0.0;
    }];
    self.lastSelectBaseImageV = baseImageV;
    NSArray *thirdImageVArr = self.thirdImages[selectedTag];
    NSArray *forthImageVArr = self.forthImages[selectedTag];
    CGFloat fRadina = [self.radiusArr[selectedTag] floatValue];
    if (status == 1) {
        NSLog(@"%@", NSStringFromCGPoint(self.center));
       if ( fRadina != 2 * M_PI/6 * 4 && self.center.x == SCREEN_WIDTH- 179 * 0.5 * 0.22 * kW && self.center.y == SCREEN_HEIGHT-179 * 0.5 * 0.22 * kW) {
        CGFloat changeRadiu = 2 * M_PI/6 * 4 - fRadina;
        [UIView animateWithDuration:0.05 animations:^{
            [self dragWithDifferentRadian:changeRadiu withisContains:YES];
        }];
       }
       // NSNumber *num = [NSNumber numberWithFloat:fRadina];
     //   [self.radiusArr replaceObjectAtIndex:3 withObject:num];
    }
 //   NSLog(@"%f",fRadina);
    if (selectedTag == 1) {
        ThirdImageView *imageV  = forthImageVArr[0];
        CGFloat tRadina = fRadina - 1.0/6 * M_PI;
        CGFloat originalRadian = [self.forthRadius[1][0] floatValue] / 180.0 * M_PI +tRadina;
        if (imageV.current_radian != originalRadian ) {
            CGFloat changeRadia = originalRadian - imageV.current_radian;
            [self dragWithDifferentRadian:changeRadia withisContains:NO];
        }
    }
    for (ThirdImageView *imageV in thirdImageVArr) {
        imageV.transform = CGAffineTransformScale(imageV.transform, 0.1, 0.1);
    }
    for (ThirdImageView *imageV in forthImageVArr) {
        imageV.transform = CGAffineTransformScale(imageV.transform, 0.1, 0.1);
    }
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        for (ThirdImageView *imageV in thirdImageVArr) {
             imageV.transform = CGAffineTransformScale(imageV.transform, 10, 10);
        }
        for (ThirdImageView *imageV in forthImageVArr) {
            imageV.transform = CGAffineTransformScale(imageV.transform, 10, 10);
        }
    } completion:nil];

}

- (void)addGesture {
//    _panGesture1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSinglePan1:)];
//    _panGesture1.delegate = self;
//    [self addGestureRecognizer:_panGesture1];
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSinglePan:)];
    _panGesture.delegate = self;
    [self addGestureRecognizer:_panGesture];
}

//计算线与y轴的夹角,确保在0～2*M_PI之间
- (CGFloat)getRadinaByRadian:(CGFloat)radian {
    if(radian > 2 * M_PI)//floorf表示不大于该数的最大整数
        return (radian - floorf(radian / (2.0f * M_PI)) * 2.0f * M_PI);
    
    if(radian < 0.0f)//ceilf表示不小于于该数的最小整数
        return (2.0f * M_PI + radian - ceilf(radian / (2.0f * M_PI)) * 2.0f * M_PI);
    
    return radian;
}

//根据夹角（与y轴），中心点，半径就出点坐标
- (CGPoint)getPointByRadian:(CGFloat)radian centreOfCircle:(CGPoint)circle_point radiusOfCircle:(CGFloat)circle_radius {
    CGFloat c_x = sinf(radian) * circle_radius + circle_point.x;
    CGFloat c_y = cosf(radian) * circle_radius + circle_point.y;
    return CGPointMake(c_x, c_y);
}

//根据和y轴的夹角换算成与x轴的夹角用于拖动后旋转
- (CGFloat)getAnimationRadianByRadian:(CGFloat)radian {
    CGFloat an_r = 2.0f * M_PI -  radian + M_PI_2;
    if(an_r < 0.0f)
        an_r =  - an_r;
    return an_r;
}

//手势操作
- (void)handleSinglePan:(id)sender {
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
    BOOL isContains = NO;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            pointDrag = [panGesture locationInView:self];
            
          //  isContains? @"YES" : @"NO";
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {   CGPoint pointMove = [panGesture locationInView:self];
           // NSLog(@"%@,%@",NSStringFromCGPoint(pointMove), NSStringFromCGRect(self.bgImageV.frame));
            isContains = [self point:pointDrag inCircleRect:self.bgImageV.frame];
            //NSLog(@"%@", isContains? @"YES" : @"NO");
            [self dragPoint:pointDrag movePoint:pointMove centerPoint:center1 withIsContains:isContains];
            pointDrag = pointMove;
        }
            break;
        case UIGestureRecognizerStateEnded:{
            
            CGPoint pointMove = [panGesture locationInView:self];
            
            //            [self dragPoint:pointDrag movePoint:pointMove centerPoint:center];
            //            [self reviseCirclePoint];
            [self changeBack:pointMove];
        }
            break;
        case UIGestureRecognizerStateFailed:{
            CGPoint pointMove = [panGesture locationInView:self];
            [self dragPoint:pointDrag movePoint:pointMove centerPoint:center1 withIsContains:isContains];
            [self reviseCirclePoint];
        }
            break;
        default:
            break;
    }
}


//圆心到点的距离>?半径
- (BOOL)point:(CGPoint)point inCircleRect:(CGRect)rect {
    CGFloat radius = rect.size.width/2.0;
    //CGPoint center = CGPointMake(rect.origin.x + radius, rect.origin.y + radius);
    double dx = fabs(point.x - center1.x);
    double dy = fabs(point.y - center1.y);
    double dis = sqrt(dx*dx + dy*dy);
    //NSLog(@"%@,%@",NSStringFromCGPoint(point),NSStringFromCGPoint(center));
    return dis <= radius;
}


//随着拖动改变子view位置，子view与y轴的夹角，子view与x轴的夹角
- (void)dragPoint:(CGPoint)dragPoint movePoint:(CGPoint)movePoint centerPoint:(CGPoint)centerPoint withIsContains:(BOOL)isContains {
    CGFloat drag_radian   = [self schAtan2f:dragPoint.x - centerPoint.x theB:dragPoint.y - centerPoint.y];
    CGFloat move_radian   = [self schAtan2f:movePoint.x - centerPoint.x theB:movePoint.y - centerPoint.y];
    CGFloat change_radian = (move_radian - drag_radian);
    [self dragWithDifferentRadian:change_radian withisContains:isContains];
}

- (void)dragWithDifferentRadian:(CGFloat)change_radian withisContains:(BOOL)isContains {
    if (isContains == NO) {
        NSArray *fortharray = self.forthImages[self.currentSelectedTag];
        NSArray *thirdArray = self.thirdImages[self.currentSelectedTag];
        CGFloat radiu = [self.radiusArr[self.currentSelectedTag] floatValue];
        CGFloat upRadiu = radiu - 1.0/6 * M_PI + 6.0/180.0 *M_PI;
        CGFloat downRadiu = radiu + 1.0/6 *M_PI;
        if (thirdArray.count > 3) {
            ThirdImageView *imageV = fortharray[0];
            if ((imageV.current_radian+change_radian) > radiu - 1.0 / 6 * M_PI  + 11.5 /180.0 * M_PI) {
                    return;
                }
            ThirdImageView *imageV1 = fortharray[fortharray.count -1];
            if ((imageV1.current_radian+change_radian) <= radiu - 1.0 / 6 * M_PI + 49/180.0 * M_PI) {
                return;
            }
            for (int i=0; i<fortharray.count; i++) {
                ThirdImageView *imageview = [thirdArray objectAtIndex:i];
                imageview.center = [self getPointByRadian:(imageview.current_radian+change_radian) centreOfCircle:center1 radiusOfCircle:tradius];
                imageview.current_radian = [self getRadinaByRadian:imageview.current_radian + change_radian];
                imageview.current_animation_radian = [self getAnimationRadianByRadian:imageview.current_radian];
                imageview.transform = CGAffineTransformRotate(imageview.transform, -change_radian);
                 //   CATransform3DRotate(imageV.transform, -change_radian,0 ,0, 1);
                ThirdImageView *imageview1 = [fortharray objectAtIndex:i];
                CGFloat rF= imageview.bounds.size.height * 0.85;
                imageview1.center = [self getPointByRadian:(imageview1.current_radian+change_radian) centreOfCircle:center1 radiusOfCircle:rF];
                imageview1.current_radian = [self getRadinaByRadian:imageview1.current_radian + change_radian];
                imageview1.current_animation_radian = [self getAnimationRadianByRadian:imageview1.current_radian];
                
                if (imageview1.alpha == 1.0) {
                    self.thirdSelectedTag= imageview1.tag;
                }
               
                if (imageview1.current_radian < upRadiu || imageview1.current_radian > downRadiu) {
                        imageview.alpha = 0.0;
                        imageview1.alpha = 0.0;
                }else {
                    if (imageview1.tag == self.thirdSelectedTag) {
                        imageview1.alpha = 1.0;
                        imageview.alpha = 1.0;
                    }else {
                        imageview.alpha = 0.65;
                        imageview1.alpha = 0.65;
                }
                }
        }
        }
    }else {
        for (int i=0; i<arrImages.count; i++) {
            DragImageView *imageview = [arrImages objectAtIndex:i];
            // BaseImageView *baseImageV = [baseImages objectAtIndex:i];
            imageview.center = [self getPointByRadian:(imageview.current_radian+change_radian) centreOfCircle:center1 radiusOfCircle:radius];
            //   baseImageV.center = imageview.center;
            imageview.current_radian = [self getRadinaByRadian:imageview.current_radian +change_radian];
            //  baseImageV.current_radian = imageview.current_radian;
            imageview.current_animation_radian = [self getAnimationRadianByRadian:imageview.current_radian];
            // baseImageV.current_animation_radian = imageview.current_animation_radian;
            [self.radiusArr replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:imageview.current_radian]];
        }

        for (int index = 0; index < self.thirdImages.count; index++) {
            NSArray *array = self.thirdImages[index];
            NSArray *forthArray = self.forthImages[index];
            for (int i=0; i<array.count; i++) {
                ThirdImageView *imageview = [array objectAtIndex:i];
                imageview.center = [self getPointByRadian:(imageview.current_radian+change_radian) centreOfCircle:center1 radiusOfCircle:tradius];
                imageview.current_radian = [self getRadinaByRadian:imageview.current_radian + change_radian];
                imageview.current_animation_radian = [self getAnimationRadianByRadian:imageview.current_radian];
                
                ThirdImageView *imageview1 = [forthArray objectAtIndex:i];
                CGFloat rF= imageview.bounds.size.height * 0.85;
                imageview1.center = [self getPointByRadian:(imageview1.current_radian+change_radian) centreOfCircle:center1 radiusOfCircle:rF];
                imageview1.current_radian = [self getRadinaByRadian:imageview1.current_radian + change_radian];
                imageview1.current_animation_radian = [self getAnimationRadianByRadian:imageview1.current_radian];
            }
        }
        //对UIImageView的旋转
        for (UIImageView *imageV in self.baseImageVArr) {
            imageV.layer.transform = CATransform3DRotate(imageV.layer.transform, -change_radian,0 ,0, 1);
        }
        self.bgImageV.layer.transform = CATransform3DRotate(self.bgImageV.layer.transform, -change_radian,0 ,0, 1);
        //按Z轴旋转
        CABasicAnimation *FlipAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        FlipAnimation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        //旋转按弧度M_PI
        FlipAnimation.fromValue = [NSNumber numberWithFloat:-_bgRotate];
        FlipAnimation.toValue= [NSNumber numberWithFloat:-(_bgRotate +change_radian)];
        // NSLog(@"%f,%f",_bgRotate, change_radian);
        FlipAnimation.duration=0;
        //旋转后保持状态
        FlipAnimation.fillMode=kCAFillModeForwards;
        FlipAnimation.removedOnCompletion = NO;
        //  [_bgImageV.layer addAnimation:FlipAnimation forKey:@"flip"];
        //[baseImageV.layer addAnimation:FlipAnimation forKey:@"flip"];
        _bgRotate += change_radian;
    }
}


//计算schAtan值
- (CGFloat)schAtan2f:(CGFloat)a theB:(CGFloat)b {
    CGFloat rd = atan2f(a,b);
    
    if(rd < 0.0f) {
        rd = M_PI * 2 + rd;
    }
    return rd;
}

//旋转结束后滑动到指定位置
- (void)reviseCirclePoint {
    BOOL isClockwise;
    DragImageView *imageviewFirst = [arrImages objectAtIndex:0];
    CGFloat temp_value = [self getRadinaByRadian:imageviewFirst.current_radian]/average_radina;
    NSInteger iCurrent = (NSInteger)(floorf(temp_value));
    temp_value = temp_value - floorf(temp_value);
    
    step = iCurrent;
    if (temp_value > 0.5f) {//超过半个弧度
        isClockwise = NO;
        step ++;
    }else{
        isClockwise = YES;
    }
    
    for (int i=0; i<arrImages.count; i++) {
        NSInteger iDest = i+step;
        if (iDest >= arrImages.count) {
            iDest = iDest%arrImages.count;
        }
        [self animateWithDuration:0.25f * (temp_value/average_radina)  animateDelay:0.0f changeIndex:i toIndex:iDest circleArray:arrImages clockwise:isClockwise];
    }
    //NSLog(@"%ld %lf, ",(long)step,temp_value);
    //按Z轴旋转
    CABasicAnimation *FlipAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    FlipAnimation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //旋转按弧度M_PI
    FlipAnimation.fromValue = [NSNumber numberWithFloat:-_bgRotate ];
    FlipAnimation.toValue= [NSNumber numberWithFloat:-_backRotate - _bgRotate];
    FlipAnimation.duration=0;
    //旋转后保持状态
    FlipAnimation.fillMode=kCAFillModeForwards;
    FlipAnimation.removedOnCompletion = NO;
    [_bgImageV.layer addAnimation:FlipAnimation forKey:@"flip"];
    _bgRotate = _backRotate + _bgRotate;
}

//平衡动画
- (void)animateWithDuration:(CGFloat)time animateDelay:(CGFloat)delay changeIndex:(NSInteger)change_index toIndex:(NSInteger)to_index circleArray:(NSMutableArray *)array clockwise:(BOOL)is_clockwise {
    DragImageView *change_cell = [array objectAtIndex:change_index];
    DragImageView *to_cell = [array objectAtIndex:to_index];
    
    /*圆*/
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:[NSString stringWithFormat:@"position"]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,change_cell.layer.position.x,change_cell.layer.position.y);
    
    int clockwise = is_clockwise?0:1;
    
   // CGPathAddArc(path,nil,center.x, center.y, /*圆心*/ radius,   /*半径*/change_cell.current_animation_radian, to_cell.animation_radian, /*弧度改变*/clockwise);
    //NSLog(@",,%lf,,%lf",change_cell.current_animation_radian,to_cell.animation_radian);
    _backRotate = (change_cell.current_animation_radian - to_cell.animation_radian > 5 || to_cell.animation_radian - change_cell.current_animation_radian > 5) ? _backRotate : change_cell.current_animation_radian - to_cell.animation_radian;
    animation.path = path;
    CGPathRelease(path);
    animation.fillMode            = kCAFillModeForwards;
    animation.repeatCount         = 1;
    animation.removedOnCompletion = NO;
    animation.calculationMode     = @"paced";
    
    /*动画组合*/
    CAAnimationGroup *anim_group  = [CAAnimationGroup animation];
    anim_group.animations          = [NSArray arrayWithObjects:animation, nil];
    anim_group.duration            = time + delay;
    anim_group.delegate            = self;
    anim_group.fillMode            = kCAFillModeForwards;
    anim_group.removedOnCompletion = NO;
    
    [change_cell.layer addAnimation:anim_group forKey:[NSString stringWithFormat:@"anim_group_%ld",(long)change_index]];
    
    /*改变属性*/
    change_cell.current_animation_radian = to_cell.animation_radian;
    change_cell.current_radian = to_cell.radian;
}

#pragma mark -
#pragma mark - animation delegate

- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    for (int i = 0; i < arrImages.count; ++i)
    {
        NSInteger iDest = i+step;
        if (iDest >= arrImages.count) {
            iDest = iDest%arrImages.count;
        }
        DragImageView *change_cell = [arrImages objectAtIndex:i];
        
        DragImageView *to_cell     = [arrImages objectAtIndex:iDest];
        
        [change_cell.layer removeAllAnimations];
        
        change_cell.center  = to_cell.view_point;
    }
}

-(void)changeBack:(CGPoint)point {
  // _ImgView.image = [UIImage imageNamed:_ImgView.imgName];
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *fitView = [super hitTest:point withEvent:event];
//    NSLog(@"%@",fitView);
//    if ([fitView isKindOfClass:[DragImageView class]]) {
//        _ImgView = (DragImageView *)fitView;
//        _ImgView.image = [UIImage imageNamed:_ImgView.selectImgName];
//    }
//    return fitView;
//}



@end
