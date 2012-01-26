//
//  DropShadowLayerStyle.h
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/24/12.
//  Copyright (c) 2012 Rubber Duck Software. All rights reserved.
//

#import "JMViewLayerStyle.h"

@interface DropShadowLayerStyle : JMViewLayerStyle

+ (DropShadowLayerStyle *) dropShadowStyleWithColor:(UIColor *)c distance:(CGFloat)d size:(CGFloat)s;

@property (nonatomic, retain) UIColor *color;
@property (nonatomic) CGFloat distance;
@property (nonatomic) CGFloat size;

@end
