//
//  StrokeLayerStyle.m
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/25/12.
//  Copyright (c) 2012 Rubber Duck Software. All rights reserved.
//

#import "StrokeLayerStyle.h"

@implementation StrokeLayerStyle

@synthesize color = _color;
@synthesize opacity = _opacity;
@synthesize size = _size;

+ (StrokeLayerStyle *) strokeStyleWithColor:(UIColor *)co opacity:(CGFloat)o size:(CGFloat)s {
    StrokeLayerStyle *style = [[StrokeLayerStyle alloc] init];
    
    style.color = co;
    style.opacity = o;
    style.size = s;

    return [style autorelease];
}

- (void) dealloc {
    [_color release];

    [super dealloc];
}

@end
