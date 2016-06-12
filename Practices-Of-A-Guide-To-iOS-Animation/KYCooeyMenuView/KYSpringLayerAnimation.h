//
//  KYSpringLayerAnimation.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/12/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KYSpringLayerAnimation : NSObject

+(instancetype)sharedAnimManager;

-(CAKeyframeAnimation *)createBasicAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue;

-(CAKeyframeAnimation *)createSpringAnima:(NSString *)keypath duration:(CFTimeInterval)duration usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity fromValue:(id)fromValue toValue:(id)toValue;

-(CAKeyframeAnimation *)createCurveAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue;

-(CAKeyframeAnimation *)createHalfCurveAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue;


@end
