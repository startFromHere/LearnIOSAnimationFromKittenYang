//
//  PingTransition.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/26/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "ParentView.h"
@class LTDisplayVC;
typedef void(^myBlock)();

@interface PingTransitionDemoView : ParentView

@property (strong, nonatomic) UIButton *openBTN;

@end
