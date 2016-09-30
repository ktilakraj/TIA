//
//  AppDelegate.m
//  TIA
//
//  Created by Swtya on 19/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeScreen.h"
#import "InfoScreen.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationPortraitUpsideDown;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [NSThread sleepForTimeInterval:3.0];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
   /* NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"HomeScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"HomeScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"HomeScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"HomeScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"HomeScreen 414";
    }
    
    HomeScreen *homeScreen = [[HomeScreen alloc] initWithNibName:homeXIB bundle:nil];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:homeScreen];*/
    
    
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"InfoScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"InfoScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"InfoScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"InfoScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"InfoScreen 414";
    }
    
    InfoScreen *swtyaInfoScreen = [[InfoScreen alloc] initWithNibName:homeXIB bundle:nil];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:swtyaInfoScreen];
    self.window.rootViewController = navCtrl;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
