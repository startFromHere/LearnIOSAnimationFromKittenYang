//
//  PingTransition.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/26/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "PingTransitionDemoView.h"
#import "SecondViewController.h"
#import "LTDisplayVC.h"
@implementation PingTransitionDemoView{
    SecondViewController *secondVC;
}

-(void)config{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"page1.png"]];
    self.openBTN = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-90, 10, 80, 80)];
    self.openBTN.backgroundColor = [UIColor clearColor];
    [self addSubview:self.openBTN];
    [self.openBTN addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
//    self.alpha = 0.1;
    
    NSLog(@"self.openButton:%@",self.openBTN);
    NSLog(@"PTView:%@",self);
}


-(void)open:(UIButton *)button{
    LTDisplayVC *firstVC = (LTDisplayVC *)self.delegate;
    if (!secondVC) {
        secondVC = [SecondViewController new];
    }
    [firstVC.navigationController pushViewController:secondVC animated:YES];
}


@end
