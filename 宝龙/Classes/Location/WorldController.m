//
//  WorldController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/23.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "WorldController.h"

@interface WorldController ()
@property (nonatomic, strong) NSArray *btnImages;
@property (nonatomic,strong) NSArray *btnImageS;
@property (nonatomic, strong) NSMutableArray *upBtnArr;
@property (nonatomic, strong) NSMutableArray *downBtnArr;
@property (nonatomic, strong) UIButton *lastUpBtn;
@property (nonatomic, strong) UIButton *lastDownBtn;
@property (nonatomic, strong) NSTimer *time0;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSTimer *time1;
@property (nonatomic, assign) NSInteger num1;
@property (nonatomic, strong) NSTimer *time2;
@property (nonatomic, assign) NSInteger num2;
@property (nonatomic, strong) NSTimer *logoTime;
@property (nonatomic, assign) NSInteger logoNum;
@property (nonatomic, strong) UIImageView *baseImageV;
@property (nonatomic, strong) UIImageView *secondImageV;
@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) UIButton *autoBtn;
@end

@implementation WorldController
- (NSTimer *)time0 {
    if (_time0 == nil) {
        _time0 = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(baseImageVChange) userInfo:nil repeats:YES];
        self.num = 0;
    }
    return _time0;
}

- (NSTimer *)time1 {
    if (_time1 == nil) {
        _time1 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(worldOneImageVChange) userInfo:nil repeats:YES];
        self.num1 = 0;
    }
    return _time1;
}

- (NSTimer *)time2 {
    if (_time2 == nil) {
        _time2 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(travleImageVChange) userInfo:nil repeats:YES];
        self.num2 = 0;
    }
    return _time2;
}

- (NSTimer *)logoTime {
    if (_logoTime == nil) {
        _logoTime = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(logoImageVChange) userInfo:nil repeats:YES];
        self.logoNum = 0;
    }
    return _logoTime;
}

-(CAAnimationGroup *)moveWithDistance:(double)distance WithValues:(NSArray *)values{
    CAAnimationGroup *group = [CAAnimationGroup new];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];///.y的话就向下移动。
    animation.toValue = [NSNumber numberWithDouble:distance];
    animation.duration = 1;
    
    CAKeyframeAnimation *opacityAnim = [[CAKeyframeAnimation alloc] init];
    opacityAnim.keyPath = @"opacity";
    opacityAnim.values = values;
    opacityAnim.duration = 1;
    group.animations = @[animation,opacityAnim];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.duration = 1;
    group.repeatCount = 1;
    //group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return group;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnImages = @[@"worldUpBtn-1",@"worldUpBtn-2",@"locationBtnSmall",@"worldDownBtn-1",@"worldDownBtn-2"];
    self.btnImageS = @[@"worldUpBtnS-1",@"worldUpBtnS-2",@"locationBtnSmallS",@"worldDownBtnS-1",@"worldDownBtnS-2"];
    [self addImageV];
    [self setupBtn];
    [self.time0 fire];
    [self.logoTime fire];
    
}

- (void)addImageV {
    self.baseImageV = [[UIImageView alloc] initWithFrame:kScreenBounds];
    self.baseImageV.image = [UIImage imageNamed:@"worldBase_0.jpg"];
    [self.view addSubview:self.baseImageV];
    self.secondImageV = [[UIImageView alloc] initWithFrame:kScreenBounds];
    self.secondImageV.image = [UIImage imageNamed:@"worldOne_0.png"];
    [self.view addSubview:self.secondImageV];
    self.logoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 900 * 0.5 * kW, 500 * 0.5 * kH)];
    self.logoImageV.image = [UIImage imageNamed:@"worldLogo_0.png"];
    [self.view addSubview:self.logoImageV];
    
//    self.time1 = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(worldOneImageVChange) userInfo:nil repeats:YES];
//    self.num1 = 0;
//    self.time2 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(travleImageVChange) userInfo:nil repeats:YES];
//    self.time2 = 0;
}


