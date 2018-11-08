//
//  HaiController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/23.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "HaiController.h"

@interface HaiController ()
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
@property (nonatomic, strong) NSTimer *time3;
@property (nonatomic, assign) NSInteger num3;
@property (nonatomic, strong) NSTimer *time4;
@property (nonatomic, assign) NSInteger num4;
@property (nonatomic, strong) NSTimer *time5;
@property (nonatomic, assign) NSInteger num5;
@property (nonatomic, strong) NSTimer *time6;
@property (nonatomic, assign) NSInteger num6;
@property (nonatomic, strong) NSTimer *time7;
@property (nonatomic, assign) NSInteger num7;
@property (nonatomic, strong) NSTimer *logoTime;
@property (nonatomic, assign) NSInteger logoNum;
@property (nonatomic, strong) UIImageView *baseImageV;
@property (nonatomic, strong) UIImageView *baseRoundImageV;
@property (nonatomic, strong) UIImageView *airPortImageV;
@property (nonatomic, strong) UIImageView *haiImageV;
@property (nonatomic, strong) UIImageView *roadImageV;
@property (nonatomic, strong) UIImageView *wordsImageV;
@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) UIButton *autoBtn;
@end

@implementation HaiController

- (NSTimer *)time0 {
    if (_time0 == nil) {
        _time0 = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(baseImageVChange) userInfo:nil repeats:YES];
        self.num = 0;
    }
    return _time0;
}

- (NSTimer *)time1 {
    if (_time1 == nil) {
        _time1 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(baseRoundImageVChange) userInfo:nil repeats:YES];
        self.num1 = 0;
    }
    return _time1;
}

- (NSTimer *)time2 {
    if (_time2 == nil) {
        _time2 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(airPortImageVChange) userInfo:nil repeats:YES];
        self.num2 = 0;
    }
    return _time2;
}
- (NSTimer *)time3 {
    if (_time3 == nil) {
        _time3 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(haiImageVChange) userInfo:nil repeats:YES];
        self.num3 = 0;
    }
    return _time3;
}

- (NSTimer *)time4 {
    if (_time4 == nil) {
        _time4 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(roadImageVChange) userInfo:nil repeats:YES];
        self.num4 = 0;
    }
    return _time4;
}
- (NSTimer *)time5 {
    if (_time5 == nil) {
        _time5 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(wordsAirPortImageVChange) userInfo:nil repeats:YES];
        self.num5 = 0;
    }
    return _time5;
}

- (NSTimer *)time6 {
    if (_time6 == nil) {
        _time6 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(wordsHaiImageVChange) userInfo:nil repeats:YES];
        self.num6 = 0;
    }
    return _time6;
}
- (NSTimer *)time7 {
    if (_time7 == nil) {
        _time7 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(wordsRoadImageVChange) userInfo:nil repeats:YES];
        self.num7 = 0;
    }
    return _time7;
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
    self.btnImages = @[@"haiUpBtn_01",@"haiUpBtn_02",@"haiUpBtn_03",@"locationBtnSmall",@"haiDownBtn_01",@"haiDownBtn_02",@"haiDownBtn_03"];
    self.btnImageS = @[@"haiUpBtnS_01",@"haiUpBtnS_02",@"haiUpBtnS_03",@"locationBtnSmallS",@"haiDownBtnS_01",@"haiDownBtnS_02",@"haiDownBtnS_03"];
    [self addImageV];
    [self setupBtn];
}

- (void)addImageV {
    self.baseImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.baseImageV.image = [UIImage imageNamed:@"haiBase_0.jpg"];
    [self.view addSubview:self.baseImageV];
    self.roadImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.roadImageV.image = [UIImage imageNamed:@"haiRoad_0.png"];
    [self.view addSubview:self.roadImageV];
    self.haiImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.haiImageV.image = [UIImage imageNamed:@"haiHai_0.png"];
    [self.view addSubview:self.haiImageV];
    self.airPortImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.airPortImageV.image = [UIImage imageNamed:@"haiAirPort_0.png"];
    [self.view addSubview:self.airPortImageV];
    self.wordsImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.wordsImageV];
    
    self.baseRoundImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.baseRoundImageV.image = [UIImage imageNamed:@"haiRound_0.png"];
    [self.view addSubview:self.baseRoundImageV];
    
    self.logoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 900 * 0.5 * kW, 500 * 0.5 * kH)];
    self.logoImageV.image = [UIImage imageNamed:@"haiLogo_0.png"];
    [self.view addSubview:self.logoImageV];

}


