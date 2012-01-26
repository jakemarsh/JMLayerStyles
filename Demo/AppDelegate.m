//
//  AppDelegate.m
//  Demo
//
//  Created by Jake Marsh on 1/26/12.
//  Copyright (c) 2012 Rubber Duck Software. All rights reserved.
//

#import "AppDelegate.h"
#import "JMLayerStyles.h"

@implementation AppDelegate

@synthesize window = _window;

- (void) dealloc {
    [_window release];

    [super dealloc];
}
- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    JMStylableView *styledView = [[JMStylableView alloc] initWithFrame:CGRectMake(10.0, 30.0, self.window.bounds.size.width - 20.0, self.window.bounds.size.height - 40.0)];
    
    [styledView addLayerStyle:[DropShadowLayerStyle dropShadowStyleWithColor:[UIColor colorWithWhite:0.0 alpha:0.56]
                                                              distance:4.0
                                                                  size:4.5]];
    
    [styledView addLayerStyle:[InnerShadowLayerStyle innerShadowStyleWithColor:[UIColor colorWithRed:71.0/255.0 green:159.0/255.0 blue:243.0/255.0 alpha:1.0]
                                                                 opacity:1.0
                                                                distance:1.0
                                                                   choke:0.0
                                                                    size:0.0]];
    
    [styledView addLayerStyle:[StrokeLayerStyle strokeStyleWithColor:[UIColor colorWithRed:3.0/255.0 green:25.0/255.0 blue:47.0/255.0 alpha:1.0]
                                                       opacity:1.0
                                                          size:1.0]];
    
    [styledView addLayerStyle:[GradientOverlayLayerStyle gradientStyleWithColors:[NSArray arrayWithObjects:[UIColor colorWithRed:19.0/255.0 green:148.0/255.0 blue:213.0/255.0 alpha:1.0], [UIColor colorWithRed:10.0/255.0 green:71.0/255.0 blue:131.0/255.0 alpha:1.0], nil] 
                                                                     style:GradientOverlayStyleLinear]];
    
    styledView.cornerRadius = 10.0;

    [self.window addSubview:styledView];

    [styledView release];
    
    
    JMStylableView *buttonSortOfView = [[JMStylableView alloc] initWithFrame:CGRectMake(10.0, styledView.bounds.size.height - 54.0, styledView.bounds.size.width - 20.0, 44.0)];

    [buttonSortOfView addLayerStyle:[DropShadowLayerStyle dropShadowStyleWithColor:[UIColor colorWithRed:25.0/255.0 green:140.0/255.0 blue:198.0/255.0 alpha:0.4] 
                                                                          distance:1.0 
                                                                              size:0.0]];

    NSArray *colors = [NSArray arrayWithObjects:[UIColor colorWithRed:17.0/255.0 green:135.0/255.0 blue:194.0/255.0 alpha:1.0], [UIColor colorWithRed:10.0/255.0 green:81.0/255.0 blue:155.0/255.0 alpha:1.0], nil];
    [buttonSortOfView addLayerStyle:[GradientOverlayLayerStyle gradientStyleWithColors:colors style:GradientOverlayStyleLinear]];

    [buttonSortOfView addLayerStyle:[InnerShadowLayerStyle innerShadowStyleWithColor:[UIColor colorWithRed:23.0/255.0 green:159.0/255.0 blue:228.0/255.0 alpha:1.0] 
                                                                             opacity:1.0 
                                                                            distance:1.0 
                                                                               choke:0.0 
                                                                                size:0.0]];

    [buttonSortOfView addLayerStyle:[StrokeLayerStyle strokeStyleWithColor:[UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1.0] 
                                                                   opacity:1.0 
                                                                      size:1.0]];

    buttonSortOfView.cornerRadius = 5.0;

    [styledView addSubview:buttonSortOfView];

    [buttonSortOfView release];

    return YES;
}

- (void) applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void) applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void) applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void) applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end