//
//  AppDelegate.m
//  trello-client
//
//  Created by Simon Chaffetz on 4/27/14.
//  Copyright (c) 2014 Simon Chaffetz. All rights reserved.
//

#import "AppDelegate.h"
#import "Card.h"
#import "ListViewController.h"
#import "Parse/Parse.h"
#import "Environment.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [Parse setApplicationId:PARSE_APP_ID
                  clientKey:PARSE_CLIENT_KEY];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    NSMutableArray *cards = [[NSMutableArray alloc] init];
    void (^parseSuccessCallback)(NSArray*, NSError*) = ^void(NSArray *objects, NSError *error) {
        if (!error) {
            [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                Card *card = [[Card alloc] initWithTitle:obj[@"title"] body:obj[@"body"]];
                [cards addObject:card];
                ListViewController *listVC = [[ListViewController alloc] initWithCards:cards];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:listVC];
                self.window.rootViewController = navController;

            }];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    };

    PFQuery *query = [PFQuery queryWithClassName:@"Card"];
    [query findObjectsInBackgroundWithBlock:parseSuccessCallback];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
