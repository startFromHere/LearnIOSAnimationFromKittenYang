//
//  LabelView.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/20/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,PULLINGSTATE) {
    UP,
    DOWN,
};

@interface LabelView : UIView

@property(nonatomic,assign)CGFloat progress;
@property(nonatomic,assign)BOOL loading;
@property(nonatomic,assign)PULLINGSTATE state;

@end
