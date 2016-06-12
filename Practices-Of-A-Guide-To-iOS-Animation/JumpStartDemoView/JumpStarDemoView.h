//
//  JumpStartDemoView.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 6/5/16.
//  Copyright © 2016 LT. All rights reserved.
//

#import "ParentView.h"

typedef enum : NSUInteger {
    non_Mark,
    Mark,
}STATE;

@interface JumpStarDemoView : ParentView

-(void)animate;

@property (nonatomic,assign,setter=setState:)STATE state;

@property (nonatomic,strong)UIImage *markedImage;
@property (nonatomic,strong)UIImage *non_markedImage;

@end
