//
//  DownLoadButtonDemoView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/7/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "DownloadButtonDemoView.h"

@implementation DownloadButtonDemoView

-(void)config{
    self.downloadBTN = [[DownButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.downloadBTN.layer.cornerRadius = 50;
    
    self.downloadBTN.progressBarWidth  = 200;
    self.downloadBTN.progressBarHeight = 30;
    self.downloadBTN.backgroundColor = [UIColor blueColor];
    
    [self addSubview:self.downloadBTN];
    self.downloadBTN.center = self.center;
}

@end
