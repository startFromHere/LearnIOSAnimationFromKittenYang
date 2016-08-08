//
//  WaterWaveDemoView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 8/7/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "WaterWaveDemoView.h"
#import "LTWave.h"

@interface WaterWaveDemoView()<LTWaveDelegate>

@end

@implementation WaterWaveDemoView{
    UIImageView *pic_white_view;
    UIImageView *pic_red_view;
}

- (void)config{
    pic_white_view = [self setUpImageViewWithImageName:@"pic_white"];
    pic_red_view = [self setUpImageViewWithImageName:@"pic_red"];
    [self setUpWave];
}

- (UIImageView *)setUpImageViewWithImageName:(NSString *)imageName{
    CGRect rect = CGRectMake(0, 0, 100, 100);
    UIImageView *view = [[UIImageView alloc]initWithFrame:rect];
    view.image = [UIImage imageNamed:imageName];
    view.center = self.center;
    [self addSubview:view];
    return view;
}

- (void)setUpWave{
    LTWave *wave = [[LTWave alloc]initWithFrame:pic_red_view.bounds];
    wave.delegate = self;
    wave.waterDepth = 0.5;
}


#pragma mark --LTWaveDelegate

-(void)waterWave:(LTWave *)waterWave path:(UIBezierPath *)path{
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;
    pic_red_view.layer.mask = layer;
}

@end
