//
//  MCFireworksButton.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/28/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCFireworksButton : UIButton

@property (nonatomic,strong) UIImage *particleImage;
@property (nonatomic,assign) CGFloat particleScale;
@property (nonatomic,assign) CGFloat particleScaleRange;

- (void)animate;
- (void)popOutSideWithDuration:(NSTimeInterval)duration;
- (void)popInsideWithDuration:(NSTimeInterval)duration;

@end
