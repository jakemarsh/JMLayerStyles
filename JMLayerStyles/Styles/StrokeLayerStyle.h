//
//  StrokeLayerStyle.h
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/25/12.
//  Copyright (c) 2012 Rubber Duck Software. All rights reserved.
//

#import "JMViewLayerStyle.h"

@interface StrokeLayerStyle : JMViewLayerStyle

@property (nonatomic, retain) UIColor *color;
@property (nonatomic) CGFloat opacity; //0.0 - 1.0
@property (nonatomic) CGFloat size;

+ (StrokeLayerStyle *) strokeStyleWithColor:(UIColor *)co opacity:(CGFloat)o size:(CGFloat)s;

@end