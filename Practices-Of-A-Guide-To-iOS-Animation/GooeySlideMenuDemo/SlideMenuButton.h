//
//  SlideMenuButton.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/14/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuButton : UIView

-(id)initWithTitle:(NSString *)title;

@property(nonatomic,strong)UIColor *buttonColor;

@property(nonatomic,copy)void(^buttonClickBlock)(void);


@end
