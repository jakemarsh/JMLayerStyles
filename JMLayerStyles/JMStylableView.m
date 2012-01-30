//
//  JMStylableView.m
//  FacebookAlertView
//
//  Created by Jake Marsh on 1/24/12.
//  Copyright (c) 2012 Rubber Duck Software. All rights reserved.
//

#import "JMStylableView.h"
#import "JMViewLayerStyle.h"
#import "JMLayerStyles.h"

CGGradientRef JMCreateGradientWithColorsAndLocations(NSArray *colors, NSArray *locations) {
	NSUInteger colorsCount = [colors count];
	if (colorsCount < 2) {
		return nil;
	}
    
	CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors objectAtIndex:0] CGColor]);
    
	CGFloat *gradientLocations = NULL;
	NSUInteger locationsCount = [locations count];
	if (locationsCount == colorsCount) {
		gradientLocations = (CGFloat *)malloc(sizeof(CGFloat) * locationsCount);
		for (NSUInteger i = 0; i < locationsCount; i++) {
			gradientLocations[i] = [[locations objectAtIndex:i] floatValue];
		}
	}
    
	NSMutableArray *gradientColors = [[NSMutableArray alloc] initWithCapacity:colorsCount];
	[colors enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		[gradientColors addObject:(id)[(UIColor *)object CGColor]];
	}];
    
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, gradientLocations);
    
	[gradientColors release];
	if (gradientLocations) {
		free(gradientLocations);
	}
    
	return gradient;
}

@implementation JMStylableView

@synthesize styles = _styles;
@synthesize cornerRadius = _cornerRadius;
@synthesize bezierPath = _bezierPath;

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.backgroundColor = [UIColor clearColor];

    self.styles = [NSArray array];
    self.bezierPath = nil;
    self.cornerRadius = 0.0;

    return self;
}
- (void) dealloc {
    [_styles release];
    [_bezierPath release];

    [super dealloc];
}

- (void) addLayerStyle:(JMViewLayerStyle *)s {
    if([s respondsToSelector:@selector(_apply:)]) {
        [s performSelector:@selector(_apply:) withObject:self];
    }

    self.styles = [self.styles arrayByAddingObject:s];
}
- (void) clearLayerStyles {
    self.styles = [NSArray array];
}

- (JMViewLayerStyle *) layerStyleOfClass:(Class)c {
    for(JMViewLayerStyle *s in self.styles) {
        if([s class] == c) {
            return s;
        }
    }

    return nil;
}

