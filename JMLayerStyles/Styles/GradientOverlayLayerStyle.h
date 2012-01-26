//
//  GradientOverlayLayerStyle.h
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/25/12.
//  Copyright (c) 2012 Rubber Duck Software. All rights reserved.
//

#import "JMViewLayerStyle.h"

typedef enum {
    GradientOverlayStyleLinear = 0,
    GradientOverlayLayerStyleRadial = 1
} GradientOverlayStyle;

@interface GradientOverlayLayerStyle : JMViewLayerStyle

@property (nonatomic, retain) NSArray *colors;
@property (nonatomic, retain) NSArray *locations; //Default is top to bottom
@property (nonatomic) GradientOverlayStyle gradientStyle; //Default is GradientOverlayStyleLinear

+ (GradientOverlayLayerStyle *) gradientStyleWithColors:(NSArray *)c locations:(NSArray *)l style:(GradientOverlayStyle)s;
+ (GradientOverlayLayerStyle *) gradientStyleWithColors:(NSArray *)c style:(GradientOverlayStyle)s;

@end