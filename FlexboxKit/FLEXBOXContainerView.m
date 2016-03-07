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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.flexContainer = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.flexContainer = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.flexContainer = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    //default flexbox container attributes
    self.flex = self.flex < FLT_EPSILON ? 1 : self.flex;
    
    [super layoutSubviews];
    [self flexLayoutSubviews];
}

@end
