//
//  SecondViewController.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 5/26/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomConvertTransition.h"

@interface SecondViewController ()

@end

@implementation SecondViewController{
    UIPercentDrivenInteractiveTransition *percentTransition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"page2.png"]];
    [self config];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

-(void)config{
    self.closeBTN = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    self.closeBTN.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.closeBTN];
    [self.closeBTN addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加pan手势
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePan:)];
    edgeGes.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgeGes];
}

-(void)close:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        CustomConvertTransition *customConvertTransition = [CustomConvertTransition new];
        return customConvertTransition;
    } else {
        return nil;
    }
}

-(void)edgePan:(UIPanGestureRecognizer *)recognizer{
    CGFloat per = [recognizer translationInView:self.view].x / self.view.bounds.size.width;
    per = MIN(1.0, MAX(0.0, per));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        percentTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [percentTransition updateInteractiveTransition:per];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (per>0.3) {
            [percentTransition finishInteractiveTransition];
        } else {
            [percentTransition cancelInteractiveTransition];
        }
        percentTransition = nil;
    }
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                        interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return percentTransition;
}

@end
