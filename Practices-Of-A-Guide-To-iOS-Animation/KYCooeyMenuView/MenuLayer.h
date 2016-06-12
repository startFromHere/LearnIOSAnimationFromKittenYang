//
//  MenuLayer.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/12/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,STATE) {
    STATE1,
    STATE2,
    STATE3
};

@interface MenuLayer : CALayer

@property (nonatomic,assign)BOOL showDebug;
@property (nonatomic,assign)STATE animState;
@property (nonatomic,assign)CGFloat xAxisPercent;

@end
