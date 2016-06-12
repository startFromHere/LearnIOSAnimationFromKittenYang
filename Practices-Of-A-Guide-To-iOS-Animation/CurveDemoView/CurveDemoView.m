//
//  CurveDemoView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/14/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "CurveDemoView.h"
#import "ParentView.h"
#import "LTDisplayVC.h"
#import "KYPullToCurveView.h"
#import "KYPullToCurveView_footer.h"
#import "UIView+Convenient.h"

#define initialOffset 50.0
#define targetHeight 500.0

@interface CurveDemoView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation CurveDemoView{
    UILabel *navTitle;
    UIView *bkView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)config{
    _tableView = [[UITableView alloc]initWithFrame:self.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    self.backgroundColor = [UIColor redColor];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    [_tableView layoutIfNeeded];
    
    [self addSubview:_tableView];
    
    bkView = [[UIView alloc]init];
    bkView.center = CGPointMake(self.center.x, 22);
    bkView.bounds = CGRectMake(0, 0, 250, 44);
    bkView.clipsToBounds = YES;
    [self.delegate.navigationController.navigationBar addSubview:bkView];
    
    navTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 44+initialOffset, bkView.frame.size.width,44)];
    navTitle.alpha = 0;
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.textColor = [UIColor blackColor];
    navTitle.text = @"Fade in/out navbar title";
    [bkView addSubview:navTitle];
    
    [self willAppear];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat transitionY = MIN(MAX(0, scrollView.contentOffset.y+64) ,44+initialOffset+targetHeight);
    if (transitionY <= initialOffset) {
        navTitle.frame = CGRectMake(0, 44+initialOffset-transitionY, bkView.frame.size.width, 44);
    } else {
        CGFloat factor = MAX(0, MIN(1, (transitionY-initialOffset)/targetHeight));
        navTitle.frame = CGRectMake(0, 44-factor*44, bkView.frame.size.width, 44);
        navTitle.alpha = factor*factor*1;
    }
}


-(void)willAppear{
    
    KYPullToCurveView *headerView = [[KYPullToCurveView alloc]initWithAssociatedScrollView:self.tableView withNavigationBar:YES];
    
    
    __weak KYPullToCurveView *weakHeaderView = headerView;
    
    [headerView triggerPulling];
    
    [headerView addRefreshingBlock:^{
        
        //具体的操作
        //...
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [weakHeaderView stopRefreshing];
            
        });
        
    }];
    
    
    KYPullToCurveView_footer *footerView = [[KYPullToCurveView_footer alloc]initWithAssociatedScrollView:self.tableView withNavigationBar:YES];
    
    __weak KYPullToCurveView_footer *weakFooterView= footerView;
    
    [footerView addRefreshingBlock:^{
        
        //具体的操作
        //...
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [weakFooterView stopRefreshing];
            
        });
        
        
    }];

}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *testCell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
    testCell.textLabel.text = [NSString stringWithFormat:@"第%ld条",(long)indexPath.row];
    return testCell;
    
}












@end
