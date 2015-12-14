//
//  ParentView.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/12/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "ParentView.h"
#import "LTDisplayVC.h"
@implementation ParentView

+(instancetype)demoView{
    ParentView *parentView=[[[self class] alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height)];
    [parentView config];
    return parentView;
}

-(void)config{

}
@end
