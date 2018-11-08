//
//  BaoController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/28.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "BaoController.h"

@interface BaoController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) NSTimer *timer0;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSTimer *timer1;
@property (nonatomic, assign) NSInteger num1;
@property (nonatomic, strong) NSTimer *timer2;
@property (nonatomic, assign) NSInteger num2;
@property (nonatomic, strong) NSTimer *timer3;
@property (nonatomic, assign) NSInteger num3;
@property (nonatomic, strong) NSTimer *timer4;
@property (nonatomic, assign) NSInteger num4;
@property (nonatomic, strong) NSTimer *timer5;
@property (nonatomic, assign) NSInteger num5;
@property (nonatomic, strong) NSTimer *timer6;
@property (nonatomic, assign) NSInteger num6;
@property (nonatomic, strong) NSTimer *timer7;
@property (nonatomic, assign) NSInteger num7;
@property (nonatomic, strong) NSTimer *timer8;
@property (nonatomic, assign) NSInteger num8;
@property (nonatomic, strong) NSTimer *timer9;
@property (nonatomic, assign) NSInteger num9;
@property (nonatomic, assign) CGFloat contentOffsetX;
@property (nonatomic, assign) CGFloat startContentOffsetX;
@property (nonatomic, assign) CGFloat endContentOffsetX;
@property (nonatomic, strong) UIImageView *scrollImageV;

@end

@implementation BaoController
- (NSTimer *)timer0 {
    if (_timer0 == nil) {
        _timer0 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV0) userInfo:nil repeats:YES];
    }
    return _timer0;
}
- (NSTimer *)timer1 {
    if (_timer1 == nil) {
        _timer1 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV1) userInfo:nil repeats:YES];
    }
    return _timer1;
}
- (NSTimer *)timer2 {
    if (_timer2 == nil) {
        _timer2 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV2) userInfo:nil repeats:YES];
    }
    return _timer2;
}
- (NSTimer *)timer3 {
    if (_timer3 == nil) {
        _timer3 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV3) userInfo:nil repeats:YES];
    }
    return _timer3;
}

- (NSTimer *)timer4 {
    if (_timer4 == nil) {
        _timer4 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV1Add) userInfo:nil repeats:YES];
    }
    return _timer4;
}

- (NSTimer *)timer5 {
    if (_timer5 == nil) {
        _timer5 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV2Add) userInfo:nil repeats:YES];
    }
    return _timer5;
}

- (NSTimer *)timer6 {
    if (_timer6 == nil) {
        _timer6 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV3Add) userInfo:nil repeats:YES];
    }
    return _timer6;
}
- (NSTimer *)timer7 {
    if (_timer7 == nil) {
        _timer7 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV0Minus) userInfo:nil repeats:YES];
    }
    return _timer7;
}
- (NSTimer *)timer8 {
    if (_timer8 == nil) {
        _timer8 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV1Minus) userInfo:nil repeats:YES];
    }
    return _timer8;
}

- (NSTimer *)timer9 {
    if (_timer9 == nil) {
        _timer9 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV2Minus) userInfo:nil repeats:YES];
    }
    return _timer9;
}

- (UIScrollView *)baseScrollView {
    if (_baseScrollView == nil) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _baseScrollView.showsVerticalScrollIndicator = NO;
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        _baseScrollView.pagingEnabled = YES;
        _baseScrollView.delegate = self;
        _baseScrollView.bounces = false;
        _baseScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _baseScrollView.backgroundColor = [UIColor clearColor];
    }
    return _baseScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    self.num = 0;
    [self.timer0 fire];
    
    
}

- (void)setupScrollView {
    [self.view addSubview:self.baseScrollView];
    self.scrollImageV = [[UIImageView alloc] initWithFrame:kScreenBounds];
    [self.view addSubview:self.scrollImageV];
    for (int index = 0; index < 4; index++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW * index, 0, kScreenW, kScreenH)];
        imageV.alpha = 0.0;
        [self.baseScrollView addSubview:imageV];
    }
    self.baseScrollView.contentSize = CGSizeMake(kScreenW * 4, 0);
}

//拖动之前坐标

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.contentOffsetX = scrollView.contentOffset.x;
    
}

//拖动即将结束时的坐标

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    self.startContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.k_Width;
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.endContentOffsetX = scrollView.contentOffset.x;
    if ([_timer0 isValid]) {
        [_timer0 invalidate];
        _timer0 = nil;
    }
    if ([_timer1 isValid]) {
        [_timer1 invalidate];
        _timer1 = nil;
    }
    if ([_timer2 isValid]) {
        [_timer2 invalidate];
        _timer2 = nil;
    }
    if ([_timer3 isValid]) {
        [_timer3 invalidate];
        _timer3 = nil;
    }
    if ([_timer4 isValid]) {
        [_timer4 invalidate];
        _timer4 = nil;
    }
    if ([_timer5 isValid]) {
        [_timer5 invalidate];
        _timer5 = nil;
    }
    if ([_timer6 isValid]) {
        [_timer6 invalidate];
        _timer6 = nil;
    }
    if ([_timer7 isValid]) {
        [_timer7 invalidate];
        _timer7 = nil;
    }
    if ([_timer8 isValid]) {
        [_timer8 invalidate];
        _timer8 = nil;
    }
    if ([_timer9 isValid]) {
        [_timer9 invalidate];
        _timer9 = nil;
    }
    NSInteger page = scrollView.contentOffset.x / scrollView.k_Width;

    //从右向左滑动
     if (self.endContentOffsetX > self.startContentOffsetX && self.startContentOffsetX > self.contentOffsetX) {
         if (page == 0) {
             self.num = 0;
             [self.timer0 fire];
         }else if (page == 1){
             if (self.num < 145) {
                 [self.timer4 fire];
             }else{
                 self.num1 = 145;
                 [self.timer1 fire];
             }
         }else if (page == 2){
             if (self.num1 <345) {
                 [self.timer5 fire];
             }else{
                 self.num2 = 345;
                 [self.timer2 fire];
             }
         }else if (page == 3){
             if (self.num2 <570) {
                 [self.timer6 fire];
             }else{
                 self.num3 = 570;
                 [self.timer3 fire];
             }
         }
         NSLog(@" 注意了，右滑了");
    
     }
     if (self.endContentOffsetX < self.startContentOffsetX && self.startContentOffsetX < self.contentOffsetX){//从左向右滑动
         if (page == 0) {
             [self.timer7 fire];
         }else if (page == 1){
             [self.timer8 fire];
         }else if (page == 2){
             [self.timer9 fire];
         }
         NSLog(@" 注意了，左滑了");
     }
}

