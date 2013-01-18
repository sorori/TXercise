//
//  FakeUITouch.m
//  TXercise
//
//  Created by porori on 13. 1. 19..
//  Copyright (c) 2013년 porori. All rights reserved.
//

#import "FakeUITouch.h"

@implementation FakeUITouch

- (id)initWithLocationInView:(CGPoint)locationInView
{
    self = [super init];
    if(self) {
        point = locationInView;
    }
    return self;
}

- (CGPoint)locationInView:(UIView *)view
{
    return point;
}
@end
