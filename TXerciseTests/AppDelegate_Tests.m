//
//  AppDelegate_Tests.m
//  TXercise
//
//  Created by porori on 13. 1. 18..
//  Copyright (c) 2013년 porori. All rights reserved.
//

#import "AppDelegate_Tests.h"

@implementation AppDelegate_Tests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    appDelegate = [[AppDelegate alloc] init];
    [appDelegate application:nil didFinishLaunchingWithOptions:nil];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)test
{
    STAssertTrue([appDelegate.window.rootViewController isKindOfClass:[UINavigationController class]], @"window rootViewController has to be navi controller");
    
    UINavigationController *naviController = (UINavigationController *)appDelegate.window.rootViewController;
    
    STAssertTrue([naviController.topViewController isKindOfClass:[MainViewController class]], @"navi rootViewController has to be MainViewController");
}

@end