- (void)setupBtn {
    self.upBtnArr = [NSMutableArray array];
    self.downBtnArr = [NSMutableArray array];
    for (int index = 0; index < 2; index++) {
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(2338 * 0.5 * kW + 110 *0.5 * kW * index, 90 * 0.5 * kH, 110 * 0.5 * kW, 225 * 0.5 * kH)];
        [btn1 setImage:[UIImage imageNamed:self.btnImages[index+3]] forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:self.btnImageS[index+3]] forState:UIControlStateSelected];
        btn1.tag = index;
        [self.downBtnArr addObject:btn1];
        [btn1 addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
        
        UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(2338 * 0.5 * kW + 110 * 0.5 * kW * index, 56 * 0.5 * kH, 110 * 0.5 * kW, 116 * 0.5 * kH)];
        [btn0 setImage:[UIImage imageNamed:self.btnImages[index]] forState:UIControlStateNormal];
        [btn0 setImage:[UIImage imageNamed:self.btnImageS[index]] forState:UIControlStateSelected];
        btn0.tag = index;
        [self.upBtnArr addObject:btn0];
        [btn0 addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn0];
        if (index == 0) {
            [self upBtnClick:btn0];
        }
    }
    self.autoBtn = [[UIButton alloc] initWithFrame:CGRectMake(2558 * 0.5 * kW , 56 * 0.5 * kH, 110 * 0.5 * kW, 116 * 0.5 * kH)];
    [self.autoBtn setImage:[UIImage imageNamed:self.btnImages[2]] forState:UIControlStateNormal];
    [self.autoBtn setImage:[UIImage imageNamed:self.btnImageS[2]] forState:UIControlStateSelected];
    [self.autoBtn addTarget:self action:@selector(autoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self autoBtnClick:self.autoBtn];
    [self.view addSubview:self.autoBtn];
    
    for (int index = 0; index < 2; index++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150 * 0.5 * kW + 405 * 0.5 * kW *index, 90 * 0.5 * kH, 338 * 0.5 * kW, 338 * 0.5 * kW)];
      //  btn.backgroundColor = [UIColor redColor];
        btn.tag = index;
        [btn addTarget:self action:@selector(logoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)upBtnClick:(UIButton *)upBtn {
    if (upBtn != self.lastUpBtn) {
        [self playSoundEffect:@"effect" type:@"mp3"];
        if ([_time1 isValid]) {
            [_time1 invalidate];
            _time1 = nil;
        }
        if ([_time2 isValid]) {
            [_time2 invalidate];
            _time2 = nil;
        }
        upBtn.selected = YES;
        if (upBtn.tag == 0) {
            [self.time1 fire];
        }else {
            [self.time2 fire];
        }
        UIButton *btn = self.downBtnArr[upBtn.tag];
        if (btn.selected != YES) {
            btn.selected = YES;
        }
        if (self.lastUpBtn != nil) {
            self.lastUpBtn.selected = NO;
            UIButton *btn = self.downBtnArr[self.lastUpBtn.tag];
            if (btn.selected != NO) {
                btn.selected = NO;
            }
        }
        self.lastUpBtn = upBtn;
        self.lastDownBtn = self.downBtnArr[upBtn.tag];
    }
}


- (void)downBtnClick:(UIButton *)downBtn {
    if (downBtn != self.lastDownBtn) {
        [self playSoundEffect:@"effect" type:@"mp3"];
        if ([_time1 isValid]) {
            [_time1 invalidate];
            _time1 = nil;
        }
        if ([_time2 isValid]) {
            [_time2 invalidate];
            _time2 = nil;
        }
        downBtn.selected = YES;
        if (downBtn.tag == 0) {
            [self.time1 fire];
        }else {
            [self.time2 fire];
        }
        downBtn.selected = YES;
        UIButton *btn = self.upBtnArr[downBtn.tag];
        if (btn.selected != YES) {
            btn.selected = YES;
        }
        if (self.lastDownBtn != nil) {
            self.lastDownBtn.selected = NO;
            UIButton *btn = self.upBtnArr[self.lastDownBtn.tag];
            if (btn.selected != NO) {
                btn.selected = NO;
            }
        }
        self.lastDownBtn = downBtn;
        self.lastUpBtn = self.upBtnArr[downBtn.tag];
    }
}


- (void)autoBtnClick: (UIButton *)autoBtn {
    [self playSoundEffect:@"effect" type:@"mp3"];
    autoBtn.selected = !autoBtn.selected;
    if (autoBtn.selected == YES) {
        for (UIButton *btn in self.downBtnArr) {
            [btn.layer addAnimation:[self moveWithDistance:20 * 0.5 * kH WithValues:@[@0.3,@0.5,@0.7,@0.8,@0.9,@1.0]] forKey:nil];
        }
    }else if (autoBtn.selected == NO) {
        for (UIButton *btn in self.downBtnArr) {
             [btn.layer addAnimation:[self moveWithDistance:-20 * 0.5 * kH WithValues:@[@0.5,@0.4,@0.3,@0.2,@0.0]] forKey:nil];
        }
    }
}

- (void)baseImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"worldBase_%ld.jpg",(long)self.num] ofType:nil];
    self.baseImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num ++;
    if (self.num > 50) {
        self.num = 0;
    }
}

