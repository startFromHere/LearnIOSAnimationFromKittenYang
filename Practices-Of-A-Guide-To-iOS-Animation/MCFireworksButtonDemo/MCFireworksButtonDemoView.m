//
//  MCFireworksButton.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/28/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "MCFireworksButtonDemoView.h"
#import "MCFireworksButton.h"

@interface MCFireworksButtonDemoView()

@property (strong,nonatomic) MCFireworksButton *likeBTN;

@end

@implementation MCFireworksButtonDemoView{
    BOOL _selected;
}


- (void)config{
    self.likeBTN = [[MCFireworksButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self.likeBTN setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    self.likeBTN.center = self.center;
    [self addSubview:self.likeBTN];
    self.likeBTN.particleImage = [UIImage imageNamed:@"Sparkle"];
    self.likeBTN.particleScale = 0.05;
    self.likeBTN.particleScaleRange = 0.02;
    [self.likeBTN addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleButtonPress:(id)sender {
    _selected = !_selected;
    if (_selected) {
        [self.likeBTN popOutSideWithDuration:0.5];
        [self.likeBTN setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        [self.likeBTN animate];
    }else {
        [self.likeBTN popInsideWithDuration:0.4];
        [self.likeBTN setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
}




@end
