//
//  ItemController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/23.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "ItemController.h"

@interface ItemController ()
@property (nonatomic, strong) NSArray *btnImages;
@property (nonatomic,strong) NSArray *btnImageS;
@property (nonatomic, strong) NSMutableArray *upBtnArr;
@property (nonatomic, strong) NSMutableArray *downBtnArr;
@property (nonatomic, strong) UIButton *lastUpBtn;
@property (nonatomic, strong) UIButton *lastDownBtn;
@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) UIImageView *secondImageV;
@property (nonatomic, strong) UIImageView *baseImageV;
@property (nonatomic, strong) UIImageView *contentBaseImageV;
@property (nonatomic, strong) UIImageView *contentClickImageV;
@property (nonatomic, strong) UIButton *contentClickBtn;
@property (nonatomic, strong) NSArray *timeArr;
@property (nonatomic, strong) NSTimer *logoTime;
@property (nonatomic, assign) NSInteger logoNum;
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
@property (nonatomic, strong) NSTimer *time8;
@property (nonatomic, assign) NSInteger num8;
@property (nonatomic, strong) NSTimer *time9;
@property (nonatomic, assign) NSInteger num9;
@property (nonatomic, strong) NSTimer *time10;
@property (nonatomic, assign) NSInteger num10;
@property (nonatomic, strong) UIButton *autoBtn;
@end

@implementation ItemController

- (NSTimer *)logoTime {
    if (_logoTime == nil) {
        _logoTime = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(logoImageVChange) userInfo:nil repeats:YES];
        self.logoNum = 0;
    }
    return _logoTime;
}
//城市布局
- (NSTimer *)time0 {
    if (_time0 == nil) {
        _time0 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(cityImageVChange) userInfo:nil repeats:YES];
        self.num = 0;
    }
    return _time0;
}
//交通规划
- (NSTimer *)time1 {
    if (_time1 == nil) {
        _time1 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(trafficImageVChange) userInfo:nil repeats:YES];
        self.num1 = 0;
    }
    return _time1;
}
//项目内容底
- (NSTimer *)time2 {
    if (_time2 == nil) {
        _time2 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(contentBaseImageVChange) userInfo:nil repeats:YES];
        self.num2 = 0;
    }
    return _time2;
}
//星级酒店
- (NSTimer *)time3 {
    if (_time3 == nil) {
        _time3 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(hotelImageVChange) userInfo:nil repeats:YES];
        self.num3 = 0;
    }
    return _time3;
}
//绿色生态
- (NSTimer *)time4 {
    if (_time4 == nil) {
        _time4 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(zoologyImageVChange) userInfo:nil repeats:YES];
        self.num4 = 0;
    }
    return _time4;
}
//休闲娱乐
- (NSTimer *)time5 {
    if (_time5 == nil) {
        _time5 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(leisureImageVChange) userInfo:nil repeats:YES];
        self.num5 = 0;
    }
    return _time5;
}
//医疗教育
- (NSTimer *)time6 {
    if (_time6 == nil) {
        _time6 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(medicalImageVChange) userInfo:nil repeats:YES];
        self.num6 = 0;
    }
    return _time6;
}
//市政金融
- (NSTimer *)time7 {
    if (_time7 == nil) {
        _time7 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(financialImageVChange) userInfo:nil repeats:YES];
        self.num7 = 0;
    }
    return _time7;
}
//项目内容内容
- (NSTimer *)time8 {
    if (_time8 == nil) {
        _time8 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(contentImageVChange) userInfo:nil repeats:YES];
        self.num8 = 0;
    }
    return _time8;
}
//项目内容点击
- (NSTimer *)time9 {
    if (_time9 == nil) {
        _time9 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(contentClickImageVChange) userInfo:nil repeats:YES];
        self.num9 = 0;
    }
    return _time9;
}

//底
- (NSTimer *)time10 {
    if (_time10 == nil) {
        _time10 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(baseImageVChange) userInfo:nil repeats:YES];
        self.num10 = 0;
    }
    return _time10;
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
    self.btnImages = @[@"itemUpBtn_01",@"itemUpBtn_02",@"itemUpBtn_03",@"itemUpBtn_04",@"itemUpBtn_05",@"itemUpBtn_06",@"itemUpBtn_07",@"itemUpBtn_08",@"locationBtnSmall",@"itemDownBtn_01",@"itemDownBtn_02",@"itemDownBtn_03",@"itemDownBtn_04",@"itemDownBtn_05",@"itemDownBtn_06",@"itemDownBtn_07",@"itemDownBtn_08"];
    self.btnImageS = @[@"itemUpBtnS_01",@"itemUpBtnS_02",@"itemUpBtnS_03",@"itemUpBtnS_04",@"itemUpBtnS_05",@"itemUpBtnS_06",@"itemUpBtnS_07",@"itemUpBtnS_08",@"locationBtnSmallS",@"itemDownBtnS_01",@"itemDownBtnS_02",@"itemDownBtnS_03",@"itemDownBtnS_04",@"itemDownBtnS_05",@"itemDownBtnS_06",@"itemDownBtnS_07",@"itemDownBtnS_08"];
   
    [self addImageV];
    [self setupBtn];
}

