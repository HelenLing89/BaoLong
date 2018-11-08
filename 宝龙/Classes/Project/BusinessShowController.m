//
//  BusinessShowController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/23.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "BusinessShowController.h"

@interface BusinessShowController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) NSArray *baseImages;
@property (nonatomic, strong) NSArray *baseWords;
@property (nonatomic, strong) NSArray *wordsLocation;
@property (nonatomic, strong) NSMutableArray *wordsImageVArr;
@end

@implementation BusinessShowController

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
    self.baseImages = @[@"产品",@"教育",@"教育2",@"酒店",@"乐园",@"商业",@"医疗"];
    self.baseWords = @[@"产品字",@"教育字",@"教育2字",@"酒店字",@"乐园字",@"商业字",@"医疗字"];
    self.wordsLocation = @[@[@"166",@"142",@"1690",@"678"],@[@"165",@"1464",@"889",@"444"],@[@"169",@"162",@"889",@"444"],@[@"166",@"142",@"1090",@"443"],@[@"1881",@"148",@"722",@"576"],@[@"166",@"142",@"1291",@"577"],@[@"128",@"124",@"1089",@"697"]];
    [self addScrollView];
}

- (void)addScrollView {
    self.wordsImageVArr = [NSMutableArray array];
    [self.view addSubview:self.baseScrollView];
    for (int index = 0; index < self.baseImages.count; index++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW * index, 0, kScreenW, kScreenH)];
        imageV.image = [UIImage imageNamed:self.baseImages[index]];
        [self.baseScrollView insertSubview:imageV atIndex:0];
        UIImageView *wordImageV;
        if (index == 0) {
            wordImageV = [[UIImageView alloc] initWithFrame:CGRectMake([self.wordsLocation[index][0] floatValue] * 0.5 * kW,[self.wordsLocation[index][1] floatValue] * 0.5 * kH, [self.wordsLocation[index][2] floatValue] * 0.5 * kW, [self.wordsLocation[index][3] floatValue] * 0.5 * kW)];
        }
        if (index == 1 ) {
             wordImageV = [[UIImageView alloc] initWithFrame:CGRectMake([self.wordsLocation[index][0] floatValue] * 0.5 * kW + kScreenW * (index * 2),[self.wordsLocation[index][1] floatValue] * 0.5 * kH, [self.wordsLocation[index][2] floatValue] * 0.5 * kW, [self.wordsLocation[index][3] floatValue] * 0.5 * kW)];
        }
        if (index == 2|| index == 3 || index == 5 || index == 4 || index == 6) {
             wordImageV = [[UIImageView alloc] initWithFrame:CGRectMake([self.wordsLocation[index][0] floatValue] * 0.5 * kW + kScreenW * (index *2),[self.wordsLocation[index][1] floatValue] * 0.5 * kH, [self.wordsLocation[index][2] floatValue] * 0.5 * kW, [self.wordsLocation[index][3] floatValue] * 0.5 * kW)];
            NSLog(@"%f",wordImageV.k_X);
        }
       
        wordImageV.image = [UIImage imageNamed:self.baseWords[index]];
        [self.baseScrollView addSubview:wordImageV];
        [self.wordsImageVArr addObject:wordImageV];
    }
    
    
    self.baseScrollView.contentSize = CGSizeMake(kScreenW * self.baseImages.count, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f",scrollView.contentOffset.x / kScreenW);
    if (scrollView.contentOffset.x / kScreenW < 0.5) {
        UIImageView *imageV = self.wordsImageVArr[0];
        imageV.k_X = [self.wordsLocation[0][0] floatValue] * 0.5 * kW - scrollView.contentOffset.x;
    }
    if (scrollView.contentOffset.x / kScreenW > 0.3 && scrollView.contentOffset.x / kScreenW < 1.5) {
        UIImageView *imageV = self.wordsImageVArr[1];
        imageV.k_X = [self.wordsLocation[1][0] floatValue] * 0.5 * kW - scrollView.contentOffset.x + kScreenW *2;
    }
    if (scrollView.contentOffset.x /kScreenW >1.5  && scrollView.contentOffset.x / kScreenW < 2.2) {
        UIImageView *imageV = self.wordsImageVArr[2];
        imageV.k_X = [self.wordsLocation[2][0] floatValue] * 0.5 * kW - scrollView.contentOffset.x + kScreenW *4;
    }
    if (scrollView.contentOffset.x /kScreenW >2.5 && scrollView.contentOffset.x / kScreenW < 3.2) {
        UIImageView *imageV = self.wordsImageVArr[3];
        imageV.k_X = [self.wordsLocation[3][0] floatValue] * 0.5 * kW - scrollView.contentOffset.x + kScreenW  *6;
    }
    if (scrollView.contentOffset.x /kScreenW >3.5 && scrollView.contentOffset.x / kScreenW < 4.2) {
        UIImageView *imageV = self.wordsImageVArr[4];
        imageV.k_X = [self.wordsLocation[4][0] floatValue] * 0.5 * kW - scrollView.contentOffset.x + kScreenW *8;
    }
    if (scrollView.contentOffset.x /kScreenW >4.5 && scrollView.contentOffset.x / kScreenW < 5.2) {
        UIImageView *imageV = self.wordsImageVArr[5];
        imageV.k_X = [self.wordsLocation[5][0] floatValue] * 0.5 * kW - scrollView.contentOffset.x + kScreenW * 10;
    }
    if (scrollView.contentOffset.x /kScreenW > 5.5 && scrollView.contentOffset.x / kScreenW <=6.0) {
        UIImageView *imageV = self.wordsImageVArr[6];
        imageV.k_X = [self.wordsLocation[6][0] floatValue] * 0.5 * kW - scrollView.contentOffset.x + kScreenW * 12;
      //  NSLog(@"%f", imageV.k_X);
    }

}




@end
