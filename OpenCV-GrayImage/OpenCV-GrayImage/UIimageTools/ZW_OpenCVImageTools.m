//
//  ZW_OpenCVImageTools.m
//  OpenCV-GrayImage
//
//  Created by limin on 17/4/6.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZW_OpenCVImageTools.h"
#import "ZW_OpencvProtocol.h"
#import "ZW_OpenCVImage.h"
#import "ZW_OpenCVSystem.h"

@implementation ZW_OpenCVImageTools

+ (UIImage *)openCVGrayImageWithType:(ZWImageType)type originImage:(UIImage *)originImg{
    UIImage *img = nil;
    id<ZW_OpencvProtocol> pro = nil;
    if (type == ZWImageType_OpenCV) {
        pro = [ZW_OpenCVImage new];
    }
    else if (type == ZWImageType_System){
        pro = [ZW_OpenCVSystem new];
    }
    img = [pro zw_OpenCVGrayImageWithImage:originImg];
    return img;
}

+ (UIImage *)openCVWhiteImageWithType:(ZWImageType)type originImage:(UIImage *)originImg{
    UIImage *img = nil;
    id<ZW_OpencvProtocol> pro = nil;
    if (type == ZWImageType_OpenCV) {
        pro = [ZW_OpenCVImage new];
    }
    else if (type == ZWImageType_System){
        pro = [ZW_OpenCVSystem new];
    }
    img = [pro zw_OpenCVWhiteImageWithImage:originImg];
    return img;
}

@end
