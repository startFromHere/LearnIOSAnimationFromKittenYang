//
//  GooeySlideMenu.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/14/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MenuButtonClickedBlock)(NSInteger index,NSString *title,NSInteger titleCounts);

@interface GooeySlideMenu : UIView

-(id)initWithTitles:(NSArray *)titles;

-(id)initWithTitles:(NSArray *)titles withButtonHeight:(CGFloat)height withMenuColor:(UIColor *)menuColor withBackBlurStyle:(UIBlurEffectStyle)style;

-(void)trigger;

@property(nonatomic,assign)CGFloat menuButtonHeight;

@property(nonatomic,copy)MenuButtonClickedBlock menuClickBlock;

@end
