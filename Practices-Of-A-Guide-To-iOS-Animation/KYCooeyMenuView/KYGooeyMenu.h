//
//  KYGooeyMenu.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/12/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol menuDidSelectedDelegate <NSObject>

-(void)menuDidSelected:(int)index;

@end

@interface KYGooeyMenu : UIView

@property (nonatomic,assign)int menuCount;
@property (nonatomic,assign)CGFloat radius;
@property (nonatomic,assign)CGFloat extraDistance;
@property (nonatomic,strong)UIView *mainView;
@property (nonatomic,strong)NSMutableArray *menuImagesArray;
@property (nonatomic,weak)id<menuDidSelectedDelegate> menuDelegate;

-(id)initWithOrigin:(CGPoint)origin andDiameter:(CGFloat)diameter andSuperView:(UIView *)superView themeColor:(UIColor *)themeColor;


@end
