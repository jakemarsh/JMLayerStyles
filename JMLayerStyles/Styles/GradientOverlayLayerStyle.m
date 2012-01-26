//
//  GradientOverlayLayerStyle.m
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/25/12.
//  Copyright (c) 2012 Rubber Duck Software. All rights reserved.
//

#import "GradientOverlayLayerStyle.h"

@implementation GradientOverlayLayerStyle

@synthesize colors = _colors;
@synthesize locations = _locations;
@synthesize gradientStyle = _gradientStyle;

+ (GradientOverlayLayerStyle *) gradientStyleWithColors:(NSArray *)c locations:(NSArray *)l style:(GradientOverlayStyle)s {
    GradientOverlayLayerStyle *style = [[GradientOverlayLayerStyle alloc] init];

    style.colors = c;
    style.locations = l;
    style.gradientStyle = s;

    return [style autorelease];
}
+ (GradientOverlayLayerStyle *) gradientStyleWithColors:(NSArray *)c style:(GradientOverlayStyle)s {
    GradientOverlayLayerStyle *style = [[GradientOverlayLayerStyle alloc] init];

    style.colors = c;
    style.gradientStyle = s;

    CGFloat top = (1.0f - 1.0) / 2.0f;
    CGFloat bottom = top + 1.0;

    style.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:top], [NSNumber numberWithFloat:bottom], nil];

    return [style autorelease];    
}

- (void) dealloc {
    [_colors release];
    [_locations release];

    [super dealloc];
}

@end