//
//  BaseNavController.m
//  宝龙
//
//  Created by 凌甜 on 2018/10/21.
//  Copyright © 2018年 HelenLing. All rights reserved.
//

#import "BaseNavController.h"
// 罗盘上图标
//#import "DragImageView.h"
#import "DragImageView.h"
// 旋转罗盘
#import "Circle3DView.h"
#import "ThirdImageView.h"
#import "BaseImageView.h"
#import "WaitingController.h"
#import "BusinessShowController.h"
#import "RootController.h"
#import "LocationController.h"
#import "BaoController.h"
#import "LayoutController.h"
//#import "ChangController.h"
//#import "AroundController.h"
//#import "BigEventController.h"

// 图标大小
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define ImageWidth 118 * 0.5 * kW
#define ImageHeight 100 * 0.5 * kH

#define forthWidth 112 * 0.5 *  kW
#define forthHeight 120 * 0.5*  kH
// 转盘frame
#define ScrollFrame CGRectMake(SCREEN_WIDTH - 151 * kScale, SCREEN_HEIGHT - 151 * kScale - 64 , 218 * kScale , 218 * kScale)
// 图标tag
#define BASE_IMAGEVIEW_TAG 1000
#define CENTER_IMAGEVIEW_TAG 1100
#define BASE_THIRDIMAGE_TAG 1200
@interface BaseNavController (){
    // 转盘
    DragImageView *brandImageV;
    DragImageView *locationImageV;
    DragImageView *projectImageV;
    DragImageView *appreciationImageV;
    DragImageView *homeImageV;
    DragImageView *otherImageV;
    BaseImageView *baseImageV1;
    BaseImageView *baseImageV2;
    BaseImageView *baseImageV3;
    BaseImageView *baseImageV4;
    BaseImageView *baseImageV5;
    //    DragImageView *imageviewDetailTwo;
    ThirdImageView *brandImageVOne;
    ThirdImageView *brandImageVTwo;
    ThirdImageView *brandImageVThree;
    ThirdImageView *brandImageVFour;
    ThirdImageView *brandImageVFive;
    ThirdImageView *brandImageVSix;
    ThirdImageView *brandImageVSeven;
    ThirdImageView *brandImageVEight;
    ThirdImageView *brandImageVNine;
    
    ThirdImageView *locationImageVOne;
    ThirdImageView *locationImageVTwo;
    ThirdImageView *locationImageVThree;;
    ThirdImageView *projectImageVOne;
    ThirdImageView *projectImageVTwo;
    ThirdImageView *appreciationImageVOne;
    ThirdImageView *appreciationImageVTwo;
    
    UIImageView *imageviewCenterQuick;
//    // 按钮
//    NSMutableArray *arrImage;
    // 点击后的底色
    NSMutableArray *baseImages;
    //三级目录
    NSMutableArray *thirdImage;
    //四级目录
    NSMutableArray *forthImage;
    // 中心点
    CGPoint pointCenter;
    //半径
    CGFloat fRadius;
    //平均角度
    CGFloat fAvarage_Radina;
    CGPoint pointDrag;
    NSInteger iCurrentIndex;
    NSInteger iStep;
}
@property (nonatomic, strong) DragImageView *lastSelectBtn;
@property (nonatomic, strong) ThirdImageView *lastSelectThirdBtn;
@property (nonatomic, strong) Circle3DView *circleView;
@property (nonatomic, strong) NSMutableArray *tapArr;
@property (nonatomic, strong) NSMutableArray *secondTapArr;
@property (nonatomic, strong) NSArray *thirdSizeArr;
@property (nonatomic, strong) NSArray *thirdRadiuArr;
@property (nonatomic, strong) NSArray *forthRadiuArr;
@property (nonatomic, strong) NSArray *thirdImages;
@property (nonatomic, strong) NSArray *secondImages;
@property (nonatomic, strong) NSArray *secondImageS;
@property (nonatomic, strong) NSArray *forthImages;
@property (nonatomic, strong) NSArray *forthImageS;
@property (nonatomic, strong) NSArray *forthCenter;
@property (nonatomic, strong) NSMutableArray *arrImages;

