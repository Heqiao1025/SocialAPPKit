//
//  AppDelegate.m
//  RunDemo
//
//  Created by ForC on 2018/4/19.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "AppDelegate.h"
#import "FCTwitterAppKit.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [TwitterInstance registerAppKey:@"HyjS1LXB00MCPibyxWVQ6aryX" appSecret:@"ZvB0idM0dfldEbaFPS90aYB2SpYBHcg85LyHnTtOmdyuCizlfD" redirectUrl:@"http://www.SocialApp.com"];
    [TwitterInstance registerAppKey:@"Ra9irghYlTm6BNURTUDZ9oLtI" appSecret:@"1arZZgZlXS4Hgk1FvG4JAPyHjwduon6GomEn79g0MQffGcatr2" redirectUrl:@"http://www.zywawa.com"];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
