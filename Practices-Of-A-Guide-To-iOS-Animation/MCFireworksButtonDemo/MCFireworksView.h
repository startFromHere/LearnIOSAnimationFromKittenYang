//
//  MCFireworksView.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/30/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCFireworksView : UIButton

@property (nonatomic, strong) UIImage *particleImage;
@property (nonatomic, assign) CGFloat particleScale;
@property (nonatomic, assign) CGFloat particleScaleRange;

- (void)animate;

@end
