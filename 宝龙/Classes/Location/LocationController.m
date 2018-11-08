//
//  LocationController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/23.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "LocationController.h"
#import "宝龙-Swift.h"
#import "WorldController.h"
#import "HaiController.h"
#import "ItemController.h"

@interface LocationController ()<LTPageViewDelegate,WorldVcDelegate,ItemVcDelegate,HaiVcDelegate>
@property(copy, nonatomic) NSArray <UIViewController *> *viewControllers;
@property(copy, nonatomic) NSArray <NSString *> *titles;
@property(copy, nonatomic) NSArray <NSString *> *titleS;
@property(strong, nonatomic) LTLayout *layout;
@property(weak, nonatomic) LTPageView *pageView;
@property(assign, nonatomic) NSInteger lastIndex;
@end

@implementation LocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];

}

-(void)setupSubViews {
    LTPageView *pageView = [[LTPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) currentViewController:self viewControllers:self.viewControllers titles:self.titles titleS:self.titleS layout:self.layout];
    self.pageView = pageView;
    self.pageView.delegate = self;
    [self.view addSubview:self.pageView];
    typeof(self) weakSelf = self;
    [self.pageView setDidSelectIndexBlock:^(LTPageView * _Nonnull pageView, NSInteger index) {
        if (index != weakSelf.lastIndex) {
            [weakSelf playSoundEffect:@"effect" type:@"mp3"];
            if (index == 0) {
                WorldController *world = (WorldController *)weakSelf.viewControllers[index];
                [world worldViewWillShow];
            }else if (index == 1){
                HaiController *hai = (HaiController *)weakSelf.viewControllers[index];
                [hai haiViewWillShow];
            }else if (index == 2){
                ItemController *item = (ItemController *)weakSelf.viewControllers[index];
                [item itemViewWillShow];
            }

            if (weakSelf.lastIndex == 0) {
                WorldController *world = (WorldController *)weakSelf.viewControllers[weakSelf.lastIndex];
                [world worldViewWillHide];
            }else if (weakSelf.lastIndex == 1){
                HaiController *hai = (HaiController *)weakSelf.viewControllers[weakSelf.lastIndex];
                //    [sheng.view.layer removeAllAnimations];
                //[sheng.view removeFromSuperview];
                [hai haiViewWillHide];
            }else {
                ItemController *item = (ItemController *)weakSelf.viewControllers[weakSelf.lastIndex];
                //  [item.view.layer removeAllAnimations];
                // [item.view removeFromSuperview];
                [item itemViewWillHide];
            }
            weakSelf.lastIndex = index;
        }
    }];
}


-(LTLayout *)layout {
    if (!_layout) {
        _layout = [[LTLayout alloc] init];
        _layout.sliderWidth = 290 * 0.5;
        _layout.titleMargin = 5.0;
        // （屏幕宽度 - 标题总宽度 - 标题间距宽度） / 2 = 最左边以及最右边剩余
        CGFloat lrMargin = (self.view.bounds.size.width - (self.titles.count * _layout.sliderWidth + (self.titles.count - 1) * _layout.titleMargin)) * 0.5;
        _layout.lrMargin = lrMargin;
        _layout.isAverage = YES;
    }
    return _layout;
}


- (NSArray <NSString *> *)titles {
    if (!_titles) {
        _titles = @[@"",@"",@""];
    }
    return _titles;
}

- (NSArray <NSString *> *)titleS {
    if (!_titleS) {
        _titleS = @[@"",@"",@""];
    }
    return _titleS;
}

-(NSArray <UIViewController *> *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [self setupViewControllers];
    }
    return _viewControllers;
}


-(NSArray <UIViewController *> *)setupViewControllers {
    NSMutableArray <UIViewController *> *testVCS = [NSMutableArray arrayWithCapacity:0];
    WorldController *world = [WorldController new];
    world.delegate = self;
    [testVCS addObject:world];
    HaiController *hai = [HaiController new];
    hai.delegate = self;
    [testVCS addObject:hai];
    ItemController *item = [ItemController new];
    item.delegate = self;
    [testVCS addObject:item];
    return testVCS.copy;
}

- (void)worldVcScrollToIndex:(NSInteger)index {
    typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf.pageView scrollToIndexWithIndex:index];
    }];
}
- (void)haiVcScrollToIndex:(NSInteger)index {
    typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf.pageView scrollToIndexWithIndex:index];
    }];
}

- (void)itemVcScrollToIndex:(NSInteger)index {
    typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf.pageView scrollToIndexWithIndex:index];
    }];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    for (UIViewController *vc  in self.childViewControllers) {
        [vc removeFromParentViewController];
        [vc.view removeFromSuperview];
    }
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}



- (void)dealloc {
    ZHYLogFunc;
}
@end