- (void)initDragImageView;
- (void)showImage;
@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加转盘
    [self addCircleView];
}
#pragma mark 添加转盘
- (void)addCircleView {
    self.thirdImages = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"10",@"11",@"12",@"10",@"11",@"12"];
    self.thirdSizeArr = @[@[@"139",@"558"],@[@"143",@"661"],@[@"173",@"725"],@[@"129",@"539"],@[@"159",@"618"],@[@"162",@"699"],@[@"145",@"580"],@[@"148",@"647"],@[@"195",@"542"],@[@"155",@"590"],@[@"140",@"719"],@[@"162",@"648"],@[@"155",@"590"],@[@"140",@"719"],@[@"162",@"648"],@[@"155",@"590"],@[@"140",@"719"],@[@"162",@"648"]];
    self.thirdRadiuArr = @[@[@"45"],@[@"23",@"38.5",@"60",@"83",@"98.5",@"120",@"143",@"158.5",@"180"],@[],@[@"23",@"41",@"60"],@[@"28",@"50"],@[@"19",@"41",@"60"]];
    self.forthRadiuArr = @[@[@"30"],@[@"11.5",@"30.75",@"49",@"71.5",@"90.75",@"109",@"127.5",@"150.75",@"169"],@[],@[@"11.5",@"32.5",@"51"],@[@"14",@"39"],@[@"9.5",@"30",@"51"]];
    self.forthImages = @[@"brand_01",@"brand_02",@"brand_03",@"tools_01",@"tools_02",@"project_01",@"project_02",@"project_03",@"location_01",@"S01",@"S02",@"S03",@"S04",@"Z02",@"Z03",@"Z04",@"Z10",@"Z29"];
    self.secondImages = @[@"locationBtn",@"parcelBtn",@"homeBtn",@"brandBtn",@"toolBtn",@"projectBtn"];
    self.secondImageS = @[@"locationBtnS",@"parcelBtnS",@"homeBtnS",@"brandBtnS",@"toolBtnS",@"projectBtnS"];
  //  [self addImageV];
    [self initDragImageView];
    [self initThirdImageV];
    
    [self showImage];
    
    [self imageClick:self.secondTapArr[2]];
}
- (void)initDragImageView{
    self.arrImages = [NSMutableArray array];
    for (int index = 0; index < self.secondImages.count; index++) {
        DragImageView *imageV = [[DragImageView alloc] initWithFrame:CGRectMake(0, 0, ImageWidth, ImageHeight)];
        imageV.image = [UIImage imageNamed:self.secondImages[index]];
        imageV.imgName = self.secondImages[index];
        imageV.selectImgName = self.secondImageS[index];
        [self.arrImages addObject:imageV];
    }
   
    // 添加转盘中心图标
    imageviewCenterQuick = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,200, 200)];
    imageviewCenterQuick.backgroundColor = [UIColor redColor];
    imageviewCenterQuick.image = [UIImage imageNamed:@"转盘icon"];
    baseImages = [NSMutableArray array];
    for (int index = 0; index < 6;index++) {
        BaseImageView *baseImageV = [[BaseImageView alloc] initWithFrame:CGRectMake(0, 0, 196 * 0.5 *  kW, 226 * 0.5 *  kH)];
        baseImageV.image = [UIImage imageNamed:@"selectedBase"];
        baseImageV.userInteractionEnabled = YES;
        [baseImages addObject:baseImageV];
    }
    // 图标集合
    self.secondTapArr = [NSMutableArray array];
    for (int i = 0; i < self.arrImages.count; i ++) {
        DragImageView *imageview = [self.arrImages objectAtIndex:i];
        imageview.userInteractionEnabled = YES;
        // 添加点击手势，点击相应图标，跳转到某一界面
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        [imageview addGestureRecognizer:tap];
        imageview.tag = BASE_IMAGEVIEW_TAG + i;
        [self.secondTapArr addObject:tap];
    }
}

