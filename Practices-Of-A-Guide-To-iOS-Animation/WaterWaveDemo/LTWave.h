//
//  LTWave.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 8/7/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTWave;
@protocol LTWaveDelegate <NSObject>

- (void)waterWave:(LTWave *)waterWave path:(UIBezierPath *)path;

@end

@interface LTWave : NSObject

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,assign)CGFloat waterDepth;
@property (nonatomic,weak) id<LTWaveDelegate> delegate;

@end
