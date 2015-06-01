//
//  FLEXBOXNode.m
//  FlexboxKit
//
//  Created by Alex Usbergo on 09/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

#import "FLEXBOXNode.h"

const CGFloat FLEXBOXUndefinedDimension = CSS_UNDEFINED;

static bool FLEXBOX_alwaysDirty(void *context)
{
    return YES;
}

static css_node_t *FLEXBOX_getChild(void *context, int i)
{
    FLEXBOXNode *_self = (__bridge FLEXBOXNode*)context;
    FLEXBOXNode *child = _self.childrenAtIndexBlock(i);
    return child.node;
}

static css_dim_t FLEXBOX_measureNode(void *context, float width)
{
    FLEXBOXNode *_self = (__bridge FLEXBOXNode*)context;
    CGSize size = _self.measureBlock(width);
    return (css_dim_t){ size.width, size.height };
}

@implementation FLEXBOXNode

#pragma mark - Lifecycle

- (instancetype)init
{
    if (self = [super init]) {
        
        //initialise the css_node_t
        _node = new_css_node();
        _node->context = (__bridge void *)self;
        _node->is_dirty = FLEXBOX_alwaysDirty;
        _node->measure = FLEXBOX_measureNode;
        _node->get_child = FLEXBOX_getChild;
        
        _maxDimensions = CGSizeZero;
        _minDimensions = CGSizeZero;
        
        //defaults
        self.flexDirection = FLEXBOXFlexDirectionColumn;
        self.flexWrap = NO;
        self.alignItems = FLEXBOXAlignmentStretch;
        self.alignSelf = FLEXBOXAlignmentAuto;
        self.margin = UIEdgeInsetsZero;
        self.padding = UIEdgeInsetsZero;
        self.justifyContent = FLEXBOXJustificationFlexStart;
        self.flex = 0;
        self.contentDirection = FLEXBOXContentDirectionInherit;
    }
    
    return self;
}

- (void)dealloc
{
    free_css_node(_node);
}

#pragma mark - Layout and Internals

- (void)prepareForLayout
{
    if (self.childrenAtIndexBlock == nil)
        return;
    
    NSAssert(self.childrenCountBlock, nil);
    NSUInteger count = self.childrenCountBlock();
    
    // prepares the nodes for the layout recursively
    for (NSInteger i = 0; i < count; i++) {
        FLEXBOXNode *node = self.childrenAtIndexBlock(i);
        [node prepareForLayout];
    }
    
    // Apparently we need to reset these before laying out, otherwise the layout
    // has some weird additive effect.
    self.node->layout.position[CSS_LEFT] = 0;
    self.node->layout.position[CSS_TOP] = 0;
    self.node->layout.dimensions[CSS_WIDTH] = CSS_UNDEFINED;
    self.node->layout.dimensions[CSS_HEIGHT] = CSS_UNDEFINED;
}

- (void)layoutConstrainedToMaximumWidth:(CGFloat)maximumWidth
{
    _node->children_count = (int)self.childrenCountBlock();
    
    maximumWidth = fabs(maximumWidth - FLT_MAX) < FLT_EPSILON ? FLEXBOXUndefinedDimension : maximumWidth;
    [self prepareForLayout];
    layoutNode(_node, maximumWidth, _node->style.direction);
}

- (CGRect)frame
{
    return (CGRect) {
        .origin.x = self.node->layout.position[CSS_LEFT],
        .origin.y = self.node->layout.position[CSS_TOP],
        .size.width = self.node->layout.dimensions[CSS_WIDTH],
        .size.height = self.node->layout.dimensions[CSS_HEIGHT]
    };
}

#pragma mark - Style

- (void)setDimensions:(CGSize)size
{
    _dimensions = size;
    _node->style.dimensions[CSS_WIDTH] = size.width;
    _node->style.dimensions[CSS_HEIGHT] = size.height;
}

- (void)setMinDimensions:(CGSize)size
{
    _minDimensions = size;
//    _node->style.minDimensions[CSS_WIDTH] = size.width;
//    _node->style.minDimensions[CSS_HEIGHT] = size.height;
}

- (void)setMaxDimensions:(CGSize)size
{
    _maxDimensions = size;
//    _node->style.maxDimensions[CSS_WIDTH] = size.width;
//    _node->style.maxDimensions[CSS_HEIGHT] = size.height;
}

- (void)setFlexDirection:(FLEXBOXFlexDirection)flexDirection
{
    _flexDirection = flexDirection;
    _node->style.flex_direction = (int)flexDirection;
}

- (void)setMargin:(UIEdgeInsets)margin
{
    _margin = margin;
    _node->style.margin[CSS_LEFT] = margin.left;
    _node->style.margin[CSS_TOP] = margin.top;
    _node->style.margin[CSS_RIGHT] = margin.right;
    _node->style.margin[CSS_BOTTOM] = margin.bottom;
}

- (void)setPadding:(UIEdgeInsets)padding
{
    _padding = padding;
    _node->style.padding[CSS_LEFT] = padding.left;
    _node->style.padding[CSS_TOP] = padding.top;
    _node->style.padding[CSS_RIGHT] = padding.right;
    _node->style.padding[CSS_BOTTOM] = padding.bottom;
}

- (void)setFlex:(CGFloat)flex
{
    _flex = flex;
    _node->style.flex = flex;
}

- (void)setFlexWrap:(BOOL)flexWrap
{
    _flexWrap = flexWrap;
    _node->style.flex_wrap = flexWrap;
}

- (void)setJustifyContent:(FLEXBOXJustification)justifyContent
{
    _justifyContent = justifyContent;
    _node->style.justify_content = (int)justifyContent;
}

- (void)setAlignItems:(FLEXBOXAlignment)alignItems
{
    _alignItems = alignItems;
    _node->style.align_items = (int)alignItems;
}

- (void)setAlignSelf:(FLEXBOXAlignment)alignSelf
{
    _alignSelf = alignSelf;
    _node->style.align_self = (int)alignSelf;
}

- (void)setContentDirection:(FLEXBOXContentDirection)contentDirection
{
    _contentDirection = contentDirection;
    _node->style.direction = (int)contentDirection;
}

@end