- (void)changeImageV0 {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num] ofType:nil];
   self.scrollImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num ++;
    if (self.num > 145) {
        self.num = 25;
    }
}
- (void)changeImageV1 {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num1] ofType:nil];
    self.scrollImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num1 ++;
    if (self.num1 > 345) {
        self.num1 = 225;
    }
}

- (void)changeImageV2 {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num2] ofType:nil];
    self.scrollImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num2 ++;
    if (self.num2 > 570) {
        self.num2 = 450;
    }
}
- (void)changeImageV3 {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num3] ofType:nil];
    self.scrollImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num3 ++;
    if (self.num3 > 755) {
        self.num3 = 655;
    }
}

- (void)changeImageV1Add {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num] ofType:nil];
    self.scrollImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num ++;
    if (self.num > 145) {
        [_timer4 invalidate];
        _timer4 = nil;
        self.num1 = 145;
        [self.timer1 fire];
    }
}

- (void)changeImageV2Add {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num1] ofType:nil];
    self.scrollImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num1 ++;
    if (self.num1 > 345) {
        [_timer5 invalidate];
        _timer5 = nil;
        self.num2 = 345;
        [self.timer2 fire];
    }
}

- (void)changeImageV3Add {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num2] ofType:nil];
    self.scrollImageV.image= [UIImage imageWithContentsOfFile:path];
    self.num2 ++;
    if (self.num2 > 570) {
        [_timer6 invalidate];
        _timer6 = nil;
        self.num3 = 570;
        [self.timer3 fire];
    }
}
- (void)changeImageV2Minus {
   
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num3] ofType:nil];
    self.scrollImageV.image = [UIImage imageWithContentsOfFile:path];
    if (self.num3 < 755 && self.num3 > 620) {
        self.num3++;
    }else if(self.num3 == 755){
        self.num3 = 620;
    }else{
        if (self.num3 > 580) {
            self.num3 --;
        }else {
            self.num3 = 395;
            self.num3++;
            if (self.num3>570) {
                self.num3 = 450;
            }
        }
    }
}

- (void)changeImageV1Minus {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num2] ofType:nil];
     self.scrollImageV.image = [UIImage imageWithContentsOfFile:path];
    if (self.num2 < 580 && self.num2 >395) {
        self.num2++;
    }else if(self.num2 == 580){
        self.num2 = 395;
    }else{
        if (self.num2 >350) {
            self.num2--;
        }else {
            self.num2 = 195;
            self.num2 ++;
            if (self.num2 > 345) {
                self.num2 = 225;
            }
        }
    }
}
- (void)changeImageV0Minus {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"baoGroup_%ld.jpg",(long)self.num1] ofType:nil];
     self.scrollImageV.image = [UIImage imageWithContentsOfFile:path];
    if (self.num1 < 355 && self.num1 > 195) {
        self.num1 ++;
    }else if(self.num1 == 355){
        self.num1 = 195;
    }else{
        if (self.num1 >195) {
            self.num1--;
        }else {
            self.num1 = 0;
            self.num1 ++;
            if (self.num1 > 145) {
                self.num1 = 25;
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([_timer0 isValid]) {
        [_timer0 invalidate];
        _timer0 = nil;
    }
    if ([_timer1 isValid]) {
        [_timer1 invalidate];
        _timer1 = nil;
    }
    if ([_timer2 isValid]) {
        [_timer2 invalidate];
        _timer2 = nil;
    }
    if ([_timer3 isValid]) {
        [_timer3 invalidate];
        _timer3 = nil;
    }
    if ([_timer4 isValid]) {
        [_timer4 invalidate];
        _timer4 = nil;
    }
    if ([_timer5 isValid]) {
        [_timer5 invalidate];
        _timer5 = nil;
    }
    if ([_timer6 isValid]) {
        [_timer6 invalidate];
        _timer6 = nil;
    }
    if ([_timer7 isValid]) {
        [_timer7 invalidate];
        _timer7 = nil;
    }
    if ([_timer8 isValid]) {
        [_timer8 invalidate];
        _timer8 = nil;
    }
    if ([_timer9 isValid]) {
        [_timer9 invalidate];
        _timer9 = nil;
    }
}

- (void)dealloc {
    ZHYLogFunc;
}
@end
