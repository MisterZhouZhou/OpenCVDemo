//
//  ZW_OpenCVImageTools.h
//  OpenCV-GrayImage
//
//  Created by limin on 17/4/6.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,ZWImageType){
    ZWImageType_OpenCV,
    ZWImageType_System
};
@interface ZW_OpenCVImageTools : NSObject

/**
 *  图像灰度处理
 ＊ @prama originImage 原始图片
 ＊ @return 灰度图片
 */
+ (UIImage *)openCVGrayImageWithType:(ZWImageType)type originImage:(UIImage *)originImg;

/**
 *  图像美白处理处理
 ＊ @prama originImage 原始图片
 ＊ @return 美白后图片
 */
+ (UIImage *)openCVWhiteImageWithType:(ZWImageType)type originImage:(UIImage *)originImg;

@end
