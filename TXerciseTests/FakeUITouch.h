//
//  FakeUITouch.h
//  TXercise
//
//  Created by porori on 13. 1. 19..
//  Copyright (c) 2013년 porori. All rights reserved.
//

#import <UIKit/UIKit.h>

// FakeUITouch just response to locationInView for test
@interface FakeUITouch : NSObject
{
    CGPoint point;
}

- (id)initWithLocationInView:(CGPoint)locationInView;
- (CGPoint)locationInView:(UIView *)view;

@end
