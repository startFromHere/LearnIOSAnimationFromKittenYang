//
//  LTDisplayVC.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/11/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "LTDisplayVC.h"
#import "CircleDemoView.h"
@implementation LTDisplayVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self configWithDemoName:self.receivedDemoName];
}

-(void)configWithDemoName:(NSString *)name{
    //CircleDemoView *demoView=[CircleDemoView demoView];
    self.title = name;
    ParentView *demoView = [NSClassFromString(name) demoView];
    demoView.delegate = self;
    if (demoView == nil) {
        UIAlertController *alvc=[UIAlertController alertControllerWithTitle:nil message:@"还没开始" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alvc addAction:cancleAction];
        [self presentViewController:alvc animated:YES completion:nil];
        return;
    }
    
    [self.view addSubview:demoView];
}


@end
