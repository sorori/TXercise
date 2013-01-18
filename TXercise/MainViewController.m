//
//  MainViewController.m
//  TXercise
//
//  Created by porori on 13. 1. 18..
//  Copyright (c) 2013년 porori. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize yellowView, greenView;

#define SWIPE_DRAG_MIN 16

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    yellowViewOriginPoint = yellowView.frame.origin;
    greenViewOriginPoint = greenView.frame.origin;
    
    yellowView.layer.zPosition = 1;
    greenView.layer.zPosition = 2;
    
    isGreenUp = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    startPoint = [[touches anyObject] locationInView:self.view];
    currentPoint = startPoint;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint cppoint = [[touches anyObject] locationInView:self.view];
    lastDiff = cppoint.x - currentPoint.x;
    float movedDiff = cppoint.x - startPoint.x;
    
    currentPoint = cppoint;
    
    float absoluteDiff = isGreenUp ? movedDiff : -movedDiff;
    float diffX;
    
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    if(absoluteDiff > 0 && absoluteDiff < screenWidth / 2) {
        diffX = absoluteDiff;
        yellowView.layer.zPosition = isGreenUp ? 1 : 2;
        greenView.layer.zPosition = isGreenUp ? 2 : 1;
    } else if(absoluteDiff >= screenWidth / 2 && absoluteDiff < screenWidth) {
        diffX = screenWidth - absoluteDiff;
        yellowView.layer.zPosition = isGreenUp ? 2 : 1;
        greenView.layer.zPosition = isGreenUp ? 1 : 2;
    }
    
    CGRect yellowViewFrame = yellowView.frame;
    yellowViewFrame.origin.x = yellowViewOriginPoint.x - diffX;
    yellowView.frame = yellowViewFrame;
    
    CGRect greenViewFrame = greenView.frame;
    greenViewFrame.origin.x = greenViewOriginPoint.x + diffX;
    greenView.frame = greenViewFrame;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint cppoint = [[touches anyObject] locationInView:self.view];
    float endedDiff = cppoint.x - startPoint.x;
    
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    // check for swipe move
    if(lastDiff > SWIPE_DRAG_MIN) {
        if(isGreenUp)
            isGreenUp = !isGreenUp;
    }
    else if(-lastDiff > SWIPE_DRAG_MIN) {
        if(!isGreenUp)
            isGreenUp = !isGreenUp;
    }
    else {
        float absoluteDiff = isGreenUp ? endedDiff : -endedDiff;
        if(absoluteDiff > screenWidth / 2) {
            isGreenUp = !isGreenUp;
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect yellowViewFrame = yellowView.frame;
        yellowViewFrame.origin = yellowViewOriginPoint;
        yellowView.frame = yellowViewFrame;
        
        CGRect greenViewFrame = greenView.frame;
        greenViewFrame.origin = greenViewOriginPoint;
        greenView.frame = greenViewFrame;
        
        yellowView.layer.zPosition = isGreenUp ? 1 : 2;
        greenView.layer.zPosition = isGreenUp ? 2 : 1;
    }];
}
@end