- (void) drawRect:(CGRect)rect {
    DropShadowLayerStyle *dropShadowStyle = (DropShadowLayerStyle *)[self layerStyleOfClass:[DropShadowLayerStyle class]];
    GradientOverlayLayerStyle *gradientOverlayStyle = (GradientOverlayLayerStyle *)[self layerStyleOfClass:[GradientOverlayLayerStyle class]];
    InnerShadowLayerStyle *innerShadowStyle = (InnerShadowLayerStyle *)[self layerStyleOfClass:[InnerShadowLayerStyle class]];
    StrokeLayerStyle *strokeStyle = (StrokeLayerStyle *)[self layerStyleOfClass:[StrokeLayerStyle class]];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect drawRect = rect;
    CGFloat radius = self.cornerRadius;

    //contract the bounds of the rectangle in to account for the stroke
    if(strokeStyle) drawRect = CGRectInset(rect, 1.0f, 1.0f);

	//contract the height by 1 to account for the white bevel at the bottom
    if(dropShadowStyle && dropShadowStyle.size == 0.0) drawRect.size.height -= 1.0f;

    //Save the current state so we don't persist anything beyond this operation
	CGContextSaveGState(context);

    //Generate the rounded rectangle paths
    CGPathRef boxPath = self.bezierPath ? self.bezierPath.CGPath : [[UIBezierPath bezierPathWithRoundedRect:drawRect cornerRadius:radius] CGPath];

    //For the stroke, offset by half a pixel to ensure proper drawing
    CGPathRef strokePath = self.bezierPath ? self.bezierPath.CGPath : [[UIBezierPath bezierPathWithRoundedRect: CGRectInset(drawRect, -0.5f, -0.5f) cornerRadius: radius] CGPath];

    if(dropShadowStyle && dropShadowStyle.size == 0.0) {
        /*Draw the bevel effect*/
        CGContextSaveGState(context);

        //Set the color
        CGContextSetFillColorWithColor(context, [dropShadowStyle.color CGColor]);

        //Clip the region to only the visible portion to optimize drawing
        CGContextClipToRect(context, CGRectMake(rect.origin.x, rect.origin.y+rect.size.height-radius, rect.size.width, radius));

        //draw the left corner curve
        CGRect corner = CGRectMake(rect.origin.x, (rect.origin.y+rect.size.height)-(2*radius)-1, (radius*2)+1, (radius*2)+1);
        CGContextFillEllipseInRect(context, corner);

        //draw the right corner
        corner.origin.x = rect.origin.x + rect.size.width - (radius*2)-1;
        CGContextFillEllipseInRect(context, corner);

        //draw the rectangle in the middle
        //set the blend mode to replace any existing pixels (or else we'll see visible overlap)
        CGContextSetBlendMode(context, kCGBlendModeCopy);
        CGContextFillRect(context, CGRectMake(rect.origin.x+radius, rect.origin.y+rect.size.height-radius, rect.size.width-(2*radius),radius+1));
        CGContextRestoreGState(context);
    }
    
    if(gradientOverlayStyle) {
        /*Draw the main region */
        CGContextSaveGState(context);
        
        //use the stroke path so the boundaries line up with the stroke (else we'll see a gap on retina devices)
        CGContextAddPath(context, strokePath);
        
        //fill it with our gradient of choice
        CGPoint start = CGPointMake(0.0f, 0.0f);
        CGPoint end = (CGPointMake(0.0f, rect.size.height));
        
        CGContextClip(context);
        CGGradientRef gradient = JMCreateGradientWithColorsAndLocations(gradientOverlayStyle.colors, gradientOverlayStyle.locations);
        CGContextDrawLinearGradient(context, gradient, start, end, 0);
        CGGradientRelease(gradient), gradient = NULL;
        
        CGContextRestoreGState(context);
    }
    
    if(innerShadowStyle) {
        /*Main fill region inner drop shadow*/

        /*(This is done by duplicating the path, offsetting the duplicate by 1 pixel, and using the EO winding fill rule to fill the gap between the two)*/
        CGContextSaveGState(context);

        //set the colour to be a VERY faint grey
        CGContextSetFillColorWithColor(context, [innerShadowStyle.color CGColor]);

        //clip the shadow to the top of the box (to reduce overhead)
        CGContextClipToRect(context, CGRectMake(drawRect.origin.x, drawRect.origin.y, drawRect.size.width, radius));

        //add the first instance of the path
        CGContextAddPath(context, boxPath);

        //translate the draw origin down by 1 pixel
        CGContextTranslateCTM(context, 0.0f, innerShadowStyle.distance);

        //add the second instance of the path
        CGContextAddPath(context, boxPath);

        //use the EO winding rule to fill the gap between the two paths
        CGContextEOFillPath(context);

        CGContextRestoreGState(context);
    }
    
    if(strokeStyle) {
        /*Outer Stroke*/
        /*This is drawn outside of the fill region to prevent the fill region bleeding over in some cases*/
        CGContextSaveGState(context);
        
        //set the line width
        CGContextSetLineWidth(context, strokeStyle.size);
        
        //set the the colour to be a very transparent shade of grey
        CGContextSetStrokeColorWithColor(context, [strokeStyle.color CGColor]);
        
        //set up the path to draw the stroke along
        CGContextAddPath(context, strokePath);
        
        //set the blending mode to replace underlying pixels on this layer (so the background will come through through)
        CGContextSetBlendMode(context, kCGBlendModeCopy);
        
        //draw the path
        CGContextStrokePath(context);
        
        //Restore the previous CG state
        CGContextRestoreGState( context );
    }

    //Restore the previous CG state
    CGContextRestoreGState( context );
}

@end