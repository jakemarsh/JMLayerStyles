//
//  InnerShadowLayerStyle.h
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/24/12.
//  Copyright (c) 2012 Jake Marsh. All rights reserved.
//

#import "JMViewLayerStyle.h"

@interface InnerShadowLayerStyle : JMViewLayerStyle

+ (InnerShadowLayerStyle *) innerShadowStyleWithColor:(UIColor *)co opacity:(CGFloat)o distance:(CGFloat)d choke:(CGFloat)c size:(CGFloat)s;

@property (nonatomic, retain) UIColor *color;
@property (nonatomic) CGFloat opacity; //0.0 - 1.0
@property (nonatomic) CGFloat choke;
@property (nonatomic) CGFloat distance;
@property (nonatomic) CGFloat size;

@end