- (void)initThirdImageV {
    // 名门三级
    NSMutableArray *firstArr = [NSMutableArray array];
    NSMutableArray *firstForthArr = [NSMutableArray array];
    for (int index = 0; index < 3; index++) {
        ThirdImageView * brandImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, [self.thirdSizeArr[index][0] floatValue]* 0.5 * kW, [self.thirdSizeArr[index][1] floatValue]* 0.5 * kH)];
        brandImageV.image = [UIImage imageNamed:self.thirdImages[index]];
        brandImageV.imgName = self.thirdImages[index];
        brandImageV.selectImgName = self.thirdImages[index];
        [firstArr addObject:brandImageV];
        ThirdImageView *forthImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, forthWidth,forthHeight)];
        forthImageV.image = [UIImage imageNamed:self.forthImages[index]];
        forthImageV.imgName = self.forthImages[index];
        forthImageV.selectImgName = self.forthImages[index];
        [firstForthArr addObject:forthImageV];
    }
    
    NSMutableArray *secondArr = [NSMutableArray array];
    NSMutableArray *secondForthArr = [NSMutableArray array];
    for (int index = 0; index < 2; index++) {
        ThirdImageView *brandImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, [self.thirdSizeArr[index+3][0] floatValue]* 0.5 * kW, [self.thirdSizeArr[index+3][1] floatValue]* 0.5 * kH)];
        brandImageV.image = [UIImage imageNamed:self.thirdImages[index+3]];
        brandImageV.imgName = self.thirdImages[index+3];
        brandImageV.selectImgName = self.thirdImages[index+3];
        [secondArr addObject:brandImageV];
        
        ThirdImageView *forthImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, forthWidth,forthHeight)];
        
        forthImageV.image = [UIImage imageNamed:self.forthImages[index+3]];
        forthImageV.imgName = self.forthImages[index+3];
        forthImageV.selectImgName = self.forthImages[index+3];
        [secondForthArr addObject:forthImageV];
    }
    
    NSMutableArray *thirdArr = [NSMutableArray array];
    NSMutableArray *thirdForthArr = [NSMutableArray array];
    for (int index = 0; index < 3; index++) {
        ThirdImageView *brandImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, [self.thirdSizeArr[index+5][0] floatValue]* 0.5 * kW, [self.thirdSizeArr[index+5][1] floatValue]* 0.5 * kH)];
        brandImageV.image = [UIImage imageNamed:self.thirdImages[index+5]];
        brandImageV.imgName = self.thirdImages[index+5];
        brandImageV.selectImgName = self.thirdImages[index+5];
        [thirdArr addObject:brandImageV];
        
        ThirdImageView *forthImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, forthWidth,forthHeight)];
        forthImageV.image = [UIImage imageNamed:self.forthImages[index+5]];
        forthImageV.imgName = self.forthImages[index+5];
        forthImageV.selectImgName = self.forthImages[index+5];
        [thirdForthArr addObject:forthImageV];
    }
    
    NSMutableArray *forthArr = [NSMutableArray array];
    NSMutableArray *forthForthArr = [NSMutableArray array];
    for (int index = 0; index < 1; index++) {
        ThirdImageView *brandImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, [self.thirdSizeArr[index+8][0] floatValue]* 0.5 * kW, [self.thirdSizeArr[index+8][1] floatValue]* 0.5 * kH)];
        brandImageV.image = [UIImage imageNamed:self.thirdImages[index+8]];
        brandImageV.imgName = self.thirdImages[index+8];
        brandImageV.selectImgName = self.thirdImages[index+8];
        
        [forthArr addObject:brandImageV];
        
        ThirdImageView *forthImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, forthWidth,forthHeight)];
        forthImageV.image = [UIImage imageNamed:self.forthImages[index+8]];
        forthImageV.imgName = self.forthImages[index+8];
        forthImageV.selectImgName = self.forthImages[index+8];
        [forthForthArr addObject:forthImageV];
    }
    
    NSMutableArray *fifthArr = [NSMutableArray array];
    NSMutableArray *fifthForthArr = [NSMutableArray array];
    for (int index = 0; index < 9; index++) {
        ThirdImageView *brandImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, [self.thirdSizeArr[index+9][0] floatValue]* 0.5 * kW, [self.thirdSizeArr[index+9][1] floatValue]* 0.5 * kH)];
        brandImageV.image = [UIImage imageNamed:self.thirdImages[index+9]];
        brandImageV.imgName = self.thirdImages[index+9];
        brandImageV.selectImgName = self.thirdImages[index+9];
        [fifthArr addObject:brandImageV];
        
        ThirdImageView *forthImageV = [[ThirdImageView alloc] initWithFrame:CGRectMake(0, 0, forthWidth,forthHeight)];
        forthImageV.image = [UIImage imageNamed:self.forthImages[index+9]];
        forthImageV.tag = index;
        forthImageV.imgName = self.forthImages[index+9];
        forthImageV.selectImgName = self.forthImages[index+9];
        [brandImageV addSubview:forthImageV];
        [fifthForthArr addObject:forthImageV];
    }
    NSArray *sixthArr = @[];
    
    // 图标集合
    thirdImage = [[NSMutableArray alloc] initWithObjects:forthArr,fifthArr,sixthArr,firstArr,secondArr,thirdArr, nil];
    forthImage = [[NSMutableArray alloc] initWithObjects:forthForthArr,fifthForthArr,sixthArr,firstForthArr,secondForthArr,thirdForthArr, nil];
    self.tapArr = [NSMutableArray array];
    
    [thirdImage enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *array = (NSArray *)obj;
        NSMutableArray *tapArrM = [NSMutableArray array];
        for (int i = 0; i < array.count; i ++) {
            ThirdImageView *imageview = [array objectAtIndex:i];
            imageview.userInteractionEnabled = YES;
            // 添加点击手势，点击相应图标，跳转到某一界面
            //  [imageview addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdImageClick:)];
            [tapArrM addObject:tap];
            [imageview addGestureRecognizer:tap];
            imageview.tag = BASE_THIRDIMAGE_TAG + idx * 10 + i;
        }
        [self.tapArr addObject:tapArrM];
    }];
}

