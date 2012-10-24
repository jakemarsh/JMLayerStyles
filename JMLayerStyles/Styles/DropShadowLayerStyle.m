//
//  DropShadowLayerStyle.m
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/24/12.
//  Copyright (c) 2012 Jake Marsh. All rights reserved.
//

#import "DropShadowLayerStyle.h"
#import <QuartzCore/QuartzCore.h>

@implementation DropShadowLayerStyle

@synthesize color = _color;
@synthesize distance = _distance;
@synthesize size = _size;

+ (DropShadowLayerStyle *) dropShadowStyleWithColor:(UIColor *)c distance:(CGFloat)d size:(CGFloat)s {
    DropShadowLayerStyle *style = [[DropShadowLayerStyle alloc] init];

    style.color = c;
    style.distance = d;
    style.size = s;

    return [style autorelease];
}

- (void) _apply:(UIView *)targetView {
    if([targetView class] == [UILabel class]) {
        UILabel *label = (UILabel *)targetView;
        label.shadowColor = self.color;
        label.shadowOffset = CGSizeMake(0.0, self.distance);
    } else {
        if(self.size != 0.0) {
            targetView.layer.masksToBounds = NO;
            targetView.layer.cornerRadius = 10.0;
            targetView.layer.shadowColor = self.color.CGColor;
            targetView.layer.shadowOffset = CGSizeMake(0.0, self.distance);
            targetView.layer.shadowRadius = self.size;
            targetView.layer.shadowOpacity = 1.0;
            
            [targetView setNeedsDisplay];
        }        
    }
}

- (void) dealloc {
    [_color release];

    [super dealloc];
}

@end