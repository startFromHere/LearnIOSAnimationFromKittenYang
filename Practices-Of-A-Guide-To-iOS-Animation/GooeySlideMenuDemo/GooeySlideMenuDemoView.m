//
//  GooeySlideMenuDemo.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/14/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "GooeySlideMenuDemoView.h"
#import "GooeySlideMenu.h"
#import "LTDisplayVC.h"

@interface GooeySlideMenuDemoView ()<UITableViewDataSource,UITableViewDelegate>{
    GooeySlideMenu *menu;
}
@end

@implementation GooeySlideMenuDemoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)config{
    self.delegate.title=@"首页";
    menu = [[GooeySlideMenu alloc]initWithTitles:@[@"首页",@"消息",@"发布",@"发现",@"个人",@"设置"]];
    menu.menuClickBlock = ^(NSInteger index,NSString *title,NSInteger titleCounts){
        NSLog(@"index:%ld title:%@ titleCounts:%ld",index,title,titleCounts);
    };
    
    [self addSubViews];
    
   
}

-(void)addSubViews{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height)];
    tableView.delegate=self;
    tableView.dataSource=self;
    
    //[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self addSubview:tableView];
    
    UIButton *trigerBTN = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    trigerBTN.frame = CGRectMake(SCREENSIZE.width-100, SCREENSIZE.height-100, 80, 50);
    [trigerBTN setTitle:@"triger" forState:UIControlStateNormal];
    [trigerBTN setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [trigerBTN addTarget:self action:@selector(triger:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:trigerBTN];
}

-(void)triger:(UIButton *)button{
    [menu trigger];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"NO.%ld",(long)indexPath.row];
    
    return cell;
}


@end
