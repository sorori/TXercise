//
//  MainViewController_Tests.m
//  TXercise
//
//  Created by porori on 13. 1. 19..
//  Copyright (c) 2013년 porori. All rights reserved.
//

#import "MainViewController_Tests.h"
#import "FakeUITouch.h"
#import <objc/objc-runtime.h>

@implementation MainViewController_Tests

- (void)setUp
{
    [super setUp];
    
    mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    yellowView = [[UIImageView alloc] init];
    greenView = [[UIImageView alloc] init];
    
    mainViewController.yellowView = yellowView;
    mainViewController.greenView = greenView;
    
    [mainViewController viewDidLoad];
}

- (void)tearDown
{
    mainViewController = nil;
    [super tearDown];
}

- (void)testMainViewControllerHasTwoImageView
{
    objc_property_t yellowViewProperty = class_getProperty([MainViewController class], "yellowView");
    STAssertTrue(yellowViewProperty != nil, @"yellowView is not set for property");
    
    objc_property_t greenViewProperty = class_getProperty([MainViewController class], "greenView");
    STAssertTrue(greenViewProperty != nil, @"greenView is not set for property");
    
    STAssertNotNil(mainViewController.yellowView, @"yellowView is not initialized");
    STAssertNotNil(mainViewController.greenView, @"greenView is not initialized");
}

- (void)testTwoImageViewHasCorrectZPositionInInitialize
{
    STAssertEquals(mainViewController.yellowView.layer.zPosition, 1.f, @"yellowView zPosition is not 1");
    STAssertEquals(mainViewController.greenView.layer.zPosition, 2.f, @"greenView zPosition is not 2");
}

- (void)testTouchMovedLeftSlight
{
    // first touch at 100, 100
    FakeUITouch *touch1 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(100, 100)];
    NSSet *touchSet1 = [[NSSet alloc] initWithObjects:touch1, nil];
    [mainViewController touchesBegan:touchSet1 withEvent:nil];
    
    // touch moved to 95, 100
    FakeUITouch *touch2 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(105, 100)];
    NSSet *touchSet2 = [[NSSet alloc] initWithObjects:touch2, nil];
    [mainViewController touchesMoved:touchSet2 withEvent:nil];
    
    STAssertEquals(mainViewController.yellowView.layer.zPosition, 1.f, @"yellowView zPosition is not 1");
    STAssertEquals(mainViewController.greenView.layer.zPosition, 2.f, @"greenView zPosition is not 2");
    STAssertEquals(mainViewController.yellowView.frame.origin.x, -5.f, @"yellowView has to move -5, 0");
    STAssertEquals(mainViewController.greenView.frame.origin.x, 5.f, @"greenView has to move 5, 0");
}

- (void)testTouchSwipeRightAndLeft
{
    // first touch at 100, 100
    FakeUITouch *touch1 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(100, 100)];
    NSSet *touchSet1 = [[NSSet alloc] initWithObjects:touch1, nil];
    [mainViewController touchesBegan:touchSet1 withEvent:nil];
    
    // touch moved to 130, 100
    FakeUITouch *touch2 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(130, 100)];
    NSSet *touchSet2 = [[NSSet alloc] initWithObjects:touch2, nil];
    [mainViewController touchesMoved:touchSet2 withEvent:nil];
    
    // touch ended
    FakeUITouch *touch3 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(130, 100)];
    NSSet *touchSet3 = [[NSSet alloc] initWithObjects:touch3, nil];
    [mainViewController touchesEnded:touchSet3 withEvent:nil];
    
    STAssertEquals(mainViewController.yellowView.layer.zPosition, 2.f, @"yellowView zPosition is not 2");
    STAssertEquals(mainViewController.greenView.layer.zPosition, 1.f, @"greenView zPosition is not 1");
    STAssertEquals(mainViewController.yellowView.frame.origin.x, 0.f, @"yellowView has to back 0, 0");
    STAssertEquals(mainViewController.greenView.frame.origin.x, 0.f, @"greenView has to move 0, 0");
    
    // first touch at 100, 100
    FakeUITouch *touch4 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(100, 100)];
    NSSet *touchSet4 = [[NSSet alloc] initWithObjects:touch4, nil];
    [mainViewController touchesBegan:touchSet4 withEvent:nil];
    
    // touch moved to 70, 100
    FakeUITouch *touch5 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(70, 100)];
    NSSet *touchSet5 = [[NSSet alloc] initWithObjects:touch5, nil];
    [mainViewController touchesMoved:touchSet5 withEvent:nil];
    
    // touch ended
    FakeUITouch *touch6 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(70, 100)];
    NSSet *touchSet6 = [[NSSet alloc] initWithObjects:touch6, nil];
    [mainViewController touchesEnded:touchSet6 withEvent:nil];
    
    STAssertEquals(mainViewController.yellowView.layer.zPosition, 1.f, @"yellowView zPosition is not 1");
    STAssertEquals(mainViewController.greenView.layer.zPosition, 2.f, @"greenView zPosition is not 2");
    STAssertEquals(mainViewController.yellowView.frame.origin.x, 0.f, @"yellowView has to back 0, 0");
    STAssertEquals(mainViewController.greenView.frame.origin.x, 0.f, @"greenView has to move 0, 0");
}

