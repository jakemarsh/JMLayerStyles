//
//  JMStylableView.h
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/24/12.
//  Copyright (c) 2012 Jake Marsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMViewLayerStyle;

extern CGGradientRef JMCreateGradientWithColorsAndLocations(NSArray *colors, NSArray *locations);

@interface JMStylableView : UIView

@property (nonatomic, retain) NSArray *styles;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic,  retain) UIBezierPath *bezierPath; //Default is nil

- (void) addLayerStyle:(JMViewLayerStyle *)s;
- (void) clearLayerStyles;

- (JMViewLayerStyle *) layerStyleOfClass:(Class)c;

@end