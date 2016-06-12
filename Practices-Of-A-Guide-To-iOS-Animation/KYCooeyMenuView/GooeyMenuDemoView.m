//
//  KYGooeyMenuView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/12/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "GooeyMenuDemoView.h"

@interface GooeyMenuDemoView ()<menuDidSelectedDelegate>

@property (strong,nonatomic) UISwitch *showDebugPoints;
@property (strong,nonatomic) UILabel *min;
@property (strong,nonatomic) UILabel *current;
@property (strong,nonatomic) UISlider *slider;
@property (strong,nonatomic) Menu *menu;

@end

@implementation GooeyMenuDemoView{
    KYGooeyMenu *gooeyMenu;
}

-(void)config{
    [self setUpSlider];
    
    self.min.text = [NSString stringWithFormat:@"%d",(int)self.slider.minimumValue];
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.slider.hidden = YES;
    self.min.hidden = YES;
    self.current.hidden = YES;
    
    //    gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(CGRectGetMidX(self.view.frame)-50, 500) andDiameter:100.0f andSuperView:self.view themeColor:[UIColor redColor]];
    gooeyMenu.menuDelegate = self;
    gooeyMenu.radius = 100/4;//大圆的1/4
    gooeyMenu.extraDistance = 20;
    gooeyMenu.menuCount = 5;
    gooeyMenu.menuImagesArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"tabbarItem_discover highlighted"],[UIImage imageNamed:@"tabbarItem_group highlighted"],[UIImage imageNamed:@"tabbarItem_home highlighted"],[UIImage imageNamed:@"tabbarItem_message highlighted"],[UIImage imageNamed:@"tabbarItem_user_man_highlighted"], nil];
    
    
    
    
    //*******Second version*******
    _menu = [[Menu alloc]initWithFrame:CGRectMake(self.center.x-50, self.frame.size.height - 200, 100, 100)];
    [self addSubview:_menu];
    [self.showDebugPoints addTarget:self action:@selector(showDebug:) forControlEvents:UIControlEventValueChanged];
}

-(void)setUpSlider{
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-50, self.bounds.size.height-120, 100, 40)];
    [self addSubview:self.slider];
    
    self.showDebugPoints = [[UISwitch alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-30, self.bounds.size.height-60, 60, 40)];
    [self addSubview:self.showDebugPoints];
    [self.showDebugPoints addTarget:self action:@selector(showDebug:) forControlEvents:UIControlEventValueChanged];
    self.min = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.min.center = CGPointMake(self.slider.frame.origin.x - 50 , self.slider.center.y);
    self.current.center = CGPointMake(self.slider.frame.origin.x + 110 , self.slider.center.y);
    
    [self addSubview:self.min];
    [self addSubview:self.current];
}

-(void)showDebug:(UISwitch *)sender{
    
    if (sender.on) {
        _menu.menuLayer.showDebug = YES;
    }else{
        _menu.menuLayer.showDebug = NO;
    }
    
    [_menu.menuLayer setNeedsDisplay];
    
}


#pragma mark -- 彩单选中的代理方法
-(void)menuDidSelected:(int)index{
    NSLog(@"选中第%d",index);
}


- (void)sliderValueChanged:(UISlider *)sender {
    self.current.text = [NSString stringWithFormat:@"%d",(int)sender.value];
    
    gooeyMenu.menuCount = (int)sender.value;
    
}

@end
