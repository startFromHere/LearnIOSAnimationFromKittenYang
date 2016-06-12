//
//  UIView+Convenient.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/20/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect CGRectMoveToCenter(CGRect rect,CGPoint center);

@interface UIView (Convenient)

@property CGPoint origin;
@property CGSize size;
@property (readonly)CGPoint bottomLeft;
@property (readonly)CGPoint bottomRight;
@property (readonly)CGPoint topRight;
@property CGFloat height;
@property CGFloat width;
@property CGFloat top;
@property CGFloat left;
@property CGFloat bottom;
@property CGFloat right;
@property CGFloat x;
@property CGFloat y;

- (void)moveBy:(CGFloat)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInsize:(CGSize)aSize;

@end