- (void)setupBtn {
    self.upBtnArr = [NSMutableArray array];
    self.downBtnArr = [NSMutableArray array];
    for (int index = 0; index < 3; index++) {
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(2228 * 0.5 * kW + 110 *0.5 * kW * index, 90 * 0.5 * kH, 110 * 0.5 * kW, 225 * 0.5 * kH)];
        [btn1 setImage:[UIImage imageNamed:self.btnImages[index+4]] forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:self.btnImageS[index+4]] forState:UIControlStateSelected];
        btn1.tag = index;
        [self.downBtnArr addObject:btn1];
        [btn1 addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
        
        UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(2228 * 0.5 * kW + 110 * 0.5 * kW * index, 56 * 0.5 * kH, 110 * 0.5 * kW, 116 * 0.5 * kH)];
        [btn0 setImage:[UIImage imageNamed:self.btnImages[index]] forState:UIControlStateNormal];
        [btn0 setImage:[UIImage imageNamed:self.btnImageS[index]] forState:UIControlStateSelected];
        btn0.tag = index;
        [self.upBtnArr addObject:btn0];
        [btn0 addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn0];
    }
    self.autoBtn = [[UIButton alloc] initWithFrame:CGRectMake(2558 * 0.5 * kW , 56 * 0.5 * kH, 110 * 0.5 * kW, 116 * 0.5 * kH)];
    [self.autoBtn setImage:[UIImage imageNamed:self.btnImages[3]] forState:UIControlStateNormal];
    [self.autoBtn setImage:[UIImage imageNamed:self.btnImageS[3]] forState:UIControlStateSelected];
    [self.autoBtn addTarget:self action:@selector(autoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
   // [self autoBtnClick:self.autoBtn];
    [self.view addSubview:self.autoBtn];
    for (int index = 0; index < 2; index++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150 * 0.5 * kW + 405 * 0.5 * kW *index, 90 * 0.5 * kH, 338 * 0.5 * kW, 338 * 0.5 * kW)];
        btn.tag = index;
        [btn addTarget:self action:@selector(logoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)upBtnClick:(UIButton *)upBtn {
    if (upBtn != self.lastUpBtn) {
        [self playSoundEffect:@"effect" type:@"mp3"];
        upBtn.selected = YES;
        if ([_time5 isValid]) {
            [_time5 invalidate];
            _time5 = nil;
        }
        if ([_time6 isValid]) {
            [_time6 invalidate];
            _time6 = nil;
        }
        if ([_time7 isValid]) {
            [_time7 invalidate];
            _time7 = nil;
        }
        if (upBtn.tag == 0) {
             [self.view insertSubview:self.airPortImageV belowSubview:self.baseRoundImageV];
            self.airPortImageV.alpha = 1.0;
            self.haiImageV.alpha = 0.35;
            self.roadImageV.alpha = 0.35;
            [self.time5 fire];
        }else if(upBtn.tag == 1) {
            self.airPortImageV.alpha = 0.35;
            [self.view insertSubview:self.haiImageV belowSubview:self.baseRoundImageV];
            self.haiImageV.alpha = 1.0;
            self.roadImageV.alpha = 0.35;
            [self.time6 fire];
        }else {
            self.airPortImageV.alpha = 0.35;
            self.haiImageV.alpha = 0.35;
             [self.view insertSubview:self.roadImageV belowSubview:self.baseRoundImageV];
            self.roadImageV.alpha = 1.0;
             [self.time7 fire];
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
        downBtn.selected = YES;
        if ([_time5 isValid]) {
            [_time5 invalidate];
            _time5 = nil;
        }
        if ([_time6 isValid]) {
            [_time6 invalidate];
            _time6 = nil;
        }
        if ([_time7 isValid]) {
            [_time7 invalidate];
            _time7 = nil;
        }
        if (downBtn.tag == 0) {
            [self.view insertSubview:self.airPortImageV belowSubview:self.baseRoundImageV];
            self.airPortImageV.alpha = 1.0;
            self.haiImageV.alpha = 0.35;
            self.roadImageV.alpha = 0.35;
            [self.time5 fire];
        }else if(downBtn.tag == 1) {
            self.airPortImageV.alpha = 0.35;
             [self.view insertSubview:self.haiImageV belowSubview:self.baseRoundImageV];
            self.haiImageV.alpha = 1.0;
            self.roadImageV.alpha = 0.35;
            [self.time6 fire];
        }else {
            self.airPortImageV.alpha = 0.35;
            self.haiImageV.alpha = 0.35;
            [self.view insertSubview:self.roadImageV belowSubview:self.baseRoundImageV];
            self.roadImageV.alpha = 1.0;
            [self.time7 fire];
        }
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


- (void)btnClick:(UIButton *)btn {
    [self playSoundEffect:@"effect" type:@"mp3"];
    if ([self.delegate respondsToSelector:@selector(haiVcScrollToIndex:)]) {
        [self.delegate haiVcScrollToIndex:1];
    }
}


- (void)baseImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"haiBase_%ld.jpg",(long)self.num] ofType:nil];
    self.baseImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num ++;
    if (self.num > 50) {
        self.num = 0;
    }
}

- (void)baseRoundImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"haiRound_%ld.png",(long)self.num1] ofType:nil];
    self.baseRoundImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num1 ++;
    if (self.num1 > 100) {
        self.num1 = 50;
    }
}