- (void)worldOneImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"worldOne_%ld.png",(long)self.num1] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num1 ++;
    if (self.num1 > 195) {
        self.num1 = 105;
    }
}

- (void)travleImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"worldTravel_%ld.png",(long)self.num2] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num2 ++;
    if (self.num2 > 160) {
        self.num2 = 110;
    }
}

- (void)logoImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"worldLogo_%ld.png",(long)self.logoNum] ofType:nil];
    self.logoImageV.image = [UIImage imageWithContentsOfFile:path];
    self.logoNum ++;
    if (self.logoNum > 90) {
        self.logoNum = 50;
    }
}

- (void)logoBtnClick:(UIButton *)btn {
    [self playSoundEffect:@"effect" type:@"mp3"];
    if ([self.delegate respondsToSelector:@selector(worldVcScrollToIndex:)]) {
        if (btn.tag == 0) {
            [self.delegate worldVcScrollToIndex:1];
        }else {
            [self.delegate worldVcScrollToIndex:2];
        }
    }
}

- (void)worldViewWillShow {
    [self.time0 fire];
    [self.logoTime fire];
    [self upBtnClick:self.upBtnArr[0]];
    [self autoBtnClick:self.autoBtn];

}

- (void)worldViewWillHide {
    if ([_time0 isValid]) {
        [_time0 invalidate];
        _time0 = nil;
    }
    if ([_time1 isValid]) {
        [_time1 invalidate];
        _time1 = nil;
    }
    if ([_time2 isValid]) {
        [_time2 invalidate];
        _time2 = nil;
    }
    if ([_logoTime isValid]) {
        [_logoTime invalidate];
        _logoTime = nil;
    }
    self.lastUpBtn = nil;
    self.lastDownBtn = nil;
    for (UIButton *btn in self.downBtnArr) {
        btn.selected = NO;
        [btn.layer removeAllAnimations];
    }
    for (UIButton *btn in self.upBtnArr) {
        btn.selected = NO;
    }
    self.autoBtn.selected = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([_time0 isValid]) {
        [_time0 invalidate];
        _time0 = nil;
    }
    if ([_time1 isValid]) {
        [_time1 invalidate];
        _time1 = nil;
    }
    if ([_time2 isValid]) {
        [_time2 invalidate];
        _time2 = nil;
    }
    
    if ([_logoTime isValid]) {
        [_logoTime invalidate];
        _logoTime = nil;
    }
    for (UIButton *btn in self.downBtnArr) {
        [btn.layer removeAllAnimations];
    }
}

- (void)dealloc {
    ZHYLogFunc;
}
@end
