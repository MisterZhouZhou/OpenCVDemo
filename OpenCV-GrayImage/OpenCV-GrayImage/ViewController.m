//
//  ViewController.m
//  OpenCV-GrayImage
//
//  Created by limin on 17/4/6.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ZW_OpenCVImageTools.h"

@interface ViewController ()
@property(nonatomic,weak) UIImageView *imgv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(60, 100, 200, 200)];
    imgV.image = [UIImage imageNamed:@"test"];
    [self.view addSubview:imgV];
    self.imgv = imgV;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 灰度
    // self.imgv.image = [ZW_OpenCVImageTools openCVGrayImageWithType:ZWImageType_System originImage:self.imgv.image];
    
    // 美白
    self.imgv.image = [ZW_OpenCVImageTools openCVWhiteImageWithType:ZWImageType_OpenCV originImage:self.imgv.image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
