//
//  LTDisplayVC.h
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/11/15.
//  Copyright © 2015 LT. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol DisPlayVCDelegate <NSObject>
-(void)displayVCWillPop;
@end

@interface LTDisplayVC : UIViewController<UINavigationControllerDelegate>

@property (nonatomic,strong)NSString *receivedDemoName;
@property (nonatomic,weak)id<DisPlayVCDelegate> displayVCdelegate;

@end