- (void)airPortImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"haiAirPort_%ld.png",(long)self.num2] ofType:nil];
    self.airPortImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num2 ++;
    if (self.num2 > 180) {
        self.num2 = 70;
    }
}

- (void)haiImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"haiHai_%ld.png",(long)self.num3] ofType:nil];
    self.haiImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num3 ++;
    if (self.num3 > 140) {
        self.num3 = 90;
    }
}

- (void)roadImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"haiRoad_%ld.png",(long)self.num4] ofType:nil];
    self.roadImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num4 ++;
    if (self.num4 > 160) {
        self.num4 = 50;
    }
}

- (void)wordsAirPortImageVChange {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"haiAirPortWords_%ld.png",(long)self.num5] ofType:nil];
    self.wordsImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num5 ++;
    if (self.num5 > 90) {
        self.num5 = 50;
    }
}
- (void)wordsHaiImageVChange {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"haiHaiWords_%ld.png",(long)self.num6] ofType:nil];
    self.wordsImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num6 ++;
    if (self.num6 > 90) {
        self.num6 = 50;
    }
}

- (void)wordsRoadImageVChange {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"haiRoadWords_%ld.png",(long)self.num7] ofType:nil];
    self.wordsImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num7 ++;
    if (self.num7 > 90) {
        self.num7 = 50;
    }
}

- (void)logoImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"haiLogo_%ld.png",(long)self.logoNum] ofType:nil];
    self.logoImageV.image = [UIImage imageWithContentsOfFile:path];
    self.logoNum ++;
    if (self.logoNum > 90) {
        self.logoNum = 50;
    }
}

- (void)logoBtnClick:(UIButton *)btn {
    [self playSoundEffect:@"effect" type:@"mp3"];
    if ([self.delegate respondsToSelector:@selector(haiVcScrollToIndex:)]) {
        if (btn.tag == 0) {
            [self.delegate haiVcScrollToIndex:0];
        }else {
            [self.delegate haiVcScrollToIndex:2];
        }
    }
}

- (void)haiViewWillShow {
    [self.time0 fire];
    [self.time1 fire];
    [self.logoTime fire];
    [self.time2 fire];
    [self.time3 fire];
    [self.time4 fire];
    [self autoBtnClick:self.autoBtn];
    
}

- (void)haiViewWillHide {
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
    if ([_time3 isValid]) {
        [_time3 invalidate];
        _time3 = nil;
    }
    if ([_time4 isValid]) {
        [_time4 invalidate];
        _time4 = nil;
    }
    if ([_time5 isValid]) {
        [_time5 invalidate];
        _time5 = nil;
    }
    if ([_time6 isValid]) {
        [_time6 invalidate];
        _time6 = nil;
    }
    if ([_time7 isValid]) {
        [_time7 invalidate];
        _time7 = nil;
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
    self.haiImageV.alpha = 1.0;
    self.airPortImageV.alpha = 1.0;
    self.roadImageV.alpha = 1.0;
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
    if ([_time3 isValid]) {
        [_time3 invalidate];
        _time3 = nil;
    }
    if ([_time4 isValid]) {
        [_time4 invalidate];
        _time4 = nil;
    }
    if ([_time5 isValid]) {
        [_time5 invalidate];
        _time5 = nil;
    }
    if ([_time6 isValid]) {
        [_time6 invalidate];
        _time6 = nil;
    }
    if ([_time7 isValid]) {
        [_time7 invalidate];
        _time7 = nil;
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
