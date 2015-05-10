//
//  FLEXBOXNode.h
//  FlexboxKit
//
//  Created by Alex Usbergo on 09/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

#import "Layout.h"
@import UIKit;

typedef NS_ENUM(NSInteger, FLEXBOXDirection) {
    FLEXBOXDirectionColumn = CSS_FLEX_DIRECTION_COLUMN,
    FLEXBOXDirectionRow = CSS_FLEX_DIRECTION_ROW
};

typedef NS_ENUM(NSInteger, FLEXBOXJustification) {
    FLEXBOXJustificationFlexStart = CSS_JUSTIFY_FLEX_START,
    FLEXBOXJustificationCenter = CSS_JUSTIFY_CENTER,
    FLEXBOXJustificationFlexEnd = CSS_JUSTIFY_FLEX_END,
    FLEXBOXJustificationSpaceBetween = CSS_JUSTIFY_SPACE_BETWEEN,
    FLEXBOXJustificationSpaceAround = CSS_JUSTIFY_SPACE_AROUND
};

typedef NS_ENUM(NSInteger, FLEXBOXAlignment) {
    FLEXBOXAlignmentAuto = CSS_ALIGN_AUTO,
    FLEXBOXAlignmentFlexStart = CSS_ALIGN_FLEX_START,
    FLEXBOXAlignmentCenter = CSS_ALIGN_CENTER,
    FLEXBOXAlignmentFlexEnd = CSS_ALIGN_FLEX_END,
    FLEXBOXAlignmentStretch = CSS_ALIGN_STRETCH
};


extern const CGFloat FLEXBOXUndefinedMaximumWidth;

@interface FLEXBOXNode : NSObject

@property (nonatomic, readonly, assign) css_node_t *node;
@property (nonatomic, readonly, assign) CGRect frame;

@property (nonatomic, copy) CGSize (^measureBlock)(CGFloat width);
@property (nonatomic, copy) FLEXBOXNode *(^childrenAtIndexBlock)(NSUInteger i);
@property (nonatomic, copy) NSUInteger (^childrenCountBlock)(void);


/// Compute the layout for the node constrained to the width passed as argument
/// @param maximumWidth The maximum width or FLEXBOXUndefinedMaximumWidth
- (void)layoutConstrainedToMaximumWidth:(CGFloat)maximumWidth;

// Style

@property (nonatomic, assign) CGSize dimensions;
@property (nonatomic, assign) FLEXBOXDirection flexDirection;
@property (nonatomic, assign) UIEdgeInsets margin;
@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, assign) BOOL flexWrap;
@property (nonatomic, assign) FLEXBOXJustification justifyContent;
@property (nonatomic, assign) FLEXBOXAlignment alignSelf;
@property (nonatomic, assign) FLEXBOXAlignment alignItems;
@property (nonatomic, assign) CGFloat flex;

@end

