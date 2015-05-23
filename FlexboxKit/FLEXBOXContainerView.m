//
//  FLEXBOXContainerView.m
//  FlexboxKit
//
//  Created by Alex Usbergo on 10/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

#import "FLEXBOXContainerView.h"
#import "UIView+FLEXBOX.h"

@implementation FLEXBOXContainerView

- (void)layoutSubviews
{
    //default flexbox container attributes
    self.flex = self.flex < FLT_EPSILON ? 1 : self.flex;
    self.flexContainer = YES;
    
    [super layoutSubviews];
    [self flexLayoutSubviews];
}

@end
