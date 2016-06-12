//
//  LTDisplayVC.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/11/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "LTDisplayVC.h"
#import "ParentView.h"
#import "PingTransition/PingTransitionDemoView.h"
#import "PingTransition/CustomTransition.h"
@implementation LTDisplayVC{
    ParentView *demoView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self configWithDemoName:self.receivedDemoName];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

-(void)configWithDemoName:(NSString *)name{
    //CircleDemoView *demoView=[CircleDemoView demoView];
    self.title = name;
    demoView = [NSClassFromString(name) demoView];
    demoView.delegate = self;
    self.displayVCdelegate = demoView;
    
    if ([@"PingTransitionDemoView" isEqualToString:name]) {
        PingTransitionDemoView *PTView = (PingTransitionDemoView *)demoView;
        self.view = PTView;
    } else{
        if (demoView == nil) {
            UIAlertController *alvc=[UIAlertController alertControllerWithTitle:nil message:@"还没开始" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alvc addAction:cancleAction];
            [self presentViewController:alvc animated:YES completion:nil];
            return;
        }
        [self.view addSubview:demoView];
    }
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        CustomTransition *customTrans = [CustomTransition new];
        return customTrans;
    } else {
        return nil;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    NSNotificationCenter *noticeCenter = [NSNotificationCenter defaultCenter];
    [noticeCenter postNotificationName:@"disPlayVCWillPop" object:nil];
}

@end
