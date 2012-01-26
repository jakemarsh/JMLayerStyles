//
//  InnerShadowLayerStyle.m
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/24/12.
//  Copyright (c) 2012 Rubber Duck Software. All rights reserved.
//

#import "InnerShadowLayerStyle.h"

@implementation InnerShadowLayerStyle

@synthesize color = _color;
@synthesize opacity = _opacity;
@synthesize choke = _choke;
@synthesize distance = _distance;
@synthesize size = _size;

+ (InnerShadowLayerStyle *) innerShadowStyleWithColor:(UIColor *)co opacity:(CGFloat)o distance:(CGFloat)d choke:(CGFloat)c size:(CGFloat)s {
    InnerShadowLayerStyle *style = [[InnerShadowLayerStyle alloc] init];

    style.color = co;
    style.opacity = o;
    style.choke = c;
    style.distance = d;
    style.size = s;

    return [style autorelease];
}

- (void) _apply:(UIView *)targetView {
    
}

- (void) dealloc {
    [_color release];
    
    [super dealloc];
}

@end