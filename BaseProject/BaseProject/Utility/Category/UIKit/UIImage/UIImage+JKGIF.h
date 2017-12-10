//
//  UIImage+GIF.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (JKGIF)

+ (UIImage *)bp_animatedGIFNamed:(NSString *)name;

+ (UIImage *)bp_animatedGIFWithData:(NSData *)data;

- (UIImage *)bp_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
