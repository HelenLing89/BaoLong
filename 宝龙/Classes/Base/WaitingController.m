//
//  WaitingController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/24.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "WaitingController.h"

@interface WaitingController ()
@property (nonatomic, strong) UIImageView *bgImageV;

@end

@implementation WaitingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBgImageV];
}

- (void)setupBgImageV {
    self.bgImageV = [[UIImageView alloc] initWithFrame:kScreenBounds];
    self.bgImageV.image = [UIImage imageNamed:@"期待"];
    [self.view addSubview:self.bgImageV];
}

@end
