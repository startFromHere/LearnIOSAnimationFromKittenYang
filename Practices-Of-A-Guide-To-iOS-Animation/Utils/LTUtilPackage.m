//
//  LTUtilPackage.m
//  Practices-Of-A-Guide-To-iOS-Animation
//
//  Created by 刘涛 on 12/11/15.
//  Copyright © 2015 LT. All rights reserved.
//

#import "LTUtilPackage.h"

@interface LTUtilPackage (){
    NSFileManager *_fm;
}
@end

@implementation LTUtilPackage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fm=[NSFileManager defaultManager];
    }
    return self;
}

-(NSMutableArray *)themes{
    if (!_themes) {
        NSError *error;
        _themes=[NSMutableArray array];
        NSString *path=@"/Users/liutao/Desktop/sourceCodeDownload/IOS/A-GUIDE-TO-iOS-ANIMATION-master";
        NSArray *files=[_fm contentsOfDirectoryAtPath:path error:&error];
        
        for (NSString *theme in files) {
            NSString *fullPath=[path stringByAppendingPathComponent:theme];
            BOOL isDirectory;
            [_fm fileExistsAtPath:fullPath isDirectory:&isDirectory];
            if (isDirectory) {
                //修改名称
                NSString *name = theme;
                if ([theme rangeOfString:@"Animated"].length>0) {
                    name = [theme substringFromIndex:[@"Animated" length]];
                }
                if ([theme rangeOfString:@"KY"].length>0) {
                    name = [theme substringFromIndex:[@"KY" length]];
                }
                
                name = [name stringByAppendingString:@"View"];

                [_themes addObject:name];
            }
        }
    }
    NSLog(@"themes:%@",_themes);
    return _themes;
}



@end