- (void)addImageV {
    self.baseImageV = [[UIImageView alloc] initWithFrame:kScreenBounds];
    self.baseImageV.image = [UIImage imageNamed:@"itemBase_0.jpg"];
    [self.view addSubview:self.baseImageV];
    self.logoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 900 * 0.5 * kW, 500 * 0.5 * kH)];
    self.logoImageV.image = [UIImage imageNamed:@"itemLogo_0.png"];
    [self.view addSubview:self.logoImageV];
    self.contentBaseImageV = [[UIImageView alloc] initWithFrame:kScreenBounds];
    self.contentBaseImageV.backgroundColor = kARGBColor(0.5, 0, 0,0);
    [self.view addSubview:self.contentBaseImageV];
    self.secondImageV = [[UIImageView alloc] initWithFrame:kScreenBounds];
    [self.view addSubview:self.secondImageV];
    self.contentClickBtn = [[UIButton alloc] initWithFrame:CGRectMake(1600 * 0.5 * kW, 1000 * 0.5 * kH, 230 * 0.5 * kW, 160 * 0.5 * kH)];
    self.contentClickBtn.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
    self.contentClickBtn.alpha = 0.0;
    [self.contentClickBtn addTarget:self action:@selector(contentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.contentClickBtn];
    self.contentClickImageV = [[UIImageView alloc] initWithFrame:kScreenBounds];
    self.contentClickImageV.backgroundColor = kARGBColor(0.5, 0, 0,0);
    [self.view addSubview:self.contentClickImageV];
    
}

- (void)setupBtn {
    self.upBtnArr = [NSMutableArray array];
    self.downBtnArr = [NSMutableArray array];
    for (int index = 0; index < 8; index++) {
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(1678 * 0.5 * kW + 110 *0.5 * kW * index, 90 * 0.5 * kH, 110 * 0.5 * kW, 225 * 0.5 * kH)];
        [btn1 setImage:[UIImage imageNamed:self.btnImages[index+9]] forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:self.btnImageS[index+9]] forState:UIControlStateSelected];
        btn1.tag = index;
        [self.downBtnArr addObject:btn1];
        [btn1 addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
        
        UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(1678 * 0.5 * kW + 110 * 0.5 * kW * index, 56 * 0.5 * kH, 110 * 0.5 * kW, 116 * 0.5 * kH)];
        [btn0 setImage:[UIImage imageNamed:self.btnImages[index]] forState:UIControlStateNormal];
        [btn0 setImage:[UIImage imageNamed:self.btnImageS[index]] forState:UIControlStateSelected];
        btn0.tag = index;
        [self.upBtnArr addObject:btn0];
        [btn0 addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn0];
//        if (index == 0) {
//            [self upBtnClick:btn0];
//        }
    }
    self.autoBtn = [[UIButton alloc] initWithFrame:CGRectMake(2558 * 0.5 * kW , 56 * 0.5 * kH, 110 * 0.5 * kW, 116 * 0.5 * kH)];
    [self.autoBtn setImage:[UIImage imageNamed:self.btnImages[8]] forState:UIControlStateNormal];
    [self.autoBtn setImage:[UIImage imageNamed:self.btnImageS[8]] forState:UIControlStateSelected];
    [self.autoBtn addTarget:self action:@selector(autoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
        self.contentBaseImageV.alpha = 0.0;
        self.contentClickImageV.alpha = 0.0;
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
        if ([_time8 isValid]) {
            [_time8 invalidate];
            _time8 = nil;
        }
        
        if ([_time9 isValid]) {
            [_time9 invalidate];
            _time9 = nil;
        }
        
        NSInteger tag= upBtn.tag;
        if (tag == 0) {
            [self.time0 fire];
        }else if (tag == 1) {
            [self.time1 fire];
        }else if (tag == 2) {
             self.contentBaseImageV.alpha = 1.0;
            [self.time2 fire];
        }else if (tag == 3) {
             [self.time3 fire];
        }else if (tag == 4) {
            [self.time4 fire];
        }else if (tag == 5) {
            [self.time5 fire];
        }else if (tag == 6) {
            [self.time6 fire];
        }else if (tag == 7) {
            [self.time7 fire];
        }
        UIButton *btn = self.downBtnArr[tag];
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
        self.contentBaseImageV.alpha = 0.0;
        self.contentClickImageV.alpha = 0.0;
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
        if ([_time8 isValid]) {
            [_time8 invalidate];
            _time8 = nil;
        }
        
        if ([_time9 isValid]) {
            [_time9 invalidate];
            _time9 = nil;
        }
        NSInteger tag= downBtn.tag;
        if (tag == 0) {
            [self.time0 fire];
        }else if (tag == 1) {
            [self.time1 fire];
        }else if (tag == 2) {
            self.contentBaseImageV.alpha = 1.0;
            [self.time2 fire];
        }else if (tag == 3) {
            [self.time3 fire];
        }else if (tag == 4) {
            [self.time4 fire];
        }else if (tag == 5) {
            [self.time5 fire];
        }else if (tag == 6) {
            [self.time6 fire];
        }else if (tag == 7) {
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


- (void)logoImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemLogo_%ld.png",(long)self.logoNum] ofType:nil];
    self.logoImageV.image = [UIImage imageWithContentsOfFile:path];
    self.logoNum ++;
    if (self.logoNum > 90) {
        self.logoNum = 50;
    }
}

- (void)cityImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemCity_%ld.png",(long)self.num] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num ++;
    if (self.num > 140) {
        self.num = 80;
    }
    
    
}
- (void)trafficImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemTraffic_%ld.png",(long)self.num1] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num1 ++;
    if (self.num1 > 180) {
        self.num1 = 120;
    }
}

