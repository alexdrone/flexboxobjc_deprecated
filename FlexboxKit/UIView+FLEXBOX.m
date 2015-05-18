//
//  UIView+FLEXBOX.m
//  FlexboxKit
//
//  Created by Alex Usbergo on 09/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

#import "UIView+FLEXBOX.h"
#import <objc/runtime.h>

const void *FLEXBOXNodeKey;
const void *FLEXBOXSizeKey;
const void *FLEXBOXSizeThatFitsBlock;

@implementation UIView (FLEXBOX)

- (FLEXBOXNode*)flexNode
{
    FLEXBOXNode *node = objc_getAssociatedObject(self, &FLEXBOXNodeKey);
    
    if (node == nil) {
        node = [[FLEXBOXNode alloc] init];
        self.flexNode = node;
        
        __weak __typeof(self) weakSelf = self;
        
        self.flexNode.childrenAtIndexBlock = ^FLEXBOXNode*(NSUInteger i) {
            return [weakSelf.subviews[i] flexNode];
        };
        
        self.flexNode.childrenCountBlock = ^NSUInteger(void) {
            return weakSelf.subviews.count;
        };
        
        self.flexNode.measureBlock = ^CGSize(CGFloat width) {
            return [weakSelf flexComputeSize:(CGSize){width, NAN}];
        };
    }
    
    return node;
}

- (void)setFlexNode:(FLEXBOXNode*)flexNode
{
    objc_setAssociatedObject(self, &FLEXBOXNodeKey, flexNode, OBJC_ASSOCIATION_RETAIN);
}

- (CGSize)flexFixedSize
{
    NSValue *value = objc_getAssociatedObject(self, &FLEXBOXSizeKey);
    if (value != nil) {
        return [value CGSizeValue];
    } else {
        return CGSizeZero;
    }
}

- (void)setFlexFixedSize:(CGSize)flexFixedSize
{
    return objc_setAssociatedObject(self, &FLEXBOXSizeKey, [NSValue valueWithCGSize:flexFixedSize], OBJC_ASSOCIATION_RETAIN);
}

- (void)setSizeThatFitsBlock:(CGSize (^)(CGSize))sizeThatFitsBlock
{
    objc_setAssociatedObject(self, &FLEXBOXSizeThatFitsBlock, [sizeThatFitsBlock copy], OBJC_ASSOCIATION_COPY);
}

- (CGSize (^)(CGSize))sizeThatFitsBlock
{
    return objc_getAssociatedObject(self, &FLEXBOXSizeThatFitsBlock);
}

- (CGSize)flexComputeSize:(CGSize)bounds
{
    if (!CGSizeEqualToSize(self.flexFixedSize, CGSizeZero))
        return self.flexFixedSize;
    
    bounds.height = isnan(bounds.height) ? FLT_MAX : bounds.height;
    bounds.width = isnan(bounds.width) ? FLT_MAX : bounds.width;
    
    CGSize size = CGSizeZero;
    
    if (self.sizeThatFitsBlock != nil) {
        size = self.sizeThatFitsBlock(bounds);
    } else {
         size = [self sizeThatFits:bounds];
    }
    
    CGSize max = self.flexMaximumSize;
    if (!CGSizeEqualToSize(max, CGSizeZero) || !CGSizeEqualToSize(max, (CGSize){FLT_MAX, FLT_MAX})) {
        size.height = !isnan(max.height) && fabs(max.height) > FLT_EPSILON  && size.height > max.height ? max.height : size.height;
        size.width = !isnan(max.width) && fabs(max.width) > FLT_EPSILON  && size.width > max.width ? max.width : size.width;
    }
    
    CGSize min = self.flexMinimumSize;
    if (!CGSizeEqualToSize(min, CGSizeZero) || !CGSizeEqualToSize(max, (CGSize){FLT_MIN, FLT_MIN})) {
        size.height = !isnan(min.height) && fabs(min.height) > FLT_EPSILON && size.height < min.height ? min.height : size.height;
        size.width = !isnan(min.width) && fabs(min.width) > FLT_EPSILON && size.width < min.width ? min.width : size.width;
    }

    return size;
}

- (void)flexLayoutSubviews
{
    FLEXBOXNode *node = self.flexNode;
    node.dimensions = self.bounds.size;
    
    [node layoutConstrainedToMaximumWidth:self.bounds.size.width];
    
    for (NSUInteger i = 0; i < node.childrenCountBlock(); i++) {
        
        UIView *subview = self.subviews[i];
        FLEXBOXNode *subnode = node.childrenAtIndexBlock(i);
        subview.frame = CGRectIntegral(subnode.frame);
    }
    
    self.frame = (CGRect){self.frame.origin, node.frame.size};
}


#pragma mark - Properties

- (FLEXBOXFlexDirection)flexDirection
{
    return self.flexNode.flexDirection;
}

- (void)setFlexDirection:(FLEXBOXFlexDirection)flexDirection
{
    self.flexNode.flexDirection = flexDirection;
}

- (UIEdgeInsets)flexMargin
{
    return self.flexNode.margin;
}

- (void)setFlexMargin:(UIEdgeInsets)flexMargin
{
    self.flexNode.margin = flexMargin;
}

- (UIEdgeInsets)flexPadding
{
    return self.flexNode.padding;
}

- (void)setFlexPadding:(UIEdgeInsets)flexPadding
{
    self.flexNode.padding = flexPadding;
}

- (BOOL)flexWrap
{
    return self.flexNode.flexWrap;
}

- (void)setFlexWrap:(BOOL)flexWrap
{
    self.flexNode.flexWrap = flexWrap;
}

- (FLEXBOXJustification)flexJustifyContent
{
    return self.flexNode.justifyContent;
}

- (void)setFlexJustifyContent:(FLEXBOXJustification)flexJustifyContent
{
    self.flexNode.justifyContent = flexJustifyContent;
}

- (FLEXBOXAlignment)flexAlignSelf
{
    return self.flexNode.alignSelf;
}

- (void)setFlexAlignSelf:(FLEXBOXAlignment)flexAlignSelf
{
    self.flexNode.alignSelf = flexAlignSelf;
}

- (FLEXBOXAlignment)flexAlignItems
{
    return self.flexNode.alignItems;
}

- (void)setFlexAlignItems:(FLEXBOXAlignment)flexAlignItems
{
    self.flexNode.alignItems = flexAlignItems;
}

- (CGFloat)flex
{
    return self.flexNode.flex;
}

- (void)setFlex:(CGFloat)flex
{
    self.flexNode.flex = flex;
}

- (CGSize)flexMinimumSize
{
    return self.flexNode.minDimensions;
}

- (void)setFlexMinimumSize:(CGSize)flexMinimumSize
{
    self.flexNode.minDimensions = flexMinimumSize;
}

- (CGSize)flexMaximumSize
{
    return self.flexNode.maxDimensions;
}

- (void)setFlexMaximumSize:(CGSize)flexMaximumSize
{
    self.flexNode.maxDimensions = flexMaximumSize;
}

- (FLEXBOXContentDirection)flexContentDirection
{
    return self.flexNode.contentDirection;
}

- (void)setFlexContentDirection:(FLEXBOXContentDirection)flexContentDirection
{
    self.flexNode.contentDirection = flexContentDirection;
}

@end