- (void)testMoveLeftAndRightSlowly
{
    // first touch at 100, 100
    FakeUITouch *touch1 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(100, 100)];
    NSSet *touchSet1 = [[NSSet alloc] initWithObjects:touch1, nil];
    [mainViewController touchesBegan:touchSet1 withEvent:nil];
    
    // touch moves from 100 to 100 + 160 by 10
    for(int x = 100; x < 100 + 160; x += 10) {
        FakeUITouch *touch2 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(x, 100)];
        NSSet *touchSet2 = [[NSSet alloc] initWithObjects:touch2, nil];
        [mainViewController touchesMoved:touchSet2 withEvent:nil];
        
        STAssertEquals(mainViewController.yellowView.layer.zPosition, 1.f, @"yellowView zPosition is not 1");
        STAssertEquals(mainViewController.greenView.layer.zPosition, 2.f, @"greenView zPosition is not 2");
        STAssertEquals(mainViewController.yellowView.frame.origin.x, (float)-x + 100, @"yellowView has to move properly");
        STAssertEquals(mainViewController.greenView.frame.origin.x, (float)x - 100, @"greenView has to move properly");
    }
    
    // touch moves from 100 + 160 to 100 + 200 by 10
    for(int x = 100 + 160; x < 100 + 200; x += 10) {
        FakeUITouch *touch2 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(x, 100)];
        NSSet *touchSet2 = [[NSSet alloc] initWithObjects:touch2, nil];
        [mainViewController touchesMoved:touchSet2 withEvent:nil];
        
        STAssertEquals(mainViewController.yellowView.layer.zPosition, 2.f, @"yellowView zPosition is not 2");
        STAssertEquals(mainViewController.greenView.layer.zPosition, 1.f, @"greenView zPosition is not 1");
        STAssertEquals(mainViewController.yellowView.frame.origin.x, (float)x - 100 - 160 - 160, @"yellowView has to move properly");
        STAssertEquals(mainViewController.greenView.frame.origin.x, (float)-x + 100 + 160 + 160, @"greenView has to move properly");
    }
    // touch ended at 100 + 200
    FakeUITouch *touch3 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(100 + 200, 100)];
    NSSet *touchSet3 = [[NSSet alloc] initWithObjects:touch3, nil];
    [mainViewController touchesEnded:touchSet3 withEvent:nil];
    
    STAssertEquals(mainViewController.yellowView.layer.zPosition, 2.f, @"yellowView zPosition is not 2");
    STAssertEquals(mainViewController.greenView.layer.zPosition, 1.f, @"greenView zPosition is not 1");
    STAssertEquals(mainViewController.yellowView.frame.origin.x, 0.f, @"yellowView has to back 0, 0");
    STAssertEquals(mainViewController.greenView.frame.origin.x, 0.f, @"greenView has to move 0, 0");
    
    // first touch at 100 + 200, 100
    FakeUITouch *touch4 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(100 + 200, 100)];
    NSSet *touchSet4 = [[NSSet alloc] initWithObjects:touch4, nil];
    [mainViewController touchesBegan:touchSet4 withEvent:nil];
    
    // touch moves from 100 + 200 to 100 + 200 - 160 by 10
    for(int x = 100 + 200; x > 100 + 200 - 160; x -= 10) {
        FakeUITouch *touch2 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(x, 100)];
        NSSet *touchSet2 = [[NSSet alloc] initWithObjects:touch2, nil];
        [mainViewController touchesMoved:touchSet2 withEvent:nil];
        
        STAssertEquals(mainViewController.yellowView.layer.zPosition, 2.f, @"yellowView zPosition is not 2");
        STAssertEquals(mainViewController.greenView.layer.zPosition, 1.f, @"greenView zPosition is not 1");
        STAssertEquals(mainViewController.yellowView.frame.origin.x, (float)x - 100 - 200, @"yellowView has to move properly");
        STAssertEquals(mainViewController.greenView.frame.origin.x, (float)-x + 100 + 200, @"greenView has to move properly");
    }
    
    // touch moves from 100 + 200 - 160 to 100 by 10
    for(int x = 100 + 200 - 160; x > 100; x -= 10) {
        FakeUITouch *touch2 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(x, 100)];
        NSSet *touchSet2 = [[NSSet alloc] initWithObjects:touch2, nil];
        [mainViewController touchesMoved:touchSet2 withEvent:nil];
        
        STAssertEquals(mainViewController.yellowView.layer.zPosition, 1.f, @"yellowView zPosition is not 1");
        STAssertEquals(mainViewController.greenView.layer.zPosition, 2.f, @"greenView zPosition is not 2");
        STAssertEquals(mainViewController.yellowView.frame.origin.x, (float)-x - 20, @"yellowView has to move properly");
        STAssertEquals(mainViewController.greenView.frame.origin.x, (float)x + 20, @"greenView has to move properly");
    }
    // touch ended at 100
    FakeUITouch *touch6 = [[FakeUITouch alloc] initWithLocationInView:CGPointMake(100, 100)];
    NSSet *touchSet6 = [[NSSet alloc] initWithObjects:touch6, nil];
    [mainViewController touchesEnded:touchSet6 withEvent:nil];
    
    STAssertEquals(mainViewController.yellowView.layer.zPosition, 1.f, @"yellowView zPosition is not 1");
    STAssertEquals(mainViewController.greenView.layer.zPosition, 2.f, @"greenView zPosition is not 2");
    STAssertEquals(mainViewController.yellowView.frame.origin.x, 0.f, @"yellowView has to back 0, 0");
    STAssertEquals(mainViewController.greenView.frame.origin.x, 0.f, @"greenView has to move 0, 0");
}
@end
