//
//  ParentView.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/12/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTDisplayVC;
@interface ParentView : UIView

@property (nonatomic,weak) LTDisplayVC *delegate;

+(instancetype)demoView;

@end
