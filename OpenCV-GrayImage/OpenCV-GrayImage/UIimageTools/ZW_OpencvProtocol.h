//
//  ZW_OpencvProtocol.h
//  OpenCV-GrayImage
//
//  Created by limin on 17/4/6.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZW_OpencvProtocol <NSObject>

/**
 *  图像灰度处理
 ＊ @prama originImage 原始图片
 ＊ @return 灰度图片
 */
@optional
- (UIImage *)zw_OpenCVGrayImageWithImage:(UIImage *)originImage;

/**
 *  图像美白处理处理
 ＊ @prama originImage 原始图片
 ＊ @return 美白后图片
 */
- (UIImage *)zw_OpenCVWhiteImageWithImage:(UIImage *)originImage;

@end

