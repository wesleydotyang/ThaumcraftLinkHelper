//
//  AppDelegate.m
//  TCHelper
//
//  Created by Wesley Yang on 16/8/29.
//  Copyright © 2016年 ff. All rights reserved.
//

#import "AppDelegate.h"
#import "TCViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen.mainScreen bounds]];
    
    TCViewController *tc = [[TCViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:tc];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
