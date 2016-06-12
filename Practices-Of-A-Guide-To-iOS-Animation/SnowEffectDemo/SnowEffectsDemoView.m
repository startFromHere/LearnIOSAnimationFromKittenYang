//
//  SnowEffectDemoView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/12/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "SnowEffectsDemoView.h"

@implementation SnowEffectsDemoView

-(void)config{
    CAEmitterLayer *snowEmitterLayer = [CAEmitterLayer layer];
    
    snowEmitterLayer.emitterPosition = CGPointMake(self.bounds.size.width/2, -30);
    snowEmitterLayer.emitterSize = CGSizeMake(self.bounds.size.width, 0.0);
    snowEmitterLayer.emitterShape = kCAEmitterLayerLine;
    snowEmitterLayer.emitterMode = kCAEmitterLayerOutline;
    
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.birthRate = 1.0;
    snowflake.lifetime = 120.0;
    snowflake.velocity = -10;
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 2;
    snowflake.emissionRange = 0.5 * M_PI;
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents = (id)[[UIImage imageNamed:@"snow"] CGImage];
    snowflake.color = [[UIColor colorWithRed:0.6 green:0.658 blue:0.743 alpha:1] CGColor];
    
    snowEmitterLayer.shadowOpacity = 1.0;
    snowEmitterLayer.shadowRadius = 0.0;
    snowEmitterLayer.shadowOffset = CGSizeMake(0.0, 1.0);
    snowEmitterLayer.shadowColor = [UIColor whiteColor].CGColor;
    snowEmitterLayer.emitterCells = [NSArray arrayWithObject:snowflake];
    
    [self.layer insertSublayer:snowEmitterLayer atIndex:0];
}

@end
