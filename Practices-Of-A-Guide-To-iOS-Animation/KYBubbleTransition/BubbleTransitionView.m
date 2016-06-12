//
//  KYBubbleTransitionView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/12/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "BubbleTransitionView.h"
#import "KYBubbleInteractiveTransition.h"
@implementation BubbleTransitionView

-(void)config{
    
    NSLog(@"bubbleView:%@",self);
    KYBubbleInteractiveTransition *trans = [[KYBubbleInteractiveTransition alloc]init];
    [trans addPopGesture:self];
}

@end
