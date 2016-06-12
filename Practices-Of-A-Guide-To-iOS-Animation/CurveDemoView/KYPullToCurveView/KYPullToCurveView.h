//
//  KYPullToCurveView.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/20/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface KYPullToCurveView : UIView

@property(nonatomic,assign)CGFloat pullDistance;

-(id)initWithAssociatedScrollView:(UIScrollView *)scrollView withNavigationBar:(BOOL)navBar;
-(void)triggerPulling;
-(void)stopRefreshing;
-(void)addRefreshingBlock:(void(^)(void))block;

@end