- (void)addImageV {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageV.image = [UIImage imageNamed:@"城市布局"];
    imageV.userInteractionEnabled = YES;
    [self.view addSubview:imageV];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:btn];
}

- (void)btnClick:(UIButton *)btn {
    NSLog(@"%s",__func__);
    
}

- (void)imageClick:(UITapGestureRecognizer *)tap {
    long itag = tap.view.tag - BASE_IMAGEVIEW_TAG;
    DragImageView *imageV = (DragImageView *)tap.view;
    if (tap.view != self.lastSelectBtn) {
        [self playSoundEffect:@"effect" type:@"mp3"];
        imageV.image = [UIImage imageNamed:imageV.selectImgName];
        // imageV.alpha = 1.0;
        if (self.lastSelectBtn != nil) {
            self.lastSelectBtn.image = [UIImage imageNamed:self.lastSelectBtn.imgName];
        }
        self.lastSelectBtn = imageV;
        self.circleView.currentSelectedTag = itag;
        [self.circleView showSubImagesWithSelectedTag:itag WithStatus:1];
        [self popViewControllerAnimated:NO];
        if (itag != 2) {
            [self thirdImageClick:self.tapArr[itag][0]];
        }else {
            [self pushViewController:[RootController new] animated:NO];
        }
    }
}


