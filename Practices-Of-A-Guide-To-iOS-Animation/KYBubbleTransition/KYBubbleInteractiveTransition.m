//
//  KYBubbleInteractiveTransition.m
//  guji
//
//  Created by Kitten Yang on 5/16/15.
//  Copyright (c) 2015 Guji Tech Ltd. All rights reserved.
//

#import "KYBubbleInteractiveTransition.h"
#import "BubbleTransitionView.h"

@implementation KYBubbleInteractiveTransition{
    BubbleTransitionView *presentedView;
    CGFloat percent;
    UIView *panView;
}


-(void)addPopGesture:(UIView *)view{
//    view.transform = CGAffineTransformIdentity;
    presentedView = (BubbleTransitionView *)view;
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(edgeGesPan:)];
    [presentedView addGestureRecognizer:panGes];
}

-(void)edgeGesPan:(UIPanGestureRecognizer *)edgeGes{
    CGFloat translation =[edgeGes translationInView:presentedView].x;
    NSLog(@"%@",NSStringFromCGRect(presentedView.frame));
    percent = translation / (presentedView.bounds.size.width);
    percent = MIN(0.99, MAX(0.0, percent));
    
    switch (edgeGes.state) {
        case UIGestureRecognizerStateBegan:{
            self.interacting =  YES;
            UIViewController *vc = (UIViewController *)presentedView.delegate;
            [vc.navigationController popViewControllerAnimated:YES];
            //如果是navigationController控制，这里应该是[presentedVC.navigationController popViewControllerAnimated:YES];
            
            break;
        }
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:percent];
            break;
        }
            
        case UIGestureRecognizerStateEnded:{
            
            self.interacting = NO;
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
            
        default:
            break;
    }
}

@end
