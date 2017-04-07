//
//  ZW_OpenCVImage.m
//  OpenCV-GrayImage
//
//  Created by limin on 17/4/6.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZW_OpenCVImage.h"
// 导入opencv头文件（核心头文件）
#import <opencv2/opencv.hpp>
// 让opencv支持iOS平台
#import <opencv2/imgcodecs/ios.h>
// 导入c++命名空间
using namespace cv;

// 磨皮效果
int MAX = 20;

@implementation ZW_OpenCVImage
/**
 *  图像灰度处理
 ＊ @prama originImage 原始图片
 ＊ @return 灰度图片
 */
- (UIImage *)zw_OpenCVGrayImageWithImage:(UIImage *)originImage{
    // 第一步将iOS -UIImage  -> opencv认识的图片
    // 参数一：原文件
    // 参数二：目标文件
    // Mat :opencv中基本数据类型
    Mat mat_image_color;
    UIImageToMat(originImage, mat_image_color);
    
    // 第二步 将彩色图片－>灰色图片
    // 参数一：原文件
    // 参数二：目标文件
    // 参数三：转换类型
    Mat mat_image_gray;
    cvtColor(mat_image_color, mat_image_gray, COLOR_RGB2GRAY);
    
    // 第三步 将opencv的图片  -> UIImage可识别的图片
    cvtColor(mat_image_gray, mat_image_color, COLOR_GRAY2RGB);

    // 第四步  opencv认识的图片 -> iOS -UIImage
    UIImage *imageGray = MatToUIImage(mat_image_color);
    
    return imageGray;
}

/**
 *  图像美白处理处理
 ＊ @prama originImage 原始图片
 ＊ @return 美白后图片
 */
- (UIImage *)zw_OpenCVWhiteImageWithImage:(UIImage *)originImage{
    //第一步 ： iOS 图片转OpenCv图片(四通道)
    Mat mat_image_src;
    UIImageToMat(originImage, mat_image_src);
    
    //第二步 图片(四通道)转 三通道
    Mat mat_image_dst;
    cvtColor(mat_image_src, mat_image_dst, CV_RGBA2RGB,3);
    
    // 第三步 ：克隆一个数据用于美白
    Mat mat_image_clone = mat_image_dst.clone();
    
    // 第四步：开始美白
    for (int i = 1; i < MAX; i += 2) {
        // 磨皮效果
        // 参数一：原始图片
        // 参数二：模版图片
        // 参数三：下标
        bilateralFilter(mat_image_dst, mat_image_clone, i, i * 2, i / 2);
    }

    // 第五步 ：将OpenCv图片转iOS图片
    return MatToUIImage(mat_image_clone);
}

@end