- (void)thirdImageClick:(UITapGestureRecognizer *)tap {
    NSInteger itag = (tap.view.tag - BASE_THIRDIMAGE_TAG) / 10;
    if (self.circleView.currentSelectedTag != itag) {
        [self imageClick:self.secondTapArr[itag]];
    }
    NSInteger iitag = (tap.view.tag - BASE_THIRDIMAGE_TAG) - itag * 10;
    ThirdImageView *imageV = (ThirdImageView *)tap.view;
    ThirdImageView *imageV1 = (ThirdImageView *)forthImage[itag][iitag];
    if (tap.view != self.lastSelectThirdBtn) {
        [self playSoundEffect:@"effect" type:@"mp3"];
        // imageV.image = [UIImage imageNamed:imageV.selectImgName];
        //   imageV1.image = [UIImage imageNamed:imageV1.selectImgName];
        imageV.alpha = 1.0;
        imageV1.alpha = 1.0;
        if (self.lastSelectThirdBtn != nil) {
            NSInteger tag0 = (self.lastSelectThirdBtn.tag - BASE_THIRDIMAGE_TAG)/10;
            NSInteger tag1 = (self.lastSelectThirdBtn.tag - BASE_THIRDIMAGE_TAG) - tag0 * 10;
           // self.lastSelectThirdBtn.image = [UIImage imageNamed:self.lastSelectThirdBtn.imgName];
            if (self.lastSelectThirdBtn.alpha != 0.0) {
                 self.lastSelectThirdBtn.alpha = 0.65;
                ThirdImageView *imageV2 = (ThirdImageView *)forthImage[tag0][tag1];
                //  imageV2.image = [UIImage imageNamed:imageV2.imgName];
                imageV2.alpha = 0.65;
            }
        }
        self.lastSelectThirdBtn = imageV;
    }
    [self popViewControllerAnimated:NO];
    if (itag == 0) {
        [self pushViewController:[LocationController new] animated:NO];
    }else if (itag == 1) {
        [self pushViewController:[WaitingController new] animated:NO];
        
    }else if (itag == 2) {
        
    }else if (itag == 3) {
        switch (iitag) {
            case 0:
            {
                [self pushViewController:[BaoController  new] animated:NO];
                break;
            }
            case 1:
            {
                [self pushViewController:[LayoutController new] animated:NO];
                break;
            }
            case 2:
            {
                //  [self pushViewController:[BigEventController  new] animated:NO];
                break;
            }
            default:
                break;
        }
    }else if (itag == 4){
        switch (iitag) {
            case 0:{
                [self pushViewController:[WaitingController new] animated:NO];
                break;
            }
            case 1:{
                [self pushViewController:[WaitingController new] animated:NO];
                break;
            }
            default:
                break;
        }
    }else if (itag == 5){
        switch (iitag) {
            case 0:{
                    [self pushViewController:[BusinessShowController new] animated:NO];
                break;
            }
            case 1:{
                   [self pushViewController:[WaitingController new] animated:NO];
                break;
            }
            case 2:{
                [self pushViewController:[WaitingController new] animated:NO];
                break;
            }
            default:
                break;
        }
    }
}
//显示方式是确定圆心正下方的点，然后逆时针绘制点
- (void)showImage{
    self.circleView = [[Circle3DView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH- 1250 * 0.5 * 0.5 *  kW -179 * 0.5 * 0.22 *  kW , SCREEN_HEIGHT- 1250 * 0.5 * 0.5 *  kH-179 * 0.5 * 0.22 *  kH, 1250 * 0.5 *  kW, 1250 * 0.5 *  kW)];
    self.circleView.arrImages = self.arrImages;
    self.circleView.thirdImages = thirdImage;
    self.circleView.forthImages = forthImage;
    self.circleView.thirdRadius = _thirdRadiuArr;
    self.circleView.forthRadius = self.forthRadiuArr;
    self.circleView.baseImages = baseImages;
    self.circleView.centerImgView = imageviewCenterQuick;
    [self.view addSubview:self.circleView];
    [self.circleView loadView];
}


@end
