## JMLayerStyles

`JMLayerStyles` is a set of tools built around a small little UIView subclass that supports being styled by invoking methods whose parameters are quite similar to those found on Photoshop's "Layer Styles" panel.

The end result looks like this:

``` objc

JMStylableView *styledView = [[JMStylableView alloc] initWithFrame:CGRectMake(10.0, 30.0, self.window.bounds.size.width - 20.0, self.window.bounds.size.height - 40.0)];

[styledView addLayerStyle:[DropShadowLayerStyle dropShadowStyleWithColor:[UIColor colorWithWhite:0.0 alpha:0.56]
                                                          distance:4.0
                                                              size:4.5]];

[styledView addLayerStyle:[InnerShadowLayerStyle innerShadowStyleWithColor:[UIColor colorWithRed:71.0/255.0 green:159.0/255.0 blue:243.0/255.0 alpha:1.0]
                                                             opacity:1.0
                                                            distance:1.0
                                                               choke:0.0
                                                                size:0.0]];

[styledView addLayerStyle:[StrokeLayerStyle strokeStyleWithColor:[UIColor colorWithRed:3.0/255.0 green:25.0/255.0 blue:47.0/255.0 alpha:1.0]
                                                   opacity:1.0
                                                      size:1.0]];

NSArray *colors = [NSArray arrayWithObjects:[UIColor colorWithRed:19.0/255.0 green:148.0/255.0 blue:213.0/255.0 alpha:1.0], [UIColor colorWithRed:10.0/255.0 green:71.0/255.0 blue:131.0/255.0 alpha:1.0], nil];
[styledView addLayerStyle:[GradientOverlayLayerStyle gradientStyleWithColors:colors style:GradientOverlayStyleLinear]];

styledView.cornerRadius = 10.0;

[self.window addSubview:styledView];

[styledView release];

```