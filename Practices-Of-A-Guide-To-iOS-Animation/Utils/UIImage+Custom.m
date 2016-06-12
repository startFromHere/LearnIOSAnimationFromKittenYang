//
//  UIImage+Custom.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/11/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "UIImage+Custom.h"

@implementation UIImage (Custom)

+(UIImage *)imageWithIndex:(NSInteger)index{
    
    NSString *numStr=[NSString stringWithFormat:@"%ld",index];
    
    CGSize size=CGSizeMake(50, 50);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef contex=UIGraphicsGetCurrentContext();
    CGContextSetCharacterSpacing(contex, 40);
    CGContextSetTextDrawingMode(contex, kCGTextFillStroke);
    CGContextSetRGBFillColor(contex, 0.1, 0.2, 0.3, 1);
    
    CGRect rect=CGRectMake(5, 13, 50, 50);
    NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    [numStr drawInRect:rect withAttributes:fontDic];
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
