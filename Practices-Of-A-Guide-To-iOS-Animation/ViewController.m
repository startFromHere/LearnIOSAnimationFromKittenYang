//
//  ViewController.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/11/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "ViewController.h"
#import "LTUtilPackage.h"
#import "UIImage+Custom.h"
#import "LTDisplayVC.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *themes;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"DEMO列表";
//    LTUtilPackage *util=[[LTUtilPackage alloc]init];
//    themes=[util.themes copy];
    themes = @[
              @"CircleDemoView",
              @"CurveDemoView",
              @"DownloadButtonDemoView",
              @"DynamicActionBlockDemoView",
              @"GooeySlideMenuDemoView",
              @"InteractiveCardDemoView",
              @"JumpStarDemoView",
              @"BubbleTransitionView",
              @"GooeyMenuDemoView",
              @"LoadingHUDView",
              @"PingTransitionDemoView",
              @"MCFireworksButtonDemoView",
              @"SnowEffectsDemoView",
              @"SplashAnimationDemoView",
              @"tvOSCardAnimationDemoView",
              @"UIDynamicsDemoView"
              ];

    [self configTableView];
}

-(void)configTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return themes.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.imageView.image=[UIImage imageWithIndex:indexPath.row];
    cell.textLabel.text=themes[indexPath.row];
    
    UIView *seperateView=[[UIView alloc]initWithFrame:CGRectMake(0, cell.bounds.size.height-1, SCREENSIZE.width, 1)];
    seperateView.backgroundColor=[UIColor grayColor];
    [cell addSubview:seperateView];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *demoName=themes[indexPath.row];
    LTDisplayVC *displayVC=[[LTDisplayVC alloc]init];
    displayVC.receivedDemoName=demoName;
    [self.navigationController pushViewController:displayVC animated:YES];
}

@end
