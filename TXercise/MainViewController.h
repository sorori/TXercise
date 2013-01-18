//
//  MainViewController.h
//  TXercise
//
//  Created by porori on 13. 1. 18..
//  Copyright (c) 2013년 porori. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MainViewController : UIViewController
{
    BOOL isGreenUp;
    CGPoint startPoint;
    CGPoint currentPoint;
    float lastDiff;
    CGPoint yellowViewOriginPoint;
    CGPoint greenViewOriginPoint;
}
@property (weak, nonatomic) IBOutlet UIImageView *yellowView;
@property (weak, nonatomic) IBOutlet UIImageView *greenView;

@end
