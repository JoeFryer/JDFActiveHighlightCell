//
//  JDFAppDelegate.m
//  JDFActiveHighlightCell
//
//  Created by Joe Fryer on 6/15/14
//  Copyright (c) 2014 JoeFryer. All rights reserved.
//

#import "JDFAppDelegate.h"

// View Controllers
#import "SampleTableViewController.h"


@implementation JDFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SampleTableViewController *tvc = [[SampleTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tvc];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
