//
//  RootController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/22.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "RootController.h"
#import "ForthShowView.h"

@interface RootController ()
@property (nonatomic, strong) UIImageView *bgImageV;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *imageS;
@property (nonatomic, strong) NSArray *roundImages;
@property (nonatomic, strong) NSArray *locationArr;
@property (nonatomic, strong) NSArray *bigLocationArr;
@property (nonatomic, strong) ForthShowView *showView;
@property (nonatomic, strong) CAAnimationGroup *animationGroup;
@end

@implementation RootController

- (ForthShowView *)showView {
    if (_showView == nil) {
        _showView = [[ForthShowView alloc] initWithFrame:kScreenBounds];
    }
    return _showView;
}

- (CAAnimationGroup *)animationGroup {
    if (_animationGroup == nil) {
        _animationGroup = [[CAAnimationGroup alloc] init];
        
        CAKeyframeAnimation *scaleAnim = [[CAKeyframeAnimation alloc] init];
        scaleAnim.keyPath = @"transform.scale";
        scaleAnim.values = @[@1,@1.05,@1.1,@1.15,@1.2,@1.15,@1.1,@1.05,@1];
        scaleAnim.duration = 2;
        
        
        CAKeyframeAnimation *opacityAnim = [[CAKeyframeAnimation alloc] init];
        opacityAnim.keyPath = @"opacity";
        opacityAnim.values = @[@0.85,@0.9,@1,@0.9,@0.85];
        opacityAnim.duration = 2;
        
        
        _animationGroup.animations = @[scaleAnim,opacityAnim];
        _animationGroup.removedOnCompletion = NO;
        _animationGroup.fillMode = kCAFillModeForwards;
        _animationGroup.duration = 2;
        _animationGroup.repeatCount = MAXFLOAT;
    }
    return _animationGroup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = @[@"澳门",@"五大",@"S04",@"电影",@"奇幻",@"全年龄",@"环球"];
    self.imageS = @[@"澳门S",@"五大S",@"S04S",@"电影S",@"奇幻S",@"全年龄S",@"环球S"];
    
    self.locationArr = @[@[@"166",@"437",@"44",@"379"],@[@"262",@"114",@"45",@"502"],@[@"402",@"531",@"44",@"341"],@[@"787",@"690",@"44",@"361"],@[@"1087",@"411",@"44",@"331"],@[@"1919",@"475",@"44",@"549"],@[@"2259",@"184",@"44",@"349"]];
    self.roundImages = @[@"圈",@"圈",@"S04圈",@"圈",@"圈",@"圈",@"圈"];
    self.bigLocationArr = @[@[@"128",@"700",@"944",@"786"],@[@"128",@"634",@"944",@"848"],@[],@[@"128",@"637",@"944",@"848"],@[@"128",@"565",@"944",@"920"],@[@"128",@"637",@"944",@"848"],@[@"128",@"637",@"944",@"848"]];
    [self setupBgImageV];
    [self addBtn];
    
}

- (void)setupBgImageV {
    self.bgImageV = [[UIImageView alloc] initWithFrame:kScreenBounds];
    self.bgImageV.image = [UIImage imageNamed:@"首页大盘"];
    [self.view addSubview:self.bgImageV];
}

- (void)addBtn {
    for (int index = 0; index < self.images.count; index++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake([self.locationArr[index][0] floatValue] * 0.5 * kW, [self.locationArr[index][1] floatValue] * 0.5 * kH, [self.locationArr[index][2] floatValue] * 0.5 * kW, [self.locationArr[index][3] floatValue] * 0.5 * kH)];
        imageV.image = [UIImage imageNamed:self.images[index]];
        imageV.tag = index;
        [self.bgImageV addSubview:imageV];
    
        UIImageView *roundImageV = [[UIImageView alloc] initWithFrame:CGRectMake([self.locationArr[index][0] floatValue] * 0.5 * kW, CGRectGetMaxY(imageV.frame) - 29 * 0.5 * kW, 58 * 0.5 * kW, 58 * 0.5 * kW)];
        roundImageV.image = [UIImage imageNamed:self.roundImages[index]];
        [self.bgImageV addSubview:roundImageV];
        [roundImageV.layer addAnimation:self.animationGroup forKey:nil];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake([self.locationArr[index][0] floatValue] * 0.5 * kW, [self.locationArr[index][1] floatValue] * 0.5 * kH, 58 * 0.5 * kW, [self.locationArr[index][3] floatValue] * 0.5 * kH + 29 * 0.5 * kW)];
        //btn.backgroundColor = [UIColor blueColor];
        btn.tag = index;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
    
- (void)btnClick:(UIButton *)btn {
    [self playSoundEffect:@"effect" type:@"mp3"];
    if (btn.tag != 2) {
        [self.view addSubview:self.showView];
        self.showView.imageVRect = CGRectMake([self.bigLocationArr[btn.tag][0] floatValue] * 0.5 * kW, [self.bigLocationArr[btn.tag][1] floatValue] * 0.5 * kH, [self.bigLocationArr[btn.tag][2] floatValue] * 0.5 * kW,[self.bigLocationArr[btn.tag][3] floatValue] * 0.5 * kH);
        self.showView.forthImageName =self.imageS[btn.tag];
    }else {
        ZHYLogFunc;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    for (UIImageView *imageV in self.bgImageV.subviews) {
        [imageV.layer removeAllAnimations];
    }
    
    
}

- (void)dealloc {
    ZHYLogFunc;
}
@end
