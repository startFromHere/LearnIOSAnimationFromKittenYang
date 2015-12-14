//
//  CircleDemoView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/12/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "CircleDemoView.h"
#import "CircleLayer.h"

@interface CircleDemoView(){
    UISlider *slider;
}

@end

@implementation CircleDemoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(Class)layerClass{

    //此方法有什么作用？
    return [CircleLayer class];

}

-(void)config{
    self.circleLayer = [CircleLayer layer];
    self.circleLayer.frame = self.bounds;
    self.circleLayer.contentsScale = [UIScreen mainScreen].scale;
    
    
    //添加滑动条
    slider=[[UISlider alloc]initWithFrame:CGRectMake(0, SCREENSIZE.height-40, SCREENSIZE.width, 40)];
    [slider addTarget:self action:@selector(slide) forControlEvents:UIControlEventValueChanged];
    slider.value=0.5;
    [self.layer addSublayer:self.circleLayer];
    [self addSubview:slider];
    self.circleLayer.progress=slider.value;
}

-(void)slide{
    self.circleLayer.progress=slider.value;
}


@end
