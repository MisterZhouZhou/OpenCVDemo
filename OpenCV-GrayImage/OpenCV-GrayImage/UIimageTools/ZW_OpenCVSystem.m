//
//  ZW_OpenCVSystem.m
//  OpenCV-GrayImage
//
//  Created by limin on 17/4/6.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZW_OpenCVSystem.h"

// 获取ARGB分量值
#define Mask8(x) ((x) & 0xFF)
#define R(x) (Mask8(x))
#define G(x) (Mask8(x >> 8))
#define B(x) (Mask8(x >> 16))
#define A(x) (Mask8(x >> 24))
#define RGBAMake(r,g,b,a) (Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24)

@implementation ZW_OpenCVSystem
/**
 *  图像灰度处理
 ＊ @prama originImage 原始图片
 ＊ @return 灰度图片
 */
- (UIImage *)zw_OpenCVGrayImageWithImage:(UIImage *)originImage{
    int width  = originImage.size.width;
    int height = originImage.size.height;
    //第一步：创建颜色空间(说白了就是开辟一块颜色内存空间)
    CGColorSpaceRef colorRef = CGColorSpaceCreateDeviceGray();
    //第二步：颜色空间上下文(保存图像数据信息)
    //参数一：指向这块内存区域的地址（内存地址）
    //参数二：要开辟的内存的大小，图片宽
    //参数三：图片高
    //参数四：像素位数(颜色空间，例如：32位像素格式和RGB的颜色空间，8位）
    //参数五：图片的每一行占用的内存的比特数
    //参数六：颜色空间
    //参数七：图片是否包含A通道（ARGB四个通道）
    CGContextRef context = CGBitmapContextCreate(NULL
                          , width, height, 8, 0, colorRef, kCGImageAlphaNone);
    //释放内存
    CGColorSpaceRelease(colorRef);
    
    if (context == nil) {
        return nil;
    }
    
    //渲染图片
    //参数一：上下文对象
    //参数二：渲染区域
    //源图片
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), originImage.CGImage);
    //将绘制的颜色空间转成CGImage
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    //将c/c++图片转成iOS可显示的图片
    UIImage *dstImage = [UIImage imageWithCGImage:grayImageRef];

    //释放内存
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    
    return dstImage;
}


/**
 *  图像美白处理处理
 ＊ @prama originImage 原始图片
 ＊ @return 美白后图片
 */
- (UIImage *)zw_OpenCVWhiteImageWithImage:(UIImage *)originImage{
    // 第一步 ：获取图片的大小
    // 目的：开辟内存空间
    CGImageRef imageRef = [originImage CGImage];
    NSUInteger widht = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    // 第二步 ：创建颜色空间(写死未彩色)
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    // 第三步 ：创建图片上下文（作用：保存图片信息）
    // 参数一：数据源（指向图片的指针,RGBA 4分量，每个分量8位，共4字节，像素指针32位）
    // 参数二：图片的宽
    // 参数三：图片的高
    // 参数四：每一个像素分量的大小（8）
    // 参数五：每一行占用的内存大小(最大RGBA 为4个字节)
    // 参数六：颜色空间
    // 参数七：布局参数
    // calloc(count ,size) count表示像素点点位数，size像素大小
    UInt32 *inputPixels = (UInt32*)calloc(widht *height, sizeof(UInt32));
   CGContextRef contextRef = CGBitmapContextCreate(inputPixels, widht, height, 8, widht*4, colorSpaceRef, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    // 第四步：根据图片的上下文绘制图片
    // 参数一：图片上下文信息
    // 参数二：图片的宽
    // 参数三：图片的高
    // 参数四：绘制的对象
    CGContextDrawImage(contextRef, CGRectMake(0, 0, widht, height), imageRef);
    
    // 第五步美白
    // 美白操作 －> 操作像素点 -> 操作分量
    // 亮度值
    int lumi = 30;
    for (int i = 0; i<height; i++) {
        for (int j = 0; j<widht; j++) {
            // 获取当前指针
            UInt32 *currentPixels = inputPixels + (i * widht) +j;
            UInt32 color = *currentPixels;
            // 操作像素点(操作像素值 -> 操作ARGB分量值)
            // 重新定义ARGB分量值
            UInt32 thisA,thisR,thisG,thisB;
            // 给四个分量重新赋值
            thisR = R(color);
            thisR = thisR + lumi;
            thisR = thisR > 255 ? 255:thisR;
            
            thisG = G(color);
            thisG = thisG + lumi;
            thisG = thisG > 255 ? 255:thisG;
            
            thisB = B(color);
            thisB = thisB + lumi;
            thisB = thisB > 255 ? 255:thisB;
            
            thisA = R(color);
        
            // 更新像素点
            *currentPixels = RGBAMake(thisR, thisG, thisB, thisA);
        }
    }
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // 释放内存
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(contextRef);
    CGImageRelease(newImageRef);
    
    return newImage;
}


@end