- (void)contentBaseImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemContentParcel_%ld.png",(long)self.num2] ofType:nil];
    self.contentBaseImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num2 ++;
    if (self.num2 == 10) {
        if (_time8 == nil) {
            self.contentClickBtn.alpha = 1.0;
            [self.time8 fire];
        }
    }
    if (self.num2 > 70) {
        self.num2 = 10;
    }
}

- (void)contentImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemContent_%ld.png",(long)self.num8] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num8 ++;
    if (self.num8 > 145) {
        self.num8 = 95;
    }
}

- (void)contentClickImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemContentClick_%ld.png",(long)self.num9] ofType:nil];
    self.contentClickImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num9 ++;
    if (self.num9 > 169) {
        self.num9 = 110;
    }
}

- (void)hotelImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemHotel_%ld.png",(long)self.num3] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num3 ++;
    if (self.num3 > 135) {
        self.num3 = 85;
    }
}

- (void)zoologyImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemZoology_%ld.png",(long)self.num4] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num4 ++;
    if (self.num4 > 175) {
        self.num4 = 125;
    }
}

- (void)leisureImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemLeisure_%ld.png",(long)self.num5] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num5 ++;
    if (self.num5 > 205) {
        self.num5 = 155;
    }
}

- (void)medicalImageVChange {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemMedical_%ld.png",(long)self.num6] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num6 ++;
    if (self.num6 > 165) {
        self.num6 = 115;
    }
}

- (void)financialImageVChange {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemFinancial_%ld.png",(long)self.num7] ofType:nil];
    self.secondImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num7 ++;
    if (self.num7 > 135) {
        self.num7 = 85;
    }
}
- (void)baseImageVChange {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"itemBase_%ld.jpg",(long)self.num10] ofType:nil];
    self.baseImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num10 ++;
    if (self.num10 > 80) {
        self.num10 = 0;
    }
    
}

- (void)contentBtnClick{
     self.contentClickImageV.alpha = 1.0;
    self.contentClickBtn.alpha = 0.0;
    [self.time9 fire];
}

- (void)itemViewWillShow {
    [self.logoTime  fire];
    [self.time10 fire];
    [self autoBtnClick:self.autoBtn];
    [self upBtnClick:self.upBtnArr[0]];
}

- (void)itemViewWillHide {
    if ([_logoTime isValid]) {
        [_logoTime invalidate];
        _logoTime = nil;
    }
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
    if ([_time8 isValid]) {
        [_time8 invalidate];
        _time8 = nil;
    }
    
    if ([_time9 isValid]) {
        [_time9 invalidate];
        _time9 = nil;
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

- (void)logoBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(itemVcScrollToIndex:)]) {
        if (btn.tag == 0) {
            [self.delegate itemVcScrollToIndex:0];
        }else if (btn.tag == 1) {
            [self.delegate itemVcScrollToIndex:1];
        }
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([_logoTime isValid]) {
        [_logoTime invalidate];
        _logoTime = nil;
    }
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
    if ([_time8 isValid]) {
        [_time8 invalidate];
        _time8 = nil;
    }
    
    if ([_time9 isValid]) {
        [_time9 invalidate];
        _time9 = nil;
    }
    if ([_time10 isValid]) {
        [_time10 invalidate];
        _time10 = nil;
    }
}

- (void)dealloc {
    ZHYLogFunc;
}
@end
