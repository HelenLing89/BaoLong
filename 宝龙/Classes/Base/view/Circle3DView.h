//
//  Circle3DView.h
//  circleMenu
//
//  Created by geek on 2018/8/7.
//  Copyright © 2018年 danzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Circle3DView : UIView
{
@private
//圆的半径
CGFloat radius;
//三级的半径
CGFloat tradius;
//圆心（在CircleView上的位置）
CGPoint center1;
//平均角度
CGFloat average_radina;
//拖动的点
CGPoint pointDrag;
//拖动结束后间隔的个数
NSInteger step;
}
@property (nonatomic, strong) NSArray *menuTitleValues;
@property (nonatomic, retain) NSMutableArray *arrImages;
@property (nonatomic, retain) NSMutableArray *thirdImages;
@property (nonatomic, retain) NSMutableArray *baseImages;
@property (nonatomic, strong) NSMutableArray *forthImages;
@property (nonatomic, strong)UIImageView *centerImgView;
@property (nonatomic, assign) NSInteger currentSelectedTag;
@property (nonatomic, strong) NSArray *thirdRadius;
@property (nonatomic, strong) NSArray *forthRadius;

- (void)loadView;

- (void)showThirdImageVWithTag:(NSInteger) selectedTag WithStatus:(NSInteger) status;
- (void)showSubImagesWithSelectedTag:(NSInteger) selectedTag WithStatus:(NSInteger)status;



//- (void)hideThirdImageV;
@end
