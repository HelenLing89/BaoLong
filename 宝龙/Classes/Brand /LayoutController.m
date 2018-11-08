//
//  LayoutController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/28.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "LayoutController.h"

@interface LayoutController ()
@property (nonatomic, strong) NSTimer *timer0;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) UIImageView *baseImageV;

@end

@implementation LayoutController

- (NSTimer *)timer0 {
    if (_timer0 == nil) {
        _timer0 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(changeImageV0) userInfo:nil repeats:YES];
        self.num = 0;
    }
    return _timer0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBgImageV];
    [self.timer0 fire];
}

- (void)setupBgImageV {
    self.baseImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.baseImageV];
}

- (void)changeImageV0 {
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"layout_%ld.jpg",(long)self.num] ofType:nil];
    self.baseImageV.image = [UIImage imageWithContentsOfFile:path];
    self.num ++;
    if (self.num > 249) {
        self.num = 198;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([_timer0 isValid]) {
        [_timer0 invalidate];
        _timer0 = nil;
    }
}


@end